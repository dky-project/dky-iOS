//
//  DKYSampleOrderPopupView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderPopupView.h"
#import "KLCPopup.h"
#import "DKYSampleOrderViewCell.h"
#import "DKYSampleProductInfoModel.h"
#import "DKYProductApproveTitleModel.h"
#import "DKYAddProductApproveParameter.h"
#import "DKYOrderBrowseModel.h"
#import "DKYOrderBrowsePopupView.h"
#import "DQTableViewCell.h"
#import "DKYGetColorDimListParameter.h"
#import "DKYColorDimListModel.h"
#import "DkySampleOrderImageViewCell.h"

@interface DKYSampleOrderPopupView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) KLCPopup *popup;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *cancelBtn;

@property (nonatomic, weak) UIButton *confirmBtn;

// 业务逻辑
@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitle;
@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, strong) DKYOrderBrowseModel *orderBrowseModel;

@property (nonatomic, strong) NSArray *dimListModels;
@property (nonatomic, strong) NSArray *sampleValueArray;

@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, copy) NSString *imageUrl;

@end

@implementation DKYSampleOrderPopupView

+ (instancetype)show{
    DKYSampleOrderPopupView *contentView = [[DKYSampleOrderPopupView alloc]initWithFrame:CGRectZero];
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeFadeOut
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.6;
    contentView.popup = popup;
    
    [popup show];
    return contentView;
}

+ (instancetype)showWithSampleProductInfoModel:(DKYSampleProductInfoModel *)sampleProductInfo{
    DKYSampleOrderPopupView *contentView = [[DKYSampleOrderPopupView alloc]initWithFrame:CGRectZero];
    contentView.sampleProductInfo = sampleProductInfo;
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.6;
    contentView.popup = popup;
    
    popup.didFinishShowingCompletion = ^(){
        [contentView doHttpRequest];
    };
    [popup show];
    return contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dismiss{
    [self.popup dismiss:YES];
}

- (void)getProductApproveTitleFromServer{
    dispatch_group_enter(self.group);
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] getProductApproveTitleWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.productApproveTitle = [DKYProductApproveTitleModel mj_objectWithKeyValues:result.data];
            weakSelf.addProductApproveParameter = [[DKYAddProductApproveParameter alloc] init];
            DKYSampleOrderViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.productApproveTitleModel = weakSelf.productApproveTitle;
            cell.addProductApproveParameter = weakSelf.addProductApproveParameter;
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [DKYHUDTool dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            [DKYHUDTool dismiss];
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)getColorDimListFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    DKYGetColorDimListParameter *p = [[DKYGetColorDimListParameter alloc] init];
    p.mProductId = weakSelf.sampleProductInfo.mProductId;
    
    [[DKYHttpRequestManager sharedInstance] getColorDimListWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.dimListModels = [DKYColorDimListModel mj_objectArrayWithKeyValuesArray:result.data];
            [weakSelf setupSampleValueArray];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [DKYHUDTool dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            [DKYHUDTool dismiss];
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
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
    [[DKYHttpRequestManager sharedInstance] addProductDefaultWithParameter:self.addProductApproveParameter Success:^(NSInteger statusCode, id data) {
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
            pop.orderBrowseModel = weakSelf.orderBrowseModel;
            
            return;
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

- (void)doHttpRequest{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    [self getProductApproveTitleFromServer];
    [self getColorDimListFromServer];
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [DKYHUDTool dismiss];
        [weakSelf.tableView reloadData];
    });
}

- (void)clearDataAndUI{
    [self.popup dismiss:YES];
}

#pragma mark - action method

- (void)closeBtnClicked:(UIButton*)sender{
    [self dismiss];
}

- (void)confirmBtnClicked:(UIButton*)sender{
    // 样衣详情下单下单
    // 1.获取参数
    [self fetchAddProductApproveInfo];
    // 2.先检查逻辑
    if(![self checkForAddProductApprove]) return;
    
    [self endEditing:YES];
    // 3.调用下单接口
    [self addProductApproveToServer];
}

- (void)fetchAddProductApproveInfo{
    NSRange range = [self.addProductApproveParameter.mobile rangeOfString:@"("];
    if(range.location != NSNotFound){
        self.addProductApproveParameter.mobile = [self.addProductApproveParameter.mobile substringToIndex:range.location];
    }
    
    self.addProductApproveParameter.docno = self.productApproveTitle.orderNo;
}

- (BOOL)checkForAddProductApprove{
    // 客户不能为空、手机号不能为空、性别不能为空、胸围不能为空
    if(![self.addProductApproveParameter.customer isNotBlank]){
        [DKYHUDTool showInfoWithStatus:@"客户不能为空"];
        return NO;
    }
    
    if(![self.addProductApproveParameter.mobile isNotBlank]){
        [DKYHUDTool showInfoWithStatus:@"手机号不能为空"];
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
    
    NSArray *selectedColors = [self.addProductApproveParameter.colorArr componentsSeparatedByString:@";"];
    if(selectedColors.count == 0){
        [DKYHUDTool showInfoWithStatus:@"请选择颜色！"];
        return NO;
    }
    
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

- (void)setupSampleValueArray{
    NSMutableArray *pz = [NSMutableArray arrayWithCapacity:3];
    [pz addObject:@"品种"];
    
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:3];
    [ys addObject:@"颜色"];
    
    for (DKYColorDimListModel *model in self.dimListModels) {
        [pz addObject:model.mDimNew14Text];
        [ys addObject:model.colorName];
    }
    
    self.sampleValueArray = @[[pz copy],[ys copy]];
}

#pragma mark - UI
- (void)commonInit{
//    self.bounds = CGRectMake(0, 0, 514, 610);
    
    self.bounds = CGRectMake(0, 0, 600, 712);
    self.backgroundColor = [UIColor whiteColor];
    
    self.group = dispatch_group_create();

    [self setupSampleValueArray];
    
    [self setupTitleView];
    [self setupTitleLabel];
    [self setupTableView];
    [self setupBtns];
}

- (void)setupTitleView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:view];
    self.titleView = view;
    view.backgroundColor = [UIColor colorWithHex:0x3C3362];
    WeakSelf(weakSelf);
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(60);
    }];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.titleView addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.centerX.mas_equalTo(weakSelf.titleView);
    }];
    label.text = @"下单";
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorInset = UIEdgeInsetsMake(0, 32, 0, 0);
    self.tableView = tableView;
    [self addSubview:tableView];
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleView.mas_bottom);
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
    }];
    
    [self.tableView registerClass:[DQTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DQTableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupBtns{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.cancelBtn = btn;
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    WeakSelf(weakSelf);
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleView);
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.width.mas_equalTo(60);
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.confirmBtn = btn;
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.titleView);
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return 630;
    
    if(indexPath.row == 1) return 30 + (self.dimListModels.count + 1) * 30;
    
    return 400;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(weakSelf);
    if(indexPath.row == 0){
        DKYSampleOrderViewCell *cell = [DKYSampleOrderViewCell sampleOrderViewCellWithTableView:tableView];
        cell.sampleProductInfo = self.sampleProductInfo;
        cell.productApproveTitleModel = self.productApproveTitle;
        cell.addProductApproveParameter = self.addProductApproveParameter;
        
        cell.imageBlock = ^(id sender) {
            weakSelf.imageUrl = sender;
            [weakSelf.tableView reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }else if(indexPath.row == 1){
        DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
        cell.formType = DKYFormType_TypeOne;
        cell.DataArr = (self.dimListModels.count > 1)? [self.sampleValueArray mutableCopy] : nil;
        cell.hideBottomLine = YES;
        return cell;
    }else{
        DkySampleOrderImageViewCell *cell = [DkySampleOrderImageViewCell sampleOrderImageViewCellWithTableView:tableView];
        cell.imageUrl = self.imageUrl;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
