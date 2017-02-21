//
//  DKYWebViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/12.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYWebViewController.h"

@interface DKYWebViewController ()

@end

@implementation DKYWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showActionButton = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showActionButton = NO;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]){
        self.showActionButton = NO;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.showActionButton = NO;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    
    UIColor* tintColor = [UIColor whiteColor];
    UIColor* barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.tintColor = tintColor;
    self.navigationController.navigationBar.barTintColor = barTintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}];
}


@end
