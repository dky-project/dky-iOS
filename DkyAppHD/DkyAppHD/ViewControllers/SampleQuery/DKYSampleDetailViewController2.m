//
//  DKYSampleDetailViewController2.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/8/26.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYSampleDetailViewController2.h"
#import "DKYSampleModel.h"
#import "DKYSampleProductInfoModel.h"
#import "DQHeader.h"
#import "DKYSampleQueryParameter.h"
#import "DKYQueryPriceModel.h"
#import "DKYSampleValueInfoModel.h"
#import "DKYSampleDetailPriceViewCell.h"
#import "DKYProductInfoParameter.h"
#import "DKYSampleDetailGanweiViewCell.h"
#import "DKYSampleDetailTypeViewCell2.h"

@interface DKYSampleDetailViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) NSArray *queryPrices;

@property (nonatomic, strong) NSArray *priceArray;

@property (nonatomic, strong) NSArray *sampleValues;

@property (nonatomic, strong) NSArray *sampleValueArray;

@property (nonatomic, strong) NSArray *defaultValueArray;

@property (nonatomic, copy) NSArray *ganweiArray;

@end

@implementation DKYSampleDetailViewController2

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
    DKYProductInfoParameter *p = [[DKYProductInfoParameter alloc] init];
    p.Id = @(self.sampleModel.mProductId);
    p.isBuy = self.sampleModel.isBuy;
    
    [[DKYHttpRequestManager sharedInstance] getProductInfoWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.sampleProductInfo = [DKYSampleProductInfoModel mj_objectWithKeyValues:result.data];
            weakSelf.sampleProductInfo.mProductId = @(weakSelf.sampleModel.mProductId);
            weakSelf.sampleProductInfo.pdt = weakSelf.sampleModel.name;
            
            [self setupDefaultValueArray];
            [self setupGanweiArray];
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

- (void)setupDefaultValueArray{
    NSMutableArray *pz = [NSMutableArray arrayWithCapacity:1];
    [pz addObject:@"品种(原料)"];
    
    NSMutableArray *zx = [NSMutableArray arrayWithCapacity:1];
    [zx addObject:@"针型"];
    
    NSMutableArray *ys = [NSMutableArray arrayWithCapacity:1];
    [ys addObject:@"颜色"];
    
    NSMutableArray *xw = [NSMutableArray arrayWithCapacity:1];
    [xw addObject:@"胸围"];
    
    NSMutableArray *yc = [NSMutableArray arrayWithCapacity:1];
    [yc addObject:@"衣长"];
    
    NSMutableArray *xc = [NSMutableArray arrayWithCapacity:1];
    [xc addObject:@"袖长"];
    
    
    [pz addObject:self.sampleProductInfo.mDimNew14Text ? :@""];
    [zx addObject:self.sampleProductInfo.mDimNew16Text ? :@""];
    [ys addObject:self.sampleProductInfo.clrRange ? : @""];
    [xw addObject:self.sampleProductInfo.defaultXwValue ? : @""];
    [yc addObject:self.sampleProductInfo.defaultYcValue ? : @""];
    [xc addObject:self.sampleProductInfo.defaultXcValue ? : @""];
    
    self.defaultValueArray = @[pz,zx,ys,xw,yc,xc];
}

- (void)setupGanweiArray{
    NSMutableArray *ganwei = [NSMutableArray arrayWithCapacity:6];
    NSArray *column1 = @[@"颜色",@"杆位"];
    [ganwei addObject:column1];
    
    NSString *gw_key = @"gw";
    NSString *color_key = @"m_color";
    for(int i = 0; i < 5; ++i){
        NSString *key = [NSString stringWithFormat:@"%@%@",gw_key,@(i + 1)];
        NSString *gw = [self.sampleProductInfo.gwView objectForKey:key];
        if(gw == nil){
            gw = @"";
        }
        
        key = [NSString stringWithFormat:@"%@%@",color_key,@(i + 1)];
        NSString *color = [self.sampleProductInfo.gwView objectForKey:key];
        if(color == nil){
            color = @"";
        }
        NSArray *group = @[color, gw];
        [ganwei addObject:group];
    }
    
    self.ganweiArray = [ganwei mutableCopy];
}

#pragma mark - UI

- (void)commonInit{
    self.group = dispatch_group_create();
    [self setupCustomTitle:@"产品详情"];
    
    [self setupTableView];
}

- (void)setupTableView{
    NSString *identify = NSStringFromClass([DKYSampleDetailTypeViewCell2 class]);
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    [self.tableView registerClass:[DQTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DQTableViewCell class])];
    [self.tableView registerClass:[DKYSampleDetailPriceViewCell class] forCellReuseIdentifier:NSStringFromClass([DKYSampleDetailPriceViewCell class])];
    [self.tableView registerClass:[DKYSampleDetailGanweiViewCell class] forCellReuseIdentifier:NSStringFromClass([DKYSampleDetailGanweiViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    //    self.tableView.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    //    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell2 class]);
            break;
        case 1:
            identifier = NSStringFromClass([DQTableViewCell class]);
            break;
        case 2:
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                identifier = NSStringFromClass([DKYSampleDetailPriceViewCell class]);
            }else{
                identifier = NSStringFromClass([DQTableViewCell class]);
            }
            break;
        case 3:
            identifier = NSStringFromClass([DQTableViewCell class]);
            break;
        default:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell2 class]);
            break;
    }
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        if(indexPath.row == 0){
            DKYSampleDetailTypeViewCell2 *newCell = (DKYSampleDetailTypeViewCell2*)cell;
            newCell.model = weakSelf.sampleProductInfo;
        }else if (indexPath.row == 2){
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                DKYSampleDetailPriceViewCell *newcell = (DKYSampleDetailPriceViewCell*)cell;
                newcell.sampleProductInfo = self.sampleProductInfo;
            }else{
                DQTableViewCell *newcell = (DQTableViewCell*)cell;
                newcell.fd_enforceFrameLayout = YES;
                newcell.DataArr = [self.priceArray mutableCopy];
                newcell.title = @"价格";
            }
        }else{
            DQTableViewCell *newcell = (DQTableViewCell*)cell;
            newcell.fd_enforceFrameLayout = YES;
            
            if(indexPath.row == 1){
                newcell.formType = DKYFormType_TypeTwo;
                newcell.DataArr = [self.sampleValueArray mutableCopy];
                newcell.title = @"尺寸规格表";
            }else if(indexPath.row == 3){
                newcell.formType = DKYFormType_TypeTwo;
                newcell.DataArr = [self.ganweiArray mutableCopy];
                newcell.title = @"杆位";
            }
        }
    }];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = cell = [DKYSampleDetailTypeViewCell2 sampleDetailTypeViewCellWithTableView:tableView];
    switch (indexPath.row) {
        case 0:{
            cell = [DKYSampleDetailTypeViewCell2 sampleDetailTypeViewCellWithTableView:tableView];
            DKYSampleDetailTypeViewCell2 *newCell = (DKYSampleDetailTypeViewCell2*)cell;
            newCell.model = self.sampleProductInfo;
        }
            break;
        case 1:{
            DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
            
            cell.formType = DKYFormType_TypeTwo;
            cell.DataArr = [self.sampleValueArray mutableCopy];
            cell.hideBottomLine = YES;
            cell.title = @"尺寸规格表";
            
            return cell;
        }
            break;
        case 2:{
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                DKYSampleDetailPriceViewCell *cell = [DKYSampleDetailPriceViewCell sampleDetailPriceViewCellWithTableView:tableView];
                cell.sampleProductInfo = self.sampleProductInfo;
                return cell;
            }else{
                DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
                
                cell.formType = DKYFormType_TypeTwo;
                cell.DataArr = [self.priceArray mutableCopy];
                cell.title = @"价格";
                return cell;
            }
        }
            break;
        case 3:{
            DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
            cell.formType = DKYFormType_TypeTwo;
            cell.DataArr = [self.ganweiArray mutableCopy];
            cell.hideBottomLine = YES;
            cell.title = @"杆位";
            return cell;
        }
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
