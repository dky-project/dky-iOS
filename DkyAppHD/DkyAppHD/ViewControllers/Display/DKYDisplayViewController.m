//
//  DKYDisplayViewController.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayViewController.h"
#import "DKYDisplayHeaderView.h"
#import "DKYDisplayImageViewCell.h"
#import "DKYDisplayCategoryViewCell.h"
#import "DKYDisplaySumViewCell.h"
#import "DKYDisplayActionView.h"
#import "DKYDisplayCategoryDahuoViewCell.h"
#import "DKYGetProductListByGroupNoParameter.h"
#import "DKYGetProductListByGroupNoModel.h"

@interface DKYDisplayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) DKYDisplayHeaderView *headerView;

@property (nonatomic, weak) DKYDisplayActionView *actionsView;

@property (nonatomic, strong) DKYGetProductListByGroupNoParameter *getProductListByGroupNoParameter;
@property (nonatomic, strong) NSArray *productList;

@end

@implementation DKYDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)getProductListByGroupNoFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    [[DKYHttpRequestManager sharedInstance] getProductListByGroupNoWithParameter:self.getProductListByGroupNoParameter Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.productList = [DKYGetProductListByGroupNoModel mj_objectArrayWithKeyValuesArray:result.data];
            
            [weakSelf.tableView reloadData];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        [DKYHUDTool dismiss];
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0) return self.productList ? 1 : 0;
    
    return self.productList.count > 0 ? self.productList.count + 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0) return CGFLOAT_MIN;
    
    return 24;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0) return (self.productList.count >4) ? 825 : 550;
    
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        DKYDisplayImageViewCell *cell = [DKYDisplayImageViewCell displayImageViewCellWithTableView:tableView];
        cell.productList = self.productList;
        return cell;
    }
    
    if(indexPath.section == 1 && indexPath.row == self.productList.count){
        DKYDisplaySumViewCell *cell = [DKYDisplaySumViewCell displaySumViewCellWithTableView:tableView];
        return cell;
    }
    
    DKYGetProductListByGroupNoModel *model = [self.productList objectAtIndex:indexPath.row];
    if([model.mptbelongtype caseInsensitiveCompare:@"C"] == NSOrderedSame){
        DKYDisplayCategoryDahuoViewCell *cell = [DKYDisplayCategoryDahuoViewCell displayCategoryDahuoViewCellWithTableView:tableView];
        cell.getProductListByGroupNoModel = [self.productList objectAtIndex:indexPath.row];
        return cell;
    }

    DKYDisplayCategoryViewCell *cell = [DKYDisplayCategoryViewCell displayCategoryViewCellWithTableView:tableView];
    cell.getProductListByGroupNoModel = [self.productList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UI
- (void)commonInit{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"搭配"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupHeaderView];
    
    [self setupTableView];
    
    [self setupActionView];
}

- (void)setupHeaderView{
    DKYDisplayHeaderView *headerView = [[DKYDisplayHeaderView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:headerView];
    
    self.headerView = headerView;
    
    WeakSelf(weakSelf);
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(110);
    }];
    
    self.headerView.getProductListByGroupNoParameter = self.getProductListByGroupNoParameter;
    
    self.headerView.searchBtnClicked = ^(id sender) {
        if(![weakSelf.getProductListByGroupNoParameter.groupNo isNotBlank]){
            [DKYHUDTool showErrorWithStatus:@"组号不能为空"];
            return;
        }
        
        [weakSelf.view endEditing:YES];
        
        [weakSelf getProductListByGroupNoFromServer];
    };
    
    self.headerView.preBtnClicked = ^(id sender) {
        
    };
    
    self.headerView.nextBtnClicked = ^(id sender) {
        
    };
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.headerView.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.view).with.offset(-105);
    }];
}


- (void)setupActionView{
    DKYDisplayActionView *actionView = [DKYDisplayActionView displayActionViewView];
    [self.view addSubview:actionView];
    self.actionsView = actionView;
    WeakSelf(weakSelf);
    [self.actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
    }];
    
    actionView.confirmBtnClicked = ^(UIButton* sender){
        
    };
    
    actionView.saveBtnClicked = ^(UIButton *sender){
        
    };
}

- (void)setupCustomTitle:(NSString*)title;
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName : titleLabel.font};
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    titleLabel.frame = [title boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

- (DKYGetProductListByGroupNoParameter*)getProductListByGroupNoParameter{
    if(_getProductListByGroupNoParameter == nil){
        _getProductListByGroupNoParameter = [[DKYGetProductListByGroupNoParameter alloc] init];
    }
    return _getProductListByGroupNoParameter;
}

@end
