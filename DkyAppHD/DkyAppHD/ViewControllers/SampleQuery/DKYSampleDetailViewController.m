//
//  DKYSampleDetailViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailViewController.h"
#import "DKYSampleDetailTypeViewCell.h"
#import "DKYSampleModel.h"
#import "DKYSampleProductInfoModel.h"

@interface DKYSampleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@property (nonatomic, strong) DKYSampleProductInfoModel *sampleProductInfo;

@end

@implementation DKYSampleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
    
    [self getProductInfoFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
}

#pragma mark - 网络请求

- (void)getProductInfoFromServer{
    WeakSelf(weakSelf);
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    p.Id = @(self.sampleModel.mProductId);
    
    [[DKYHttpRequestManager sharedInstance] getProductInfoWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.sampleProductInfo = [DKYSampleProductInfoModel mj_objectWithKeyValues:result.data];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];

}

#pragma mark - UI

- (void)commonInit{
    [self setupCustomTitle:@"产品详情"];
    
    [self setupTableView];
}

- (void)setupTableView{
    NSString *identify = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    switch (indexPath.row) {
        case 0:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
            break;
            
        default:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
            break;
    }
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        DKYSampleDetailTypeViewCell *newCell = (DKYSampleDetailTypeViewCell*)cell;
        newCell.model = [[NSObject alloc] init];
    }];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
        }
            break;
        case 1:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
        }
            break;
        case 2:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
        }
            break;
            
        default:
            break;
    }
    DKYSampleDetailTypeViewCell *newCell = (DKYSampleDetailTypeViewCell*)cell;
    newCell.model = [[NSObject alloc] init];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
