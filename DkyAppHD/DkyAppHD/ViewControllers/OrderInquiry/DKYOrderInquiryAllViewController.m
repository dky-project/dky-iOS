//
//  DKYOrderInquiryAllViewController.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInquiryAllViewController.h"
#import "DKYOrderInquiryViewController.h"
#import "DKYDahuoOrderInquiryViewController.h"

@interface DKYOrderInquiryAllViewController ()

// 返回按钮回调的block
@property (nonatomic, copy)TWBaseViewControllerRightBtnClickedBlock rightBtnClicked;

@property (nonatomic, strong) TWNavBtnItem *rightBtnItem;

@end

@implementation DKYOrderInquiryAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBtnClicked:(UIButton*)sender{
    if(self.rightBtnClicked){
        self.rightBtnClicked(sender);
    }
}

- (void)setRightBtnItem:(TWNavBtnItem *)rightBtnItem{
    _rightBtnItem = rightBtnItem;
    
    [self setupRightButton];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSArray *titleList = @[@""];
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *gridId = @"CustomOrderInquery.identifier";
    UIViewController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[DKYOrderInquiryViewController alloc] init];
    }
    return viewController;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    
}

#pragma mark - UI
- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"订单查询"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    self.magicView.navigationHeight = 0;
    self.magicView.delegate = self;
    self.magicView.dataSource = self;
    [self.magicView reloadData];
    
    [self setupLogoutBtn];
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

- (void)setupLogoutBtn{
    TWNavBtnItem *rightBtnItem = [[TWNavBtnItem alloc]init];
    
    rightBtnItem.itemType = TWNavBtnItemType_Text;
    rightBtnItem.title = kSignOutText;
    rightBtnItem.normalImage = nil;
    rightBtnItem.hilightedImage = nil;
    self.rightBtnItem = rightBtnItem;
    
    self.rightBtnClicked = ^(UIButton *sender) {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:kNoText style:QMUIAlertActionStyleDefault handler:NULL];
        
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:kYesText style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }];
        
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:kHintText message:kSignOutContent preferredStyle:QMUIAlertControllerStyleAlert];
        
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];
    };
}

- (void)setupRightButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = self.rightBtnItem.titleFont;
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:self.rightBtnItem.normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:self.rightBtnItem.title forState:UIControlStateNormal];
    [btn setTitle:self.rightBtnItem.title forState:UIControlStateHighlighted];
    
    UIImage *image = self.rightBtnItem.normalImage;
    if(image){
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    UIImage *himage = self.rightBtnItem.hilightedImage;
    himage = [himage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if(himage){
        [btn setImage:himage forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGRect textFrame = CGRectMake(0, 6, 40, 40);
    
    
    switch (self.rightBtnItem.itemType) {
        case TWNavBtnItemType_Text:{
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            UIColor *foregroundColor = self.rightBtnItem.normalTitleColor;
            NSDictionary *attributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName: foregroundColor};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleFrame = [self.rightBtnItem.title boundingRectWithSize:size
                                                                      options:options
                                                                   attributes:attributes
                                                                      context:nil];
            textFrame.size.width = MAX(textFrame.size.width, titleFrame.size.width + 1 + self.rightBtnItem.titleOffsetX);
        }
            break;
        case TWNavBtnItemType_ImageAndText:{
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            UIColor *foregroundColor = self.rightBtnItem.normalTitleColor;
            NSDictionary *attributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName: foregroundColor};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleFrame = [self.rightBtnItem.title boundingRectWithSize:size
                                                                      options:options
                                                                   attributes:attributes
                                                                      context:nil];
            CGSize imageSize = self.rightBtnItem.normalImage.size;
            textFrame.size.width += (titleFrame.size.width + imageSize.width + self.rightBtnItem.titleOffsetX);
        }
            break;
        case TWNavBtnItemType_Unset:
        case TWNavBtnItemType_Image:
            break;
        default:
            break;
    }
    
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.rightBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    flexSpacer.width = (self.rightBtnItem.offetX - 16);  // right btn 的x坐标为10,
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:flexSpacer,rightItem, nil]];
}

@end
