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
#import "DKYProductInfoParameter.h"
#import "DKYSampleDetailGanweiViewCell.h"

@interface DKYSampleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) NSArray *queryPrices;

@property (nonatomic, strong) NSArray *priceArray;

@property (nonatomic, strong) NSArray *sampleValues;

@property (nonatomic, strong) NSArray *sampleValueArray;

@property (nonatomic, strong) NSArray *defaultValueArray;

@property (nonatomic, copy) NSArray *ganweiArray;

@property (nonatomic, copy) NSArray *tongzhuangArray;

@property (nonatomic, copy) NSArray *yingerzhuangArray;

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
    self.sampleProductInfo = nil;
    [self.tableView reloadData];

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
            weakSelf.sampleProductInfo.mDimNew13Id = weakSelf.sampleModel.mDimNew13Id;
            
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
            
            if(weakSelf.sampleModel.mDimNew13Id == 21 || weakSelf.sampleModel.mDimNew13Id == 20){
                [weakSelf setupPriceArray];
            }else if (weakSelf.sampleModel.mDimNew13Id == 249 || weakSelf.sampleModel.mDimNew13Id == 250){
                // 童装
                [weakSelf setupTongzhuangArray];
            }else{
                // 婴儿装
                [weakSelf setupYingerzhuangArray];
            }
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

-(void)setupTongzhuangArray{
    NSMutableArray *sex = [NSMutableArray arrayWithCapacity:2];
    [sex addObject:@"性别"];
    
    NSMutableArray *type = [NSMutableArray arrayWithCapacity:2];
    [type addObject:@"品种"];
    
    NSMutableArray *zhenType = [NSMutableArray arrayWithCapacity:2];
    [zhenType addObject:@"针型"];
    
    NSMutableArray *group1 = [NSMutableArray arrayWithCapacity:2];
    [group1 addObject:@"胸围50及以下或S码"];
    
    NSMutableArray *group2 = [NSMutableArray arrayWithCapacity:2];
    [group2 addObject:@"胸围51-60或M码"];
    
    NSMutableArray *group3 = [NSMutableArray arrayWithCapacity:2];
    [group3 addObject:@"胸围61-70或L码"];

    NSMutableArray *group4 = [NSMutableArray arrayWithCapacity:2];
    [group4 addObject:@"胸围71-80或XL码"];

    NSMutableArray *group5 = [NSMutableArray arrayWithCapacity:2];
    [group5 addObject:@"81以上专卖店价(女装标准价)"];

    for (DKYQueryPriceModel *model in self.queryPrices) {
        [sex addObject:model.mDimNew13Text];
        [type addObject:model.mDimNew14Text];
        [zhenType addObject:model.mDimNew16Text];
        [group1 addObject:[NSString formatRateStringWithRate:model.price]];
        [group2 addObject:[NSString formatRateStringWithRate:model.price2]];
        [group3 addObject:[NSString formatRateStringWithRate:model.price4]];
        [group4 addObject:[NSString formatRateStringWithRate:model.price6]];
        [group5 addObject:[NSString formatRateStringWithRate:model.price8]];
    }
    
    self.tongzhuangArray = @[[sex copy],[type copy],[zhenType copy],[group1 copy],[group2 copy],[group3 copy],[group4 copy],[group5 copy]];
}

-(void)setupYingerzhuangArray{
    NSMutableArray *sex = [NSMutableArray arrayWithCapacity:2];
    [sex addObject:@"性别"];
    
    NSMutableArray *type = [NSMutableArray arrayWithCapacity:2];
    [type addObject:@"品种"];
    
    NSMutableArray *zhenType = [NSMutableArray arrayWithCapacity:2];
    [zhenType addObject:@"针型"];
    
    NSMutableArray *group2 = [NSMutableArray arrayWithCapacity:2];
    [group2 addObject:@"价格6M"];
    
    NSMutableArray *group3 = [NSMutableArray arrayWithCapacity:2];
    [group3 addObject:@"价格9M"];
    
    //    NSMutableArray *group1 = [NSMutableArray arrayWithCapacity:2];
    //    [group1 addObject:@"3M"];
    //
    //    NSMutableArray *group4 = [NSMutableArray arrayWithCapacity:2];
    //    [group4 addObject:@"12M"];
    //
    //    NSMutableArray *group5 = [NSMutableArray arrayWithCapacity:2];
    //    [group5 addObject:@"24M"];
    //
    //    NSMutableArray *group6 = [NSMutableArray arrayWithCapacity:2];
    //    [group6 addObject:@"36M"];
    //
    //    NSMutableArray *group7 = [NSMutableArray arrayWithCapacity:2];
    //    [group7 addObject:@"48M"];
    
    for (DKYQueryPriceModel *model in self.queryPrices) {
        [sex addObject:model.mDimNew13Text];
        [type addObject:model.mDimNew14Text];
        [zhenType addObject:model.mDimNew16Text];
        [group2 addObject:[NSString formatRateStringWithRate:model.price1]];
        [group3 addObject:[NSString formatRateStringWithRate:model.price2]];
        
        //        [group1 addObject:[NSString formatRateStringWithRate:model.price]];
        //        [group4 addObject:[NSString formatRateStringWithRate:model.price3]];
        //        [group5 addObject:[NSString formatRateStringWithRate:model.price4]];
        //        [group6 addObject:[NSString formatRateStringWithRate:model.price5]];
        //        [group7 addObject:[NSString formatRateStringWithRate:model.price6]];
    }
    
    self.yingerzhuangArray = @[[sex copy],[type copy],[zhenType copy],[group2 copy],[group3 copy]];
}

#pragma mark - UI

- (void)commonInit{
    self.group = dispatch_group_create();
    //[self setupCustomTitle:@"产品详情"];
    
    [self setupTableView];
}

- (void)setupTableView{
    NSString *identify = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
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
    if(self.sampleProductInfo == nil) return 0;
    
    return 5;
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
            identifier = NSStringFromClass([DQTableViewCell class]);
            break;
        case 2:
            identifier = NSStringFromClass([DQTableViewCell class]);
            break;
        case 3:
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                identifier = NSStringFromClass([DKYSampleDetailPriceViewCell class]);
            }else{
                identifier = NSStringFromClass([DQTableViewCell class]);
            }
            break;
        case 4:
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
        }else if (indexPath.row == 3){
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                DKYSampleDetailPriceViewCell *newcell = (DKYSampleDetailPriceViewCell*)cell;
                newcell.sampleProductInfo = self.sampleProductInfo;
            }else{
                if(self.sampleProductInfo.mDimNew13Id == 21 || self.sampleProductInfo.mDimNew13Id == 20){
                    DQTableViewCell *newcell = (DQTableViewCell*)cell;
                    newcell.fd_enforceFrameLayout = YES;
                    newcell.mark = nil;
                    newcell.DataArr = [self.priceArray mutableCopy];
                    newcell.title = @"价格";
                }else if (self.sampleProductInfo.mDimNew13Id == 249 || self.sampleProductInfo.mDimNew13Id == 250){
                    // 童装
                    DQTableViewCell *newcell = (DQTableViewCell*)cell;
                    newcell.fd_enforceFrameLayout = YES;
                    newcell.mark = @"注意：衣长超出60cm的价同女装标准价格";
                    newcell.DataArr = [self.self.tongzhuangArray mutableCopy];
                    newcell.title = nil;
                }else{
                    // 婴儿装
                    DQTableViewCell *newcell = (DQTableViewCell*)cell;
                    newcell.fd_enforceFrameLayout = YES;
                    newcell.mark = nil;
                    newcell.DataArr = [self.self.yingerzhuangArray mutableCopy];
                    newcell.title = nil;
                }
            }
        }else{
            DQTableViewCell *newcell = (DQTableViewCell*)cell;
            newcell.fd_enforceFrameLayout = YES;
            
            if(indexPath.row == 1){
                newcell.formType = DKYFormType_TypeTwo;
                newcell.DataArr = [self.defaultValueArray mutableCopy];
                newcell.title = nil;
            }else if(indexPath.row == 2){
                newcell.formType = DKYFormType_TypeTwo;
                newcell.mark = nil;
                newcell.DataArr = [self.sampleValueArray mutableCopy];
                newcell.title = @"尺寸规格表";
            }else if(indexPath.row == 4){
                newcell.formType = DKYFormType_TypeTwo;
                newcell.mark = nil;
                newcell.DataArr = [self.ganweiArray mutableCopy];
                newcell.title = @"杆位";
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
            DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
            cell.formType = DKYFormType_TypeTwo;
            cell.mark = nil;
            cell.DataArr = [self.defaultValueArray mutableCopy];
            cell.hideBottomLine = YES;
            cell.title = nil;
            return cell;
        }
            break;
        case 2:{
            DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
            
            cell.formType = DKYFormType_TypeTwo;
            cell.mark = nil;
            cell.DataArr = [self.sampleValueArray mutableCopy];
            cell.hideBottomLine = YES;
            cell.title = @"尺寸规格表";
            
            return cell;
        }
            break;
        case 3:{
            if([self.sampleProductInfo.mptbelongtype caseInsensitiveCompare:@"c"] == NSOrderedSame){
                DKYSampleDetailPriceViewCell *cell = [DKYSampleDetailPriceViewCell sampleDetailPriceViewCellWithTableView:tableView];
                cell.sampleProductInfo = self.sampleProductInfo;
                return cell;
            }else{
                //mDimNew13Id == 21 || mDimNew13Id == 20  表格保持不变
                //mDimNew13Id == 249 || mDimNew13Id == 250 童装
                //其他为婴儿
                
                if(self.sampleProductInfo.mDimNew13Id == 21 || self.sampleProductInfo.mDimNew13Id == 20){
                    DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
                    
                    cell.formType = DKYFormType_TypeTwo;
                    cell.mark = nil;
                    cell.DataArr = [self.priceArray mutableCopy];
                    cell.title = @"价格";
                    return cell;
                }else if (self.sampleProductInfo.mDimNew13Id == 249 || self.sampleProductInfo.mDimNew13Id == 250){
                    // 童装
                    DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
                    
                    cell.formType = DKYFormType_TypeFour;
                    cell.mark = @"注意：衣长超出60cm的价同女装标准价格";
                    cell.DataArr = [self.tongzhuangArray mutableCopy];
                    cell.title = nil;
                    return cell;
                }else{
                    // 婴儿装
                    DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
                    
                    cell.formType = DKYFormType_TypeFive;
                    cell.mark = nil;
                    cell.DataArr = [self.yingerzhuangArray mutableCopy];
                    cell.title = nil;
                    return cell;
                }
            }
        }
            break;
        case 4:{
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
