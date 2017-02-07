//
//  DKYOrderInquiryViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInquiryViewController.h"
#import "DKYOrderInquiryHeaderView.h"
#import "WGBDatePickerView.h"
#import "DKYDatePickerView.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYOrderInfoHeaderView.h"
#import "DKYOrderInquiryViewCell.h"
#import "DKYOrderBrowseViewController.h"
#import "DKYOrderBrowseView.h"
#import "DKYOrderItemModel.h"
#import "DKYOrderAuditStatusModel.h"
#import "DKYOrderInquiryParameter.h"
#import "DKYOrderItemDetailModel.h"

@interface DKYOrderInquiryViewController ()<UITableViewDelegate,UITableViewDataSource,WGBDatePickerViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) DKYOrderInquiryHeaderView *headerView;

@property (nonatomic, strong) DKYOrderInfoHeaderView *sectionHeaderView;

@property (nonatomic,strong) WGBDatePickerView *datePickView;

@property (nonatomic, strong) NSMutableArray *orders;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) NSArray *orderAuditStatusModels;

// 查询的4个条件
@property (nonatomic, strong) DKYOrderAuditStatusModel *selectedOrderAuditStatusModel;
@property (nonatomic, copy) NSString *czDate;
@property (nonatomic, copy) NSString *customer;
@property (nonatomic, copy) NSString *pdt;

// 批量预览的数据
@property (nonatomic, strong) NSMutableArray *selectedOrders;

@property (nonatomic, strong) NSArray *detailOrders;

@end

@implementation DKYOrderInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
//    self.headerView.clientTextField.text = @"陈";
//    self.headerView.sampleTextField.text = @"2326";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)productApprovePageFromServer{
    WeakSelf(weakSelf);
//    dispatch_group_enter(self.group);
    DKYOrderInquiryParameter *p = [[DKYOrderInquiryParameter alloc] init];
    self.pageNum = 1;
    p.pageNo = @(self.pageNum);
    p.pageSize = @(kPageSize);
    p.czDate = self.czDate;
    p.customer = self.customer;
    p.pdt = self.pdt;
    p.isapprove = self.selectedOrderAuditStatusModel ? @(self.selectedOrderAuditStatusModel.statusCode) : nil;
    
    [[DKYHttpRequestManager sharedInstance] productApprovePageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.tableView.mj_header endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *samples = [DKYOrderItemModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.selectedOrders removeAllObjects];
            [weakSelf.orders removeAllObjects];
            [weakSelf.orders addObjectsFromArray:samples];
            [weakSelf.tableView reloadData];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
//        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.tableView.mj_header endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
//        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)loadMoreProductApprovePageFromServer{
    WeakSelf(weakSelf);
    //    dispatch_group_enter(self.group);
    DKYOrderInquiryParameter *p = [[DKYOrderInquiryParameter alloc] init];
    NSInteger pageNum = self.pageNum;
    p.pageNo = @(++pageNum);
    p.pageSize = @(kPageSize);
    p.czDate = self.czDate;
    p.customer = self.customer;
    p.isapprove = self.selectedOrderAuditStatusModel ? @(self.selectedOrderAuditStatusModel.statusCode) : nil;
    
    [[DKYHttpRequestManager sharedInstance] productApprovePageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *samples = [DKYOrderItemModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.orders addObjectsFromArray:samples];
            weakSelf.pageNum++;
            [weakSelf.tableView reloadData];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        //        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.tableView.mj_footer endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        //        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)productApproveInfoListFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    
    NSMutableArray *mids = [NSMutableArray arrayWithCapacity:self.detailOrders.count];
    for (DKYOrderItemModel *item in self.selectedOrders) {
        [mids addObject:@(item.Id)];
    }
    p.ids = [mids copy];
    
    [[DKYHttpRequestManager sharedInstance] productApproveInfoListWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.detailOrders = [DKYOrderItemDetailModel mj_objectArrayWithKeyValuesArray:result.data];
            [weakSelf showOrderPreview];
        }else if (retCode == DkyHttpResponseCode_Unset) {
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

#pragma mark - private method

- (void)showFaxDateSelectedPicker{
    //        DKYDatePickerView *pic = [[DKYDatePickerView alloc] init];
    //        pic.doneBlock = ^(DKYDatePickerView *picker, DkyButtonStatusType type){
    //            DLog(@"%@",picker.selectedDate);
    //        };
    //        [pic show];
    [self.view endEditing:YES];
    [self.datePickView show];
}

- (void)showAuditStatusSelectedPicker{
    WeakSelf(weakSelf);
    [self.view endEditing:YES];
    MMPopupItemHandler block = ^(NSInteger index){
        weakSelf.selectedOrderAuditStatusModel = [weakSelf.orderAuditStatusModels objectOrNilAtIndex:index];
        
        NSString *displayName = [NSString stringWithFormat:@"  %@",weakSelf.selectedOrderAuditStatusModel.statusName ?:@""];
        weakSelf.headerView.auditStatusLabel.text = displayName;
    };
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:self.orderAuditStatusModels.count + 1];
    for (DKYOrderAuditStatusModel *model in self.orderAuditStatusModels) {
        [items addObject:MMItemMake(model.statusName, MMItemTypeNormal, block)];
    }
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"审核状态"
                                                          items:[items copy]];
//    sheetView.attachedView = self.view;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

- (void)showOrderPreview{
//    DKYOrderBrowseViewController *vc = [[DKYOrderBrowseViewController alloc] init];
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    vc.modalPresentationStyle = UIModalPresentationPopover;
//    vc.preferredContentSize = CGSizeMake(514, 610);
//    UIPopoverPresentationController *popover = vc.popoverPresentationController;
//    popover.sourceView = self.view;
//    [self presentViewController:vc animated:YES completion:nil];
    [self.view endEditing:YES];
    DKYOrderBrowseView *browseView = [DKYOrderBrowseView show];
    browseView.detailOrders = self.detailOrders;
}

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    
    [self setupCustomTitle:@"订单查询"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    
    [self setupHeaderView];
    [self setupTableView];
}

- (void)setupHeaderView{
    WeakSelf(weakSelf);
    DKYOrderInquiryHeaderView *header = [DKYOrderInquiryHeaderView orderInquiryHeaderView];
//    header.bounds = CGRectMake(0, 0, kScreenWidth, 300);
//    self.tableView.tableHeaderView = header;
    [self.view addSubview:header];
    self.headerView = header;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).with.offset(64);
        make.height.mas_equalTo(300);
    }];
    
    header.faxDateBlock = ^(id sender){
        [weakSelf showFaxDateSelectedPicker];
    };
    
    header.auditStatusBlock = ^(id sender){
        [weakSelf showAuditStatusSelectedPicker];
    };
    
    header.batchPreviewBtnClicked = ^(id sender){
        if(weakSelf.selectedOrders.count == 0){
            [DKYHUDTool showInfoWithStatus:@"请至少选择一条订单记录"];
            return ;
        }
        [weakSelf productApproveInfoListFromServer];
    };
    
    header.findBtnClicked = ^(id sender){
        weakSelf.pdt = weakSelf.headerView.sampleTextField.text;
        weakSelf.customer =weakSelf.headerView.clientTextField.text;
        if(weakSelf.pdt .length == 0){
            weakSelf.pdt = nil;
        }
        if(weakSelf.customer.length == 0){
            weakSelf.customer = nil;
        }
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    
    header.deleteBtnClicked = ^(id sender){
        weakSelf.headerView.faxDateLabel.text = @"";
        weakSelf.headerView.clientTextField.text = @"";
        weakSelf.headerView.sampleTextField.text = @"";
        weakSelf.headerView.auditStatusLabel.text = @"";
        weakSelf.selectedOrderAuditStatusModel = nil;
        weakSelf.czDate = nil;
        weakSelf.customer = nil;
        weakSelf.pdt = nil;
    };
    
    header.headerView.taped = ^(id sender,BOOL selected){
        for (DKYOrderItemModel *item in self.orders) {
            item.selected = selected;
            if(item.selected){
                [weakSelf.selectedOrders addObject:item];
            }else{
                [weakSelf.selectedOrders removeObject:item];
            }
        }
        
        [weakSelf.tableView reloadData];
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
        make.bottom.mas_equalTo(weakSelf.view);
    }];
    
    
    [self setupRefreshControl];
}

-(void)setupRefreshControl{
    WeakSelf(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(){
        [weakSelf productApprovePageFromServer];
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf loadMoreProductApprovePageFromServer];
    }];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
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
    return self.orders.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYOrderInquiryViewCell *cell = [DKYOrderInquiryViewCell orderInquiryViewCellWithTableView:tableView];
    cell.headerView = self.headerView;
    cell.itemModel = [self.orders objectOrNilAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DKYOrderItemModel *itemModel = [self.orders objectOrNilAtIndex:indexPath.row];
    itemModel.selected = !itemModel.selected;
    
    if(itemModel.selected){
        [self.selectedOrders addObject:itemModel];
    }else{
        [self.selectedOrders removeObject:itemModel];
    }
    
    [self.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark- <WGBDatePickerViewDelegate>
//当时间改变时触发
- (void)changeTime:(NSDate *)date{
   
}

//确定时间
- (void)determine:(NSDate *)date{
    DLog(@"选中时间 = %@",[self.datePickView stringFromDate:date]);
    self.czDate = [self.datePickView stringFromDate:date];
    self.headerView.faxDateLabel.text = [NSString stringWithFormat:@"   %@",self.czDate];
}

#pragma mark - get & set method
- (WGBDatePickerView *)datePickView{
    if (!_datePickView) {
        _datePickView =[[WGBDatePickerView alloc] initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _datePickView.delegate = self;
        _datePickView.title =@"传真日期";
    }
    return _datePickView;
}

- (DKYOrderInfoHeaderView*)sectionHeaderView{
    if(_sectionHeaderView == nil){
        DKYOrderInfoHeaderView *header = [DKYOrderInfoHeaderView orderInfoHeaderViewWithTableView:nil];
        self.sectionHeaderView = header;
    }
    return _sectionHeaderView;
}

#pragma mark - get & set method

- (NSMutableArray*)orders{
    if(_orders == nil){
        _orders = [NSMutableArray array];
    }
    return _orders;
}

// orderAuditStatusModels
- (NSArray*)orderAuditStatusModels{
    if(_orderAuditStatusModels == nil){
        DKYOrderAuditStatusModel *model1 = [DKYOrderAuditStatusModel orderAuditStatusModelMakeWithName:@"审核中" code:DKYOrderAuditStatusType_Auding];
        DKYOrderAuditStatusModel *model2 = [DKYOrderAuditStatusModel orderAuditStatusModelMakeWithName:@"审核通过" code:DKYOrderAuditStatusType_Success];
        DKYOrderAuditStatusModel *model3 = [DKYOrderAuditStatusModel orderAuditStatusModelMakeWithName:@"审核不通过" code:DKYOrderAuditStatusType_Fail];
        _orderAuditStatusModels = @[model1,model2,model3];
    }
    return _orderAuditStatusModels;
}

- (NSMutableArray*)selectedOrders{
    if(_selectedOrders == nil){
        _selectedOrders = [NSMutableArray array];
    }
    return _selectedOrders;
}

@end
