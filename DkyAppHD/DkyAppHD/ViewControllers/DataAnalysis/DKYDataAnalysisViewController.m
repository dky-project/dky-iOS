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
    
    [self getDataAnalysisListFromServer];
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

#pragma mark - api
- (void)getDataAnalysisListFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    [[DKYHttpRequestManager sharedInstance] getDataAnalysisListPageWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {

        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        [DKYHUDTool dismiss];
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
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
