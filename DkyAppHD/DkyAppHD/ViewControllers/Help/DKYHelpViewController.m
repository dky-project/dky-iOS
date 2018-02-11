//
//  DKYHepViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/2/8.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYHelpViewController.h"

@interface DKYHelpViewController ()

@property (nonatomic, assign) BOOL firstLoaded;

@end

@implementation DKYHelpViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showActionButton = NO;
        self.firstLoaded = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showActionButton = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    [self setupCustomTitle:self.title];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]){
        self.showActionButton = NO;
        self.firstLoaded = YES;
        self.showPageTitles = NO;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.showActionButton = NO;
        self.firstLoaded = YES;
        self.showPageTitles = NO;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.buttonTintColor = [UIColor whiteColor];
    
    self.navigationItem.leftItemsSupplementBackButton = NO;
    
    if(self.showHUD && !self.firstLoaded){
        [DKYHUDTool show];
        self.url = [NSURL URLWithString:self.url.absoluteString];
    }
    
    if(self.firstLoaded){
        self.firstLoaded = NO;
    }
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
