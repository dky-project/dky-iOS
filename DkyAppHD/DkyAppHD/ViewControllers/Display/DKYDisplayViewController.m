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
#import "DKYPageModel.h"
#import "DKYAddProductDpGroupParameter.h"
#import "DKYAddProductDpGroupJsonParameter.h"
#import "DKYAddProductDpGroupResponseModel.h"
#import "DKYConfirmProductApproveParameter.h"
#import "DKYMatchHeaderViewCell.h"

@interface DKYDisplayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) DKYDisplayHeaderView *headerView;

@property (nonatomic, weak) DKYDisplayActionView *actionsView;

@property (nonatomic, strong) DKYGetProductListByGroupNoParameter *getProductListByGroupNoParameter;

@property (nonatomic, strong) DKYGetProductListByGroupNoParameter *getProductListByGroupNoParameterEx;

@property (nonatomic, strong) NSArray *productList;

@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger totalPageNum;

@property (nonatomic, assign) NSInteger groupNo_;

@property (nonatomic, copy) NSArray *groupNoList;

@property (nonatomic, strong) DKYAddProductDpGroupResponseModel *addProductDpGroupResponseModel;

@property (nonatomic, copy) NSString *bigImageUrl;

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
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            
            weakSelf.productList = [DKYGetProductListByGroupNoModel mj_objectArrayWithKeyValuesArray:page.items];
            weakSelf.pageNo = page.pageNo;
            weakSelf.totalPageNum = page.totalPageNum;
            weakSelf.bigImageUrl = [result.data objectForKey:@"bigImageUrl"];
            
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

- (void)getProductListByGroupNoFromServerForNextAndPrev{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    [[DKYHttpRequestManager sharedInstance] getProductListByGroupNoWithParameter:self.getProductListByGroupNoParameterEx Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            
            weakSelf.productList = [DKYGetProductListByGroupNoModel mj_objectArrayWithKeyValuesArray:page.items];
            weakSelf.pageNo = page.pageNo;
            weakSelf.totalPageNum = page.totalPageNum;
            weakSelf.groupNoList = page.groupNoList;
            weakSelf.groupNo = weakSelf.getProductListByGroupNoParameterEx.groupNo;
            
            NSInteger index = 0;
            for(NSString* gp in page.groupNoList){
                if([weakSelf.groupNo isEqualToString:gp]){
                    weakSelf.groupNo_ = index;
                    break;
                }
                ++index;
            }

            weakSelf.bigImageUrl = [result.data objectForKey:@"bigImageUrl"];
            weakSelf.headerView.groupNo = weakSelf.groupNo;
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

- (void)addProductDpGroup{
    WeakSelf(weakSelf);

    [DKYHUDTool show];
    DKYAddProductDpGroupParameter *p = [[DKYAddProductDpGroupParameter alloc] init];
    p.version = nil;
    
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    
    for (DKYGetProductListByGroupNoModel *model in self.productList) {
        if(model.isChoosed && model.sum > 0){
            if(model.isBigOrder){
                [arr2 addObject:model.addDpGroupBmptParam];
            }else{
                [arr1 addObject:model.addDpGroupApproveParam];
            }
        }
    }
    
    p.addDpGroupApproveParamList = arr1.copy;
    p.addDpGroupBmptParamList = arr2.copy;
    
    NSDictionary *data = [p mj_keyValues];
    NSString *jsonStr = [data jsonStringEncoded];

    DKYAddProductDpGroupJsonParameter *parameter = [[DKYAddProductDpGroupJsonParameter alloc] init];
    parameter.paramJson = jsonStr;
    
    [[DKYHttpRequestManager sharedInstance] addProductDpGroupWithParameter:parameter Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.addProductDpGroupResponseModel = [DKYAddProductDpGroupResponseModel mj_objectWithKeyValues:result.data];
            
            [UIAlertController showAlertInViewController:weakSelf
                                               withTitle:@"提示"
                                                 message:@"是否确认下单"
                                       cancelButtonTitle:@"是"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@[@"否"]
                                                tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                    if (buttonIndex == controller.cancelButtonIndex) {
                                                        [weakSelf confirmProductApproveToServer];
                                                    } else if (buttonIndex >= controller.firstOtherButtonIndex) {
                                                        
                                                    }
                                                }];
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

// 确认下单
- (void)confirmProductApproveToServer{
    [DKYHUDTool show];
    
    DKYConfirmProductApproveParameter *p = [[DKYConfirmProductApproveParameter alloc] init];
    p.bmptIds = self.addProductDpGroupResponseModel.bmptIds;
    p.approveIds = self.addProductDpGroupResponseModel.approveIds;
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] confirmProductApproveWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 生成订单成功
            [DKYHUDTool showSuccessWithStatus:@"确认下单成功!"];
            
            weakSelf.addProductDpGroupResponseModel = nil;
            [weakSelf.headerView clear];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.pageNo = 1;
                weakSelf.getProductListByGroupNoParameterEx.pageNo = @(self.pageNo);
                [weakSelf getProductListByGroupNoFromServerForNextAndPrev];
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

#pragma mark - help method
- (BOOL)checkForSave{
    // 检查总数
    NSInteger sum = 0;
    for (DKYGetProductListByGroupNoModel *model in self.productList) {
        sum += model.sum;
    }
    if(sum == 0){
        [DKYHUDTool showInfoWithStatus:@"请填写数据！"];
        return NO;
    }
    
    for (DKYGetProductListByGroupNoModel *model in self.productList) {
//        NSInteger sum = model.sum;
//        if(sum == 0){
//            [DKYHUDTool showInfoWithStatus:@"数量为0！"];
//            return NO;
//        }
//        
        if(model.iscollect && model.isBigOrder){
            if(model.sum > 0){
                if(!model.addDpGroupBmptParam.colorId){
                    [DKYHUDTool showInfoWithStatus:@"颜色不能为空！"];
                    return NO;
                }
                
                if(!model.addDpGroupBmptParam.sizeId){
                    [DKYHUDTool showInfoWithStatus:@"尺寸不能为空！"];
                    return NO;
                }
            }
        }else{
            if(model.isChoosed && model.sum > 0){
                if(![model.addDpGroupApproveParam.mDimNew14Id isNotBlank]){
                    [DKYHUDTool showInfoWithStatus:@"品种不能为空！"];
                    return NO;
                }
                
                if(![model.addDpGroupApproveParam.colorArr isNotBlank]){
                    [DKYHUDTool showInfoWithStatus:@"颜色不能为空！"];
                    return NO;
                }
    
                
                if(![model.addDpGroupApproveParam.xwValue isNotBlank]){
                    [DKYHUDTool showInfoWithStatus:@"胸围不能为空！"];
                    return NO;
                }
                
                if(![model.addDpGroupApproveParam.ycValue isNotBlank]){
                    [DKYHUDTool showInfoWithStatus:@"衣长不能为空！"];
                    return NO;
                }
                
                // 袖长
                if(!model.isBigOrder &&model.defaultXcValue){
                    double value1 = [model.addDpGroupApproveParam.xcLeftValue doubleValue];
                    double value2 = [model.defaultXcValue doubleValue];
                    
                    if(fabs(value1 - value2) > 4){
                        [DKYHUDTool showInfoWithStatus:@"袖长+-4公分变化"];
                        return NO;
                    }
                }
                
                // 衣长
                if(!model.isBigOrder && model.defaultYcValue){
                    double value1 = [model.addDpGroupApproveParam.ycValue doubleValue];
                    double value2 = [model.defaultYcValue doubleValue];
                    
                    if(fabs(value1 - value2) > 4){
                        [DKYHUDTool showInfoWithStatus:@"衣长+-4公分变化"];
                        return NO;
                    }
                }
            }
        }
}

    return YES;
    
}

- (BOOL)checkForConfirm{
    if(!self.addProductDpGroupResponseModel) {
        [DKYHUDTool showInfoWithStatus:@"请先保存订单"];
        return NO;
    }
    return YES;
}


#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0) return self.productList ? 1 : 0;
    
    return self.productList.count > 0 ? self.productList.count + 2 : 0;
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
    
    if(indexPath.section == 1 && indexPath.row == 0) return 45;
    
    return 60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        DKYDisplayImageViewCell *cell = [DKYDisplayImageViewCell displayImageViewCellWithTableView:tableView];
        cell.productList = self.productList;
        cell.bigImageUrl = self.bigImageUrl;
        return cell;
    }
    
    if(indexPath.section == 1 && indexPath.row == self.productList.count + 1){
        DKYDisplaySumViewCell *cell = [DKYDisplaySumViewCell displaySumViewCellWithTableView:tableView];
        cell.productList = self.productList;
        return cell;
    }
    
    if(indexPath.section == 1 && indexPath.row == 0){
        DKYMatchHeaderViewCell *cell = [DKYMatchHeaderViewCell matchHeaderViewCellWithTableView:tableView];
        return cell;
    }
    
    DKYGetProductListByGroupNoModel *model = [self.productList objectAtIndex:indexPath.row - 1];
    if(model.isBigOrder){
        DKYDisplayCategoryDahuoViewCell *cell = [DKYDisplayCategoryDahuoViewCell displayCategoryDahuoViewCellWithTableView:tableView];
        cell.getProductListByGroupNoModel = [self.productList objectAtIndex:indexPath.row - 1];
        return cell;
    }

    DKYDisplayCategoryViewCell *cell = [DKYDisplayCategoryViewCell displayCategoryViewCellWithTableView:tableView];
    cell.getProductListByGroupNoModel = [self.productList objectAtIndex:indexPath.row - 1];
    cell.groupNo = self.groupNo;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if([cell isKindOfClass:[DKYDisplayCategoryViewCell class]]){
            DKYDisplayCategoryViewCell *newCell = (DKYDisplayCategoryViewCell*)cell;
            [newCell selectStatusChanged];
        }else if([cell isKindOfClass:[DKYDisplayCategoryDahuoViewCell class]]){
            DKYDisplayCategoryDahuoViewCell *newCell = (DKYDisplayCategoryDahuoViewCell*)cell;
            [newCell selectStatusChanged];
        }
    }
}

#pragma mark - UI
- (void)commonInit{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"FAB下单"];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupHeaderView];
    
    [self setupTableView];
    
    [self setupActionView];
    
    self.pageNo = 1;
    //self.groupNo_ = [self.groupNo integerValue];
    
    self.getProductListByGroupNoParameterEx.pageNo = @(self.pageNo);
    
    self.getProductListByGroupNoParameter.groupNo = self.groupNo;
    self.getProductListByGroupNoParameterEx.groupNo = self.groupNo;
    
    [self getProductListByGroupNoFromServerForNextAndPrev];
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
        NSInteger groupNo = self.groupNo_;
        --groupNo;
        if(groupNo <0 || groupNo >= self.groupNoList.count) return;
        
        weakSelf.getProductListByGroupNoParameterEx.groupNo = [self.groupNoList objectAtIndex:groupNo];
        
        
        [weakSelf getProductListByGroupNoFromServerForNextAndPrev];
    };
    
    self.headerView.nextBtnClicked = ^(id sender) {
        NSInteger groupNo = self.groupNo_;
        ++groupNo;
        
        if(groupNo <0 || groupNo >= self.groupNoList.count) return;
        
        weakSelf.getProductListByGroupNoParameterEx.groupNo = [self.groupNoList objectAtIndex:groupNo];
        
        [weakSelf getProductListByGroupNoFromServerForNextAndPrev];
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
    
//    actionView.confirmBtnClicked = ^(UIButton* sender){
//        if(![weakSelf checkForConfirm]) return ;
//
//        [weakSelf confirmProductApproveToServer];
//    };
    
    actionView.saveBtnClicked = ^(UIButton *sender){
        // 1.检查参数
        if(![weakSelf checkForSave]) return;

        // 2.调用接口
        [weakSelf addProductDpGroup];
    };
}

- (void)setupCustomTitle:(NSString*)title;
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
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

- (DKYGetProductListByGroupNoParameter*)getProductListByGroupNoParameterEx{
    if(_getProductListByGroupNoParameterEx == nil){
        _getProductListByGroupNoParameterEx = [[DKYGetProductListByGroupNoParameter alloc] init];
        _getProductListByGroupNoParameterEx.pageSize = @(1);
        _getProductListByGroupNoParameterEx.pageNo = @(1);
    }
    return _getProductListByGroupNoParameterEx;
}

@end
