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

@interface DKYLoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundInageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

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

#pragma mark - action method

- (void)loginBtnClicked:(UIButton*)sender{
    DKYTabBarViewController *mainVc = (DKYTabBarViewController*)[UIStoryboard viewControllerWithClass:[DKYTabBarViewController class]];
    
    [self wxs_presentViewController:mainVc makeTransition:^(WXSTransitionProperty *transition) {
        transition.animationType = WXSTransitionAnimationTypeBrickOpenHorizontal;
        transition.animationTime = 1.2;
    } completion:^{
        
    }];
}

#pragma mark - Ui

- (void)commonInit{
    self.backgroundInageView.image = [UIImage imageWithColor:[UIColor randomColor]];
    
    [self setupTextField];
    
    [self setupLoginBtn];
}

- (void)setupTextField{
    self.userNameTextField.layer.cornerRadius = 5.0;
    self.userNameTextField.layer.borderWidth = 1.0;
    self.userNameTextField.layer.borderColor = [UIColor colorWithHex:0x575757].CGColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    imageView.frame = CGRectMake(0, 0, 41, 50);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageWithColor:[UIColor randomColor] size:CGSizeMake(20, 30)];
    self.userNameTextField.leftView = imageView;
    
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.layer.borderWidth = 1.0;
    self.passwordTextField.layer.borderColor = [UIColor colorWithHex:0x575757].CGColor;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    imageView.frame = CGRectMake(0, 0, 41, 50);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageWithColor:[UIColor randomColor] size:CGSizeMake(20, 30)];
    self.passwordTextField.leftView = imageView;
}

- (void)setupLoginBtn{
    self.loginBtn.layer.cornerRadius = 5.0;
    UIImage *norImage = [UIImage imageWithColor:[UIColor colorWithHex:0x3E3E3E]];
    [self.loginBtn setBackgroundImage:norImage forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

@end
