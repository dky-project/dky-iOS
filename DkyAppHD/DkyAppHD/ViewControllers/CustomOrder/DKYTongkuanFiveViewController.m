//
//  DKYTongkuanFiveViewController.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuanFiveViewController.h"
#import "DKYOrderActionsView.h"
#import "DKYTongkuanFiveViewCell.h"
#import "DKYProductApproveTitleModel.h"
#import "DKYAddProductApproveParameter.h"
#import "DKYTongkuanFiveBusinessCell.h"
#import "DKYOrderBrowsePopupView.h"
#import "DKYOrderBrowseModel.h"

@interface DKYTongkuanFiveViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) DKYOrderActionsView *actionsView;

// 业务逻辑

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitle;
@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, strong) DKYOrderBrowseModel *orderBrowseModel;

@property (nonatomic, assign) BOOL needUpdate;

@end

@implementation DKYTongkuanFiveViewController

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
            weakSelf.addProductApproveParameter.customer = @"同款五";
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

- (void)confirmProductApproveToServer:(DKYOrderBrowsePopupView*)sender{
    [DKYHUDTool show];
    
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    p.Id = self.orderBrowseModel.productApproveId;
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] confirmProductApproveWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 生成订单成功
            [DKYHUDTool showSuccessWithStatus:@"生成订单成功!"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf clearDataAndUI];
                [sender dismiss];
            });
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

- (void)addProductApproveToServer{
    [DKYHUDTool show];
    
#ifdef DEBUG
    self.addProductApproveParameter.shRemark = @"测试单据 勿动！";
#endif
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] addProductApproveWithParameter:self.addProductApproveParameter Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 下单成功
//            [DKYHUDTool showSuccessWithStatus:@"下单成功!"];
            
            weakSelf.orderBrowseModel = [DKYOrderBrowseModel mj_objectWithKeyValues:result.data];
            
            DKYOrderBrowsePopupView *pop =[DKYOrderBrowsePopupView showWithcreateOrderBtnBlock:^(DKYOrderBrowsePopupView *sender) {
                DLog(@"生成订单");
                // 1.调用生成订单的接口
                // 2.成功之后，dismiss弹窗
                // 3.重新刷新页面
                [weakSelf confirmProductApproveToServer:sender];
            } cancelBtnBlock:^(DKYOrderBrowsePopupView* sender) {
                DLog(@"取消");
                [weakSelf clearDataAndUI];
                [sender dismiss];
            }];
            pop.orderBrowseModel = weakSelf.orderBrowseModel;            return;
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

- (void)clearDataAndUI{
    // 清空参数
    self.addProductApproveParameter = nil;
    
    // 清空数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    DKYTongkuanFiveViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell reset];
    // 重新刷新页面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getProductApproveTitleFromServer];
    });
}

- (void)fetchAddProductApproveInfo{
    NSRange range = [self.addProductApproveParameter.mobile rangeOfString:@"("];
    if(range.location != NSNotFound){
        self.addProductApproveParameter.mobile = [self.addProductApproveParameter.mobile substringToIndex:range.location];
    }
    
    self.addProductApproveParameter.jgno = self.productApproveTitle.code;
    self.addProductApproveParameter.czDate = self.productApproveTitle.czDate;
    self.addProductApproveParameter.fhDate = self.productApproveTitle.sendDate;
    
    self.addProductApproveParameter.orderNo = self.productApproveTitle.orderNo;
}

- (BOOL)checkForAddProductApprove{
    //#ifndef DEBUG
    
    // 客户不能为空、手机号不能为空、性别不能为空、胸围不能为空
    if(![self.addProductApproveParameter.customer isNotBlank]){
        [DKYHUDTool showInfoWithStatus:@"客户不能为空"];
        return NO;
    }
    
    if(![self.addProductApproveParameter.mobile isNotBlank]){
        [DKYHUDTool showInfoWithStatus:@"手机号不能为空"];
        return NO;
    }
    
    if(self.addProductApproveParameter.mDimNew13Id == nil){
        [DKYHUDTool showInfoWithStatus:@"性别不能为空"];
        return NO;
    }
    
    if(![self.addProductApproveParameter.xwValue isNotBlank]){
        [DKYHUDTool showInfoWithStatus:@"胸围不能为空"];
        return NO;
    }
    
    if(self.addProductApproveParameter.mDimNew14Id == nil){
        [DKYHUDTool showInfoWithStatus:@"品种不能为空"];
        return NO;
    }
    
    if(self.addProductApproveParameter.mDimNew12Id == nil){
        [DKYHUDTool showInfoWithStatus:@"式样不能为空"];
        return NO;
    }
    
    if(self.addProductApproveParameter.mDimNew16Id == nil){
        [DKYHUDTool showInfoWithStatus:@"针型不能为空"];
        return NO;
    }
    
    NSArray *selectedColors = [self.addProductApproveParameter.colorArr componentsSeparatedByString:@";"];
    if(selectedColors.count == 0){
        [DKYHUDTool showInfoWithStatus:@"请选择颜色！"];
        return NO;
    }
    //#endif
    
    if(self.addProductApproveParameter.defaultHzxc1Value){
        double value1 = [self.addProductApproveParameter.defaultHzxc1Value doubleValue];
        double value2 = [self.addProductApproveParameter.hzxc1Value doubleValue];
        
        if(fabs(value1 - value2) >= 4){
            [DKYHUDTool showInfoWithStatus:@"工艺袖长+-4公分变化"];
            return NO;
        }
    }
    
    if(self.addProductApproveParameter.defaultYcValue){
        double value1 = [self.addProductApproveParameter.defaultYcValue doubleValue];
        double value2 = [self.addProductApproveParameter.ycValue doubleValue];
        
        if(fabs(value1 - value2) >= 4){
            [DKYHUDTool showInfoWithStatus:@"衣长+-4公分变化"];
            return NO;
        }
    }
    
    if(self.addProductApproveParameter.defaultXcValue){
        double value1 = [self.addProductApproveParameter.defaultXcValue doubleValue];
        double value2 = [self.addProductApproveParameter.xcValue doubleValue];
        
        if(fabs(value1 - value2) >= 4){
            [DKYHUDTool showInfoWithStatus:@"袖长+-4公分变化"];
            return NO;
        }
    }
    
    return YES;
}



#pragma mark - UI

- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needUpdate = YES;
    
    [self setupTableView];
    [self setupActionView];
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
        // 同款5下单
        // 1.获取参数
        [self fetchAddProductApproveInfo];
        // 2.先检查逻辑
        if(![weakSelf checkForAddProductApprove]) return;
        
        // 3.调用下单接口
        [weakSelf addProductApproveToServer];
    };
    
    actionView.reWriteBtnClicked = ^(UIButton *sender){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        DKYTongkuanFiveViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
        [cell reset];
        // 重新刷新页面
        [weakSelf getProductApproveTitleFromServer];
    };
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
        DKYTongkuanFiveBusinessCell *cell = [DKYTongkuanFiveBusinessCell customOrderBusinessCellWithTableView:tableView];
        cell.productApproveTitleModel = self.productApproveTitle;
        cell.addProductApproveParameter = self.addProductApproveParameter;
        return cell;
    }
    
    WeakSelf(weakSelf);
    DKYTongkuanFiveViewCell *cell = [DKYTongkuanFiveViewCell tongkuanFiveViewCellWithTableView:tableView];
    cell.addProductApproveParameter = self.addProductApproveParameter;
    cell.productApproveTitleModel = self.productApproveTitle;
    cell.refreshBlock = ^(id sender){
        [weakSelf getProductApproveTitleFromServer];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
