//
//  DKYSampleDetailAllViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/4/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailAllViewController.h"
#import "DKYSampleDetailViewController.h"
#import "DKYSampleOrderPopupView.h"
#import "DKYSampleProductInfoModel.h"
#import "DKYSampleModel.h"
#import "DKYProductCollectParameter.h"
#import "DKYSampleDetailViewController2.h"
#import "DKYAccountManager.h"

@interface DKYSampleDetailAllViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;

@property (nonatomic, weak) UIButton *collectBtn;

@property (nonatomic, strong) DKYSampleModel *waitOpetionModel;

@end

@implementation DKYSampleDetailAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
}

#pragma mark - 网络请求
- (void)delProductCollectToServer{
    [DKYHUDTool show];
    
    DKYProductCollectParameter *p = [[DKYProductCollectParameter alloc] init];
    p.productId = @(self.waitOpetionModel.mProductId);
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] delProductCollectWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 生成订单成功
            [DKYHUDTool showSuccessWithStatus:@"取消收藏成功!"];
            
            weakSelf.waitOpetionModel.collected = !weakSelf.waitOpetionModel.collected;
            [weakSelf updateCollectBtn:weakSelf.waitOpetionModel.collected];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateSampleQueryCollectStatusNotification object:nil];
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

- (void)addProductCollectToServer{
    [DKYHUDTool show];
    
    DKYProductCollectParameter *p = [[DKYProductCollectParameter alloc] init];
    p.productId = @(self.waitOpetionModel.mProductId);
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] addProductCollectWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 生成订单成功
            [DKYHUDTool showSuccessWithStatus:@"收藏成功!"];
            
            weakSelf.waitOpetionModel.collected = !weakSelf.waitOpetionModel.collected;
            [weakSelf updateCollectBtn:weakSelf.waitOpetionModel.collected];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateSampleQueryCollectStatusNotification object:nil];
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

#pragma mark - UI

- (void)commonInit{
    //[self setupCustomTitle:@"产品详情"];
    NSString* jgno = [[DKYAccountManager sharedInstance] getJgno];
    [self updateTitleView:jgno];
    
    [self setupOrderBtn];
    [self setupCollectBtn];
    
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    
    [_magicController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [_magicController.magicView reloadData];
    [_magicController.magicView reloadDataToPage:self.currentIndex];
}

- (void)setupOrderBtn{
    TWNavBtnItem *rightBtnItem = [[TWNavBtnItem alloc]init];
    
    rightBtnItem.itemType = TWNavBtnItemType_Text;
    rightBtnItem.title = @"下单";
    rightBtnItem.normalImage = nil;
    rightBtnItem.hilightedImage = nil;
    self.rightBtnItem = rightBtnItem;
    
    WeakSelf(weakSelf);
    self.rightBtnClicked = ^(UIButton *sender) {
        DKYSampleDetailViewController *vc =(DKYSampleDetailViewController*) weakSelf.magicController.currentViewController;
        DKYSampleProductInfoModel *model = vc.sampleProductInfo;
        
        if(!model.isBigOrder){
            DKYSampleOrderPopupView *pop = [DKYSampleOrderPopupView showWithSampleProductInfoModel:model];
            pop.issource = weakSelf.issource;
        }else{
            NSDictionary *params = nil;
            if([self.issource integerValue] == 2){
                params = @{@"accessToken":[[DKYAccountManager sharedInstance] getAccessTokenWithNoBearer],
                           @"productName":model.name,
                           @"issource" : self.issource
                           };
            }else{
                params = @{@"accessToken":[[DKYAccountManager sharedInstance] getAccessTokenWithNoBearer],
                           @"productName":model.name};
            }
            
            NSString *url = [NSString addQueryParametersUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,kOrderHtmlUrl] parameters:params];
            
            NSURL *URL = [NSURL URLWithString:url];
            DKYWebViewController* webViewController = [[DKYWebViewController alloc] initWithURL:URL];
            webViewController.showUrlWhileLoading = NO;
            webViewController.showHUD = YES;
            webViewController.navigationButtonsHidden = YES;
            webViewController.showPageTitles = NO;
            webViewController.navigationItem.title = @"大货";
            [weakSelf.navigationController pushViewController:webViewController animated:YES];
        }
    };
}

- (void)setupCollectBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = [UIFont systemFontOfSize:15];;
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [btn setTitle:@"收藏" forState:UIControlStateNormal];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    CGRect textFrame = CGRectMake(0, 6, 40, 40);
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    UIColor *foregroundColor = btn.currentTitleColor;
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName: foregroundColor};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect titleFrame = [@"取消收藏" boundingRectWithSize:size
                                              options:options
                                           attributes:attributes
                                              context:nil];
    textFrame.size.width = MAX(textFrame.size.width, titleFrame.size.width);
    
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.rightBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    NSMutableArray *btns = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [btns appendObject:rightItem];
    
    [self.navigationItem setRightBarButtonItems:btns];
    
    self.collectBtn = btn;
    WeakSelf(weakSelf);
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSInteger index = weakSelf.magicController.currentPage;
        DKYSampleModel *sampleModel = [weakSelf.samples objectAtIndex:index];
        weakSelf.waitOpetionModel = sampleModel;
        if(sampleModel.collected){
            [weakSelf delProductCollectToServer];
        }else{
            [weakSelf addProductCollectToServer];
        }
    }];
}

- (void)updateCollectBtn:(BOOL)collect{
    if(collect){
        [self.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
    }else{
        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    }
}

-(void)updateTitleView:(NSString*)jg{
    NSString *title = [NSString stringWithFormat:@"%@  %@",jg,@"产品详情"];
    [self setupCustomTitle:title];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (int i = 0; i < self.samples.count; ++i) {
        [titleList addObject:@""];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    DKYSampleModel *sampleModel = [self.samples objectAtIndex:pageIndex];
    if(sampleModel.isDh){
        static NSString *gridId = @"sample2.identifier";
        DKYSampleDetailViewController2 *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = (DKYSampleDetailViewController2*)[UIStoryboard viewControllerWithClass:[DKYSampleDetailViewController2 class]];
        }
        ;
        viewController.sampleModel = sampleModel;
        return viewController;
    }else{
        static NSString *gridId = @"sample.identifier";
        DKYSampleDetailViewController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = (DKYSampleDetailViewController*)[UIStoryboard viewControllerWithClass:[DKYSampleDetailViewController class]];
        }
        DLog(@"DKYSampleDetailViewController = %@",viewController);
        viewController.sampleModel = sampleModel;
        return viewController;
    }
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex{
    DKYSampleModel *sampleModel = [self.samples objectAtIndex:pageIndex];
    [self updateCollectBtn:sampleModel.collected];
}


- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationHeight = CGFLOAT_MIN;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

@end
