//
//  DKYWebViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/12.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYWebViewController.h"

@interface DKYWebViewController ()

@property (nonatomic, strong) TWNavBtnItem *leftBtnItem;

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
    
    [self setupDefaultSettings];
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
    self.buttonTintColor = [UIColor whiteColor];
    
    self.navigationItem.leftItemsSupplementBackButton = NO;
    
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    
    UIColor* tintColor = [UIColor whiteColor];
//    UIColor* barTintColor = [UIColor blueColor];
//    self.navigationController.navigationBar.tintColor = tintColor;
//    self.navigationController.navigationBar.barTintColor = barTintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}];
}

#pragma mark - 导航栏上按钮action 时间
- (void)leftBtnClicked:(UIButton*)sender{
    // 如果子类设置了block，就让子类负责返回操作，不然，执行默认操作
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setLeftBtnItem:(TWNavBtnItem *)leftBtnItem{
    _leftBtnItem = leftBtnItem;
    [self setupLeftButton];
}

- (void)setupLeftButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = self.leftBtnItem.titleFont;
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:self.leftBtnItem.normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:self.leftBtnItem.title forState:UIControlStateNormal];
    [btn setTitle:self.leftBtnItem.title forState:UIControlStateHighlighted];
    
    UIImage *image = self.leftBtnItem.normalImage;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *himage = self.leftBtnItem.hilightedImage;
    himage = [himage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:himage forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGRect textFrame = CGRectMake(0, 6, 40, 40);
    
    
    switch (self.leftBtnItem.itemType) {
        case TWNavBtnItemType_Text:{
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            UIColor *foregroundColor = self.leftBtnItem.normalTitleColor;
            NSDictionary *attributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName: foregroundColor};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleFrame = [self.leftBtnItem.title boundingRectWithSize:size
                                                                     options:options
                                                                  attributes:attributes
                                                                     context:nil];
            textFrame.size.width = MAX(textFrame.size.width, titleFrame.size.width);
        }
            break;
        case TWNavBtnItemType_ImageAndText:{
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            UIColor *foregroundColor = self.leftBtnItem.normalTitleColor;
            NSDictionary *attributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName: foregroundColor};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleFrame = [self.leftBtnItem.title boundingRectWithSize:size
                                                                     options:options
                                                                  attributes:attributes
                                                                     context:nil];
            CGSize imageSize = self.leftBtnItem.normalImage.size;
            textFrame.size.width += (titleFrame.size.width + imageSize.width + self.leftBtnItem.titleOffsetX);
        }
            break;
        case TWNavBtnItemType_Unset:
        case TWNavBtnItemType_Image:
            break;
        default:
            break;
    }
    
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.leftBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    flexSpacer.width = (self.leftBtnItem.offetX - 16);  // left btn 的x坐标为10,
//    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:flexSpacer,leftItem, nil]];
    
    self.applicationLeftBarButtonItems = [NSArray arrayWithObjects:flexSpacer,leftItem, nil];
}

#pragma mark - 默认值设置
- (void)setupDefaultSettings{
    TWNavBtnItem *leftBtnItem = [[TWNavBtnItem alloc]init];
    leftBtnItem.itemType = TWNavBtnItemType_ImageAndText;
    leftBtnItem.title = @"返回";
    self.leftBtnItem = leftBtnItem;
}


@end
