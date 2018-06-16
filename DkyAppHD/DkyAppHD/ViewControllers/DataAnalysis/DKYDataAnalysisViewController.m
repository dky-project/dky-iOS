//
//  DKYDataAnalysisViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/16.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYDataAnalysisViewController.h"
#import "DKYDataAnalysisSummarizingView.h"

@interface DKYDataAnalysisViewController ()

@property (nonatomic, weak) DKYDataAnalysisSummarizingView *header;

@end

@implementation DKYDataAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didInitialize{
    [super didInitialize];

    [self commonInit];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    WeakSelf(weakSelf);
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(0);
    }];
}

#pragma mark - delegate
- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]];
}

- (nullable UIColor *)titleViewTintColor{
    return [UIColor whiteColor];
}

#pragma common init
- (void)commonInit{
    self.view.backgroundColor = [UIColor randomColor];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self setupHeaderView];
}

- (void)setupHeaderView{
    DKYDataAnalysisSummarizingView *view = [[DKYDataAnalysisSummarizingView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
    self.header = view;
}
@end
