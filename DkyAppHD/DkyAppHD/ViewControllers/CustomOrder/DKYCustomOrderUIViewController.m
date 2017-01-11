//
//  DKYCustomOrderUIViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderUIViewController.h"

@interface DKYCustomOrderUIViewController ()

@end

@implementation DKYCustomOrderUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)commonInit{
    self.view.backgroundColor = [UIColor randomColor];
}

#pragma mark - Test

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[DKYAccountManager sharedInstance] deleteAccesToken];
}

@end
