//
//  DKYGuidenceViewController.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYGuidenceViewController.h"
#import "DKYTabBarViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "DKYLoginViewController.h"

@interface DKYGuidenceViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgrondImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderingSystemLabel;
@property (weak, nonatomic) IBOutlet UIView *touchToContinueView;

@end

@implementation DKYGuidenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action method

- (void)touchContinue:(UITapGestureRecognizer*)sender{
    DLog(@"continue");
//    //1.创建转场动画对象
//    CATransition *transition=[[CATransition alloc]init];
//    
//    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
//    transition.type=@"pageCurl";
//    //设置动画时常
//    transition.duration = 1.0f;
//    
//    [self.view.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
//    transition.delegate = self;
    DKYLoginViewController *loginVc = (DKYLoginViewController*)[UIStoryboard viewControllerWithClass:[DKYLoginViewController class]];
    
    [self wxs_presentViewController:loginVc makeTransition:^(WXSTransitionProperty *transition) {
        transition.animationType = WXSTransitionAnimationTypeSysPageCurlFromBottom;
        transition.animationTime = 1.2;
    } completion:^{
        
    }];
}

#pragma mark - Ui

- (void)commonInit{
    self.backgrondImageView.image = [UIImage imageWithColor:[UIColor randomColor]];
    
    NSDictionary *dict = @{NSForegroundColorAttributeName : self.orderingSystemLabel.textColor,
                           NSFontAttributeName : self.orderingSystemLabel.font};
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:self.orderingSystemLabel.text attributes:dict];
    NSString *versionText = @"Beta 1.0";
    NSRange range = [self.orderingSystemLabel.text rangeOfString:versionText];
    [attrText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA52C2D] range:range];
    self.orderingSystemLabel.attributedText = attrText;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchContinue:)];
    [self.touchToContinueView addGestureRecognizer:tap];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}


DeallocFun()

@end
