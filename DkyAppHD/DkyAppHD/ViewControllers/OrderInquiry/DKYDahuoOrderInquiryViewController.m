//
//  DKYDahuoOrderInquiryViewController.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDahuoOrderInquiryViewController.h"
#import "DKYDahuoOrderInquiryHeaderView.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYDahuoOrderInquiryViewCell.h"
#import "DKYOrderBrowseViewController.h"
#import "DKYOrderBrowseView.h"
#import "DKYOrderItemModel.h"
#import "DKYOrderAuditStatusModel.h"
#import "DKYOrderInquiryParameter.h"
#import "DKYOrderItemDetailModel.h"
#import "DKYDahuoOrderInquiryParameter.h"

@interface DKYDahuoOrderInquiryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) DKYDahuoOrderInquiryHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *orders;

@property (nonatomic, assign) NSInteger pageNum;

// 查询的3个条件
/**
 * 款号
 */
@property (nonatomic, copy) NSString *productName;

/**
 * 颜色
 */
@property (nonatomic, copy) NSString *colorName;

/**
 * 尺寸
 */
@property (nonatomic, copy) NSString *sizeName;

// 批量预览的数据
@property (nonatomic, strong) NSMutableArray *selectedOrders;

@property (nonatomic, strong) NSArray *detailOrders;

@end

@implementation DKYDahuoOrderInquiryViewController

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
- (void)productApproveBmptPageFromServer{
    WeakSelf(weakSelf);
    //    dispatch_group_enter(self.group);
    DKYDahuoOrderInquiryParameter *p = [[DKYDahuoOrderInquiryParameter alloc] init];
    self.pageNum = 1;
    p.pageNo = @(self.pageNum);
    p.pageSize = @(kPageSize);
    p.productName = self.productName;
    p.colorName = self.colorName;
    p.sizeName = self.sizeName;
    
    
    [[DKYHttpRequestManager sharedInstance] productApproveBmptPageWithParameter:p Success:^(NSInteger statusCode, id data) {
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
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
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

- (void)loadMoreProductApproveBmptPageFromServer{
    WeakSelf(weakSelf);
    //    dispatch_group_enter(self.group);
    DKYDahuoOrderInquiryParameter *p = [[DKYDahuoOrderInquiryParameter alloc] init];
    NSInteger pageNum = self.pageNum;
    p.pageNo = @(++pageNum);
    p.pageSize = @(kPageSize);
    
    p.productName = self.productName;
    p.colorName = self.colorName;
    p.sizeName = self.sizeName;

    [[DKYHttpRequestManager sharedInstance] productApproveBmptPageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *samples = [DKYOrderItemModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.orders addObjectsFromArray:samples];
            weakSelf.pageNum++;
            [weakSelf.tableView reloadData];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
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

- (void)updateProductApproveToServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    
    NSMutableArray *mids = [NSMutableArray arrayWithCapacity:self.detailOrders.count];
    for (DKYOrderItemModel *item in self.selectedOrders) {
        [mids addObject:@(item.Id)];
    }
    p.ids = [mids copy];
    
    [[DKYHttpRequestManager sharedInstance] updateProductApproveWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            [DKYHUDTool showSuccessWithStatus:@"删除订单成功!"];
            [weakSelf.orders removeObjectsInArray:weakSelf.selectedOrders];
            [weakSelf.selectedOrders removeAllObjects];
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

#pragma mark - private method

- (void)showOrderPreview{
    [self.view endEditing:YES];
    DKYOrderBrowseView *browseView = [DKYOrderBrowseView show];
    browseView.detailOrders = self.detailOrders;
}

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    
    [self setupCustomTitle:@"订单查询"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupHeaderView];
    [self setupTableView];
}

- (void)setupHeaderView{
    WeakSelf(weakSelf);
    DKYDahuoOrderInquiryHeaderView *header = [DKYDahuoOrderInquiryHeaderView orderInquiryHeaderView];

    [self.view addSubview:header];
    self.headerView = header;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).with.offset(0);
        make.height.mas_equalTo(300);
    }];

    header.batchPreviewBtnClicked = ^(id sender){
        if(weakSelf.selectedOrders.count == 0){
            [DKYHUDTool showInfoWithStatus:@"请至少选择一条订单记录"];
            return ;
        }
        [weakSelf productApproveInfoListFromServer];
    };
    
    header.findBtnClicked = ^(id sender){
        weakSelf.productName = weakSelf.headerView.kuanhaoTextField.text;
        weakSelf.colorName =weakSelf.headerView.colorTextField.text;
        weakSelf.sizeName =weakSelf.headerView.sizeTextField.text;
        
        if(weakSelf.productName .length == 0){
            weakSelf.productName = nil;
        }
        if(weakSelf.colorName.length == 0){
            weakSelf.colorName = nil;
        }
        
        if(weakSelf.sizeName.length == 0){
            weakSelf.sizeName = nil;
        }
        
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    
    header.deleteBtnClicked = ^(id sender){
        [weakSelf updateProductApproveToServer];
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
        [weakSelf productApproveBmptPageFromServer];
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf loadMoreProductApproveBmptPageFromServer];
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
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYDahuoOrderInquiryViewCell *cell = [DKYDahuoOrderInquiryViewCell orderInquiryViewCellWithTableView:tableView];
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

#pragma mark - get & set method

- (NSMutableArray*)orders{
    if(_orders == nil){
        _orders = [NSMutableArray array];
    }
    return _orders;
}

- (NSMutableArray*)selectedOrders{
    if(_selectedOrders == nil){
        _selectedOrders = [NSMutableArray array];
    }
    return _selectedOrders;
}


@end
