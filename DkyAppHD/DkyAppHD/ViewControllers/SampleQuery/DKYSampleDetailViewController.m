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
#import "DQHeader.h"
#import "DKYSampleQueryParameter.h"
#import "DKYQueryPriceModel.h"
#import "DKYSampleValueInfoModel.h"
#import "DKYSampleDetailPriceViewCell.h"

@interface DKYSampleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) NSArray *queryPrices;

@property (nonatomic, strong) NSArray *priceArray;

@property (nonatomic, strong) NSArray *sampleValues;

@property (nonatomic, strong) NSArray *sampleValueArray;

@end

@implementation DKYSampleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self doHttpRequest];
}

#pragma mark - 网络请求

- (void)getProductInfoFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    p.Id = @(self.sampleModel.mProductId);
    
    [[DKYHttpRequestManager sharedInstance] getProductInfoWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.sampleProductInfo = [DKYSampleProductInfoModel mj_objectWithKeyValues:result.data];
            weakSelf.sampleProductInfo.mProductId = @(weakSelf.sampleModel.mProductId);
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)queryPriceListFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    DKYSampleQueryParameter *p = [[DKYSampleQueryParameter alloc] init];
    p.mProductId = @(self.sampleModel.mProductId);
//    p.mProductId = @(3282);
    
    [[DKYHttpRequestManager sharedInstance] queryPriceListWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.queryPrices = [DKYQueryPriceModel mj_objectArrayWithKeyValuesArray:result.data];
            [weakSelf setupPriceArray];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)queryValueFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    DKYSampleQueryParameter *p = [[DKYSampleQueryParameter alloc] init];
    p.mProductId = @(self.sampleModel.mProductId);
//    p.mProductId = @(3282);
    
    [[DKYHttpRequestManager sharedInstance] queryValueWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.sampleValues = [DKYSampleValueInfoModel mj_objectArrayWithKeyValuesArray:result.data];
            [weakSelf setupSampleValueArray];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)doHttpRequest{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    [self getProductInfoFromServer];
    [self queryPriceListFromServer];
    [self queryValueFromServer];
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [DKYHUDTool dismiss];
        [weakSelf.tableView reloadData];
    });
}

#pragma mark - private method
- (void)setupPriceArray{
    NSMutableArray *sex = [NSMutableArray arrayWithCapacity:self.queryPrices.count];
    [sex addObject:@"性别"];
    
    NSMutableArray *type = [NSMutableArray arrayWithCapacity:self.queryPrices.count];
    [type addObject:@"品种"];
    
    NSMutableArray *zhenType = [NSMutableArray arrayWithCapacity:self.queryPrices.count];
    [zhenType addObject:@"针型"];
    
    NSMutableArray *price = [NSMutableArray arrayWithCapacity:self.queryPrices.count];
    [price addObject:@"专卖店价"];
    
    for (DKYQueryPriceModel *model in self.queryPrices) {
        [sex addObject:model.mDimNew13Text];
        [type addObject:model.mDimNew14Text];
        [zhenType addObject:model.mDimNew16Text];
        [price addObject:[NSString formatRateStringWithRate:model.price]];
    }
    
    self.priceArray = @[[sex copy],[type copy],[zhenType copy],[price copy]];
}

- (void)setupSampleValueArray{
    NSMutableArray *yc = [NSMutableArray arrayWithCapacity:self.sampleValues.count];
    [yc addObject:@"衣长"];
    
    NSMutableArray *xc = [NSMutableArray arrayWithCapacity:self.sampleValues.count];
    [xc addObject:@"袖长"];
    
    NSMutableArray *jk = [NSMutableArray arrayWithCapacity:self.sampleValues.count];
    [jk addObject:@"肩宽"];
    
    NSMutableArray *xw = [NSMutableArray arrayWithCapacity:self.sampleValues.count];
    [xw addObject:@"胸围"];
    
    for (DKYSampleValueInfoModel *model in self.sampleValues) {
        [yc addObject:model.ycValue];
        [xc addObject:model.xcValue];
        [jk addObject:model.jkValue];
        [xw addObject:model.xwValue];
    }
    
    self.sampleValueArray = @[[xw copy],[yc copy],[xc copy],[jk copy]];
}

#pragma mark - UI

- (void)commonInit{
    self.group = dispatch_group_create();
    [self setupCustomTitle:@"产品详情"];
    
    [self setupTableView];
}

- (void)setupTableView{
    NSString *identify = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    [self.tableView registerClass:[DQTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DQTableViewCell class])];
    [self.tableView registerClass:[DKYSampleDetailPriceViewCell class] forCellReuseIdentifier:NSStringFromClass([DKYSampleDetailPriceViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    WeakSelf(weakSelf);
    switch (indexPath.row) {
        case 0:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
            break;
        case 1:
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                identifier = NSStringFromClass([DKYSampleDetailPriceViewCell class]);
            }else{
                identifier = NSStringFromClass([DQTableViewCell class]);
            }
            break;
        case 2:
            identifier = NSStringFromClass([DQTableViewCell class]);
            break;
        default:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
            break;
    }
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        if(indexPath.row == 0){
            DKYSampleDetailTypeViewCell *newCell = (DKYSampleDetailTypeViewCell*)cell;
            newCell.model = weakSelf.sampleProductInfo;
        }else if (indexPath.row == 2){
            DQTableViewCell *newcell = (DQTableViewCell*)cell;
            newcell.fd_enforceFrameLayout = YES;
            
            newcell.DataArr = [self.sampleValueArray mutableCopy];
        }else{
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                DKYSampleDetailPriceViewCell *newcell = (DKYSampleDetailPriceViewCell*)cell;
                newcell.sampleProductInfo = self.sampleProductInfo;
            }else{
                DQTableViewCell *newcell = (DQTableViewCell*)cell;
                newcell.fd_enforceFrameLayout = YES;
                newcell.DataArr = [self.priceArray mutableCopy];
            }
        }
    }];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
    switch (indexPath.row) {
        case 0:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
            DKYSampleDetailTypeViewCell *newCell = (DKYSampleDetailTypeViewCell*)cell;
            newCell.model = self.sampleProductInfo;
        }
            break;
        case 1:{
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                DKYSampleDetailPriceViewCell *cell = [DKYSampleDetailPriceViewCell sampleDetailPriceViewCellWithTableView:tableView];
                cell.sampleProductInfo = self.sampleProductInfo;
                return cell;
            }else{
                DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
    
                cell.DataArr = [self.priceArray mutableCopy];
                return cell;
            }
        }
            break;
        case 2:{
            DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
            
            cell.DataArr = [self.sampleValueArray mutableCopy];
            cell.hideBottomLine = YES;
            return cell;
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - VTMagicReuseProtocol
- (void)vtm_prepareForReuse {
    // reset content offset
    DLog(@"clear old data if needed:%@", self);
    [self.tableView setContentOffset:CGPointZero];
}


@end
