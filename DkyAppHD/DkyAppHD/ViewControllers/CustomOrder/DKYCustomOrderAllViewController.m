//
//  DKYCustomOrderAllViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/4/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderAllViewController.h"
#import "DKYCustomOrderUIViewController.h"
#import "DKYTongkuanFiveViewController.h"
#import "DKYAccountManager.h"

@interface DKYCustomOrderAllViewController ()

@property (nonatomic, strong) VTMagicController *magicController;

@end

@implementation DKYCustomOrderAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSArray *titleList = @[@"默认定制款",@"同款五",@"大货"];
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor colorWithHex:0x3C3362] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    UIViewController *viewController = nil;
    if(pageIndex == 0){
        static NSString *gridId = @"CustomOrder.identifier";
        viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = (DKYCustomOrderUIViewController*)[UIStoryboard viewControllerWithClass:[DKYCustomOrderUIViewController class]];
        }
    }else if(pageIndex == 1){
        static NSString *gridId = @"TongkuanFive.identifier";
        viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = (DKYTongkuanFiveViewController*)[UIStoryboard viewControllerWithClass:[DKYTongkuanFiveViewController class]];
        }
    }else{
        static NSString *gridId = @"dahuo.identifier";
        viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        
        NSDictionary *params = @{@"accessToken":[[DKYAccountManager sharedInstance] getAccessTokenWithNoBearer]};
        
        NSString *url = [NSString addQueryParametersUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,kOrderHtmlUrl] parameters:params];
        
        NSURL *URL = [NSURL URLWithString:url];
        if(!viewController){
            DKYWebViewController* webViewController = [[DKYWebViewController alloc] initWithURL:URL];
            webViewController.showUrlWhileLoading = NO;
            webViewController.showHUD = YES;
            viewController = webViewController;
        }else{
            DKYWebViewController* webViewController = (DKYWebViewController*)viewController;
            webViewController.showHUD = YES;
            webViewController.url = URL;
        }
    }
    return viewController;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {

}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {

}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {

}

#pragma mark - UI
- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"定制下单"];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    self.magicView.itemScale = 1.2;
    self.magicView.headerHeight = 40;
    self.magicView.navigationHeight = 44;
    self.magicView.headerView.backgroundColor = RGBCOLOR(243, 40, 47);
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleCenter;
    self.magicView.sliderColor = [UIColor colorWithHex:0x3C3362];
    self.magicView.delegate = self;
    self.magicView.dataSource = self;
    [self.magicView reloadData];
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

@end
