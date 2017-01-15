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
#import "DKYBootImageModel.h"

static NSString *const kPreviousBootImageModelKey = @"kPreviousBootImageModelKey";

@interface DKYGuidenceViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgrondImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderingSystemLabel;
@property (weak, nonatomic) IBOutlet UIView *touchToContinueView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *homeSiteLabel;
@property (nonatomic, strong) DKYBootImageModel *bootImageModel;
@property (nonatomic, strong) UIImage *placeholderImage;

@end

@implementation DKYGuidenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
    
    [self queryBootImageFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)queryBootImageFromServer{
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] queryValidUrlWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSArray *array = result.data;
            weakSelf.bootImageModel = [ DKYBootImageModel mj_objectWithKeyValues:[array firstObject]];
            [weakSelf updateBootImage];
            [[YYCache defaultCache] setObject:(id<NSCoding>)weakSelf.bootImageModel forKey:kPreviousBootImageModelKey];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - private method
- (void)updateBootImage{
    NSURL *imageUrl = [NSURL URLWithString:self.bootImageModel.imageurl];
    [self.backgrondImageView sd_setImageWithURL:imageUrl placeholderImage:self.placeholderImage];
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
        transition.animationType = WXSTransitionAnimationTypeInsideThenPush;
        transition.animationTime = 1.0;
    } completion:^{
        
    }];
}

#pragma mark - Ui

- (void)commonInit{
    NSDictionary *dict = @{NSForegroundColorAttributeName : self.orderingSystemLabel.textColor,
                           NSFontAttributeName : self.orderingSystemLabel.font};
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:self.orderingSystemLabel.text attributes:dict];
    NSString *versionText = @"Beta 1.0";
    NSRange range = [self.orderingSystemLabel.text rangeOfString:versionText];
    [attrText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xA52C2D] range:range];
    self.orderingSystemLabel.attributedText = attrText;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchContinue:)];
    [self.touchToContinueView addGestureRecognizer:tap];
    
    self.placeholderImage = [UIImage imageNamed:@"guidence_back_placeholder"];
    
    self.bootImageModel = (DKYBootImageModel*)[[YYCache defaultCache] objectForKey:kPreviousBootImageModelKey];
    if(self.bootImageModel && self.bootImageModel.imageurl.length > 0){
        UIImage *image = [[SDWebImageManager sharedManager] diskImageForUrl:self.bootImageModel.imageurl];
        if(image){
            self.placeholderImage = image;
        }
    }
    
    self.backgrondImageView.image = self.placeholderImage;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}


DeallocFun()

@end
