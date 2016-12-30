//
//  DKYTabBarViewController.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYTabBarViewController.h"
#import "DKYTabBar.h"

@interface DKYTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, weak) UIViewController *homeVc;
@property (nonatomic, weak) UIViewController *sampleQueryVc;
@property (nonatomic, weak) UIViewController *customOrderVc;
@property (nonatomic, weak) UIViewController *orderInquiryVc;

@end

@implementation DKYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 处理旋转
#pragma mark - 屏幕翻转就会调用
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    DLog(@"size = %@",NSStringFromCGSize(size));
    // 记录当前是横屏还是竖屏
    BOOL isLandscape = isLandscape(size);
    
    // 翻转的时间
    CGFloat duration = [coordinator transitionDuration];
    
    [UIView animateWithDuration:duration animations:^{
        DKYTabBar *tabbar = (DKYTabBar*)self.tabBar;
        [tabbar rotate:isLandscape];
    }];
}

#pragma mark - UI

- (void)commonInit{
    self.delegate = self;
    
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
    
//    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [self viewWillTransitionToSize:CGSizeMake(self.view.tw_width, self.view.tw_height) withTransitionCoordinator:nil];
#pragma clang diagnostic pop
}

- (void)addCustomTabBar
{
    // 创建自定义tabbar
    DKYTabBar *customTabBar = [[DKYTabBar alloc] initWithFrame:CGRectZero];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    // 设置选中的颜色
    customTabBar.selectedBackgrounColor = [UIColor randomColor];
}

- (void)addAllChildVcs
{
    UIViewController *homeVc = [[UIViewController alloc] init];
    [self addOneChlildVc:homeVc title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.homeVc = homeVc;
    
    UIViewController *sampleQueryVc = [[UIViewController alloc] init];
    [self addOneChlildVc:sampleQueryVc title:@"样衣查询" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.sampleQueryVc = sampleQueryVc;
    
    UIViewController *customOrderVc = [[UIViewController alloc] init];
    [self addOneChlildVc:customOrderVc title:@"定制下单" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.customOrderVc = customOrderVc;
    
    UIViewController *orderInquiryVc = [[UIViewController alloc] init];
    [self addOneChlildVc:orderInquiryVc title:@"订单查询" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.orderInquiryVc = orderInquiryVc;
}

- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 测试方法
    childVc.view.backgroundColor = [UIColor randomColor];
}

DeallocFun()

@end
