//
//  DKYCustomOrderUIViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderUIViewController.h"
#import "DKYOrderActionsView.h"
#import "DKYCustomOrderViewCell.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYCustomOrderBusinessCell.h"
#import "DKYProductApproveTitleModel.h"
#import "DKYAddProductApproveParameter.h"

@interface DKYCustomOrderUIViewController ()<UITableViewDelegate,UITableViewDataSource>

// UI
@property (nonatomic, weak)TWScrollView  *scrollView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) DKYOrderActionsView *actionsView;

// 业务逻辑

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitle;
@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, assign) BOOL firstLoad;
@property (nonatomic, assign) BOOL needUpdate;

// 测试控件
@property (nonatomic, weak) UILabel *testLabel;

@end

@implementation DKYCustomOrderUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    if(!self.firstLoad){
//        [self getProductApproveTitleFromServer];
//        self.firstLoad = YES;
//    }
    if(self.needUpdate){
        [self getProductApproveTitleFromServer];
    }
}

#pragma mark mark - 网络请求
- (void)getProductApproveTitleFromServer{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] getProductApproveTitleWithParameter:nil Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.needUpdate = NO;
            weakSelf.productApproveTitle = [DKYProductApproveTitleModel mj_objectWithKeyValues:result.data];
            weakSelf.addProductApproveParameter = [[DKYAddProductApproveParameter alloc] init];
            [weakSelf.tableView reloadData];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - private method
- (void)showOptionsPicker{
    [self.view endEditing:YES];
    MMPopupItemHandler block = ^(NSInteger index){
        DLog(@"++++++++ index = %ld",index);
    };
    
    NSArray *item = @[@"1",@"2",@"3",@"4",@"5"];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:item.count + 1];
    for (NSString *str in item) {
        [items addObject:MMItemMake(str, MMItemTypeNormal, block)];
    }

    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"点击选择内容"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

- (BOOL)checkForAddProductApprove{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    DKYCustomOrderViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    DKYMadeInfoByProductNameModel *madeInfoByProductName = cell.madeInfoByProductName;
    
    //当挂件袖肥下拉框不隐藏时，判断性别下拉框值为（20或21）同时款号默认性别值mDim13Id为（20或21），提示“挂件袖肥的值不能为空”
    if(self.addProductApproveParameter.needGjxf && (([self.addProductApproveParameter.mDimNew13Id integerValue] == 20 ||
                                                    [self.addProductApproveParameter.mDimNew13Id integerValue] == 21)&&
                                                    (madeInfoByProductName.productMadeInfoView.mDimNew13Id == 20 ||
                                                    madeInfoByProductName.productMadeInfoView.mDimNew13Id == 21))){
                                                        if(self.addProductApproveParameter.mDimNew18Id == nil){
                                                            [DKYHUDTool showInfoWithStatus:@"挂件袖肥的值不能为空"];
                                                            return NO;
                                                        }
    }
    
    return YES;
}
#pragma mark - UI

- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"定制下单"];
    
    self.needUpdate = YES;
    
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupTableView];
    [self setupActionView];
    
#pragma mark mark - 测试代码
    
#ifndef DEBUG
    self.tableView.hidden = YES;
    self.actionsView.hidden = YES;
    [self setupTestLabel];
#endif
    
//    [self setupScrollView];
}

- (void)setupTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
}

- (void)setupActionView{
    DKYOrderActionsView *actionView = [DKYOrderActionsView orderActionsView];
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
        // 基础下单
        // 1.先检查逻辑
        if(![weakSelf checkForAddProductApprove]) return;
        
        // 2.调用下单接口
    };
    
    actionView.reWriteBtnClicked = ^(UIButton *sender){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        DKYCustomOrderViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        [cell reset];
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

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return 240;
    
    return 2250;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        DKYCustomOrderBusinessCell *cell = [DKYCustomOrderBusinessCell customOrderBusinessCellWithTableView:tableView];
        cell.productApproveTitleModel = self.productApproveTitle;
        return cell;
    }
    
    WeakSelf(weakSelf);
    DKYCustomOrderViewCell *cell= [DKYCustomOrderViewCell customOrderViewCellWithTableView:tableView];
    cell.addProductApproveParameter = self.addProductApproveParameter;
    cell.productApproveTitleModel = self.productApproveTitle;
    cell.refreshBlock = ^(id sender){
        [weakSelf getProductApproveTitleFromServer];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Test
- (void)setupScrollView{
    TWScrollView *scrollView = [[TWScrollView alloc]init];
    scrollView.scrollViewType = TWScrollViewType_Vertical;
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentView.backgroundColor = [UIColor whiteColor];
    WeakSelf(weakSelf);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    [self.scrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(kScreenHeight - kNavigationBarHeight));
    }];
    
    [self setupActionsView];
}

- (void)setupActionsView{
    DKYOrderActionsView *actionView = [DKYOrderActionsView orderActionsView];
    [self.scrollView.contentView addSubview:actionView];
    self.actionsView = actionView;
    
    WeakSelf(weakSelf);
    [self.actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.scrollView.contentView);
        make.right.mas_equalTo(weakSelf.scrollView.contentView);
        make.bottom.mas_equalTo(weakSelf.scrollView.contentView).with.offset(-40);
        make.height.mas_equalTo(115);
    }];
}

#pragma mark mark - 测试代码
- (void)setupTestLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    self.testLabel = label;
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    label.text = @"敬请期待！";
}

@end
