//
//  DKYHomeViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeViewController.h"

@interface DKYHomeViewController ()

@end

@implementation DKYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    [self.navigationController.navigationBar lt_setTranslationY:-44];
    [self hideNavigantionBarBottomLine:YES];
    
    self.view.backgroundColor = [UIColor randomColor];
}

@end
