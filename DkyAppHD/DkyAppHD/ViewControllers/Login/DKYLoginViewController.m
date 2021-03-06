//
//  DKYLoginViewController.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYLoginViewController.h"
#import "DKYTabBarViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "DKYLoginUserRequestParameter.h"
#import "AppDelegate.h"

@interface DKYLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOffsetCst1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOffsetCst2;

@end

@implementation DKYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络接口
- (void)login{
    [DKYHUDTool showWithStatus:@"Login..."];
    WeakSelf(weakSelf);
    DKYLoginUserRequestParameter *p = [[DKYLoginUserRequestParameter alloc] init];
    p.email = self.userNameTextField.text;
    p.password = self.passwordTextField.text;
    
#pragma warning - 去掉延时代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DKYHttpRequestManager sharedInstance] LoginUserWithParameter:p Success:^(NSInteger statusCode, id data) {
            [DKYHUDTool dismiss];
            DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
            DkyHttpResponseCode retCode = [result.code integerValue];
            if (retCode == DkyHttpResponseCode_Success) {
                [DKYHUDTool showSuccessWithStatus:@"登录成功"];
                [[DKYAccountManager sharedInstance] saveAccessToken:result.data];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf loginSuccessful];
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
            [DKYHUDTool showErrorWithStatus:kNetworkError];
        }];
    });
}

#pragma mark - private method

- (void)loginSuccessful{
    WeakSelf(weakSelf);
    if(IS_IOS_11_OR_LATER ){
        if(weakSelf.fromLogout){
            [self dismissViewControllerAnimated:YES completion:^{
                AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UITabBarController *main =(UITabBarController*) app.window.rootViewController;
                if(weakSelf.fromLogout){
                    main.selectedIndex = 0;
                }
            }];
        }else{
            DKYTabBarViewController *mainVc = (DKYTabBarViewController*)[UIStoryboard viewControllerWithClass:[DKYTabBarViewController class]];
            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            app.window.rootViewController = mainVc;
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
        return;
    }
    DKYTabBarViewController *mainVc = (DKYTabBarViewController*)[UIStoryboard viewControllerWithClass:[DKYTabBarViewController class]];
    
    [self wxs_presentViewController:mainVc makeTransition:^(WXSTransitionProperty *transition) {
        transition.animationType = WXSTransitionAnimationTypeBrickOpenHorizontal;
        transition.animationTime = 1.0;
    } completion:^{
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        app.window.rootViewController = mainVc;
    }];
}

- (BOOL)checkLoginStatus{
    if(self.userNameTextField.text.length == 0){
        [DKYHUDTool showInformation:@"登录名不能为空" toView:self.view];
        return NO;
    }
    
    if(self.passwordTextField.text.length == 0){
        [DKYHUDTool showInformation:@"密码不能为空" toView:self.view];
        return NO;
    }
    
    return YES;
}

#pragma mark - action method

- (void)loginBtnClicked:(UIButton*)sender{
    if(![self checkLoginStatus]) return;
    
    [self login];
}

#pragma mark - 屏幕翻转就会调用
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    DLog(@"size = %@",NSStringFromCGSize(size));
    // 记录当前是横屏还是竖屏
    BOOL isLandscape = isLandscape(size);
    
    // 翻转的时间
    CGFloat duration = [coordinator transitionDuration];
    
    [UIView animateWithDuration:duration animations:^{
        if(isLandscape){
            self.topOffsetCst1.constant = 200 * 0.75;
            self.topOffsetCst2.constant = 236 * 0.75;
        }else{
            self.topOffsetCst1.constant = 200;
            self.topOffsetCst2.constant = 236;
        }
    }];
}

#pragma mark - Ui

- (void)commonInit{
    self.backgroundImageView.image = [UIImage imageNamed:@"login_placeholder"];
    
    [self setupTextField];
    
    [self setupLoginBtn];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [self viewWillTransitionToSize:CGSizeMake(self.view.tw_width, self.view.tw_height) withTransitionCoordinator:nil];
#pragma clang diagnostic pop
    
#pragma mark mark - 测试代码
    
#ifdef DEBUG
    self.userNameTextField.text = @"nea@burgeon.com.cn";
    self.passwordTextField.text = @"henlo.net";
    
    self.userNameTextField.text = @"X31";
    self.passwordTextField.text = @"123";
#endif
}

- (void)setupTextField{
    self.userNameTextField.layer.cornerRadius = 5.0;
    self.userNameTextField.layer.borderWidth = 1.0;
    self.userNameTextField.layer.borderColor = [UIColor colorWithHex:0x575757].CGColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    imageView.frame = CGRectMake(0, 0, 41, 50);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"login_username"];
    self.userNameTextField.leftView = imageView;
    
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.layer.borderWidth = 1.0;
    self.passwordTextField.layer.borderColor = [UIColor colorWithHex:0x575757].CGColor;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    imageView.frame = CGRectMake(0, 0, 41, 50);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"login_password"];
    self.passwordTextField.leftView = imageView;
    
//    self.userNameTextField.font = [UIFont systemFontOfSize:50];
//    self.passwordTextField.font = [UIFont systemFontOfSize:20];
}

- (void)setupLoginBtn{
    self.loginBtn.layer.cornerRadius = 5.0;
    UIImage *norImage = [UIImage imageWithColor:[UIColor colorWithHex:0x3E3E3E]];
    [self.loginBtn setBackgroundImage:norImage forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

@end
