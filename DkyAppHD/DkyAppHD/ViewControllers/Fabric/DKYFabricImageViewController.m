//
//  DKYFabricImageViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2019/9/18.
//  Copyright © 2019 haKim. All rights reserved.
//

#import "DKYFabricImageViewController.h"
#import "SDCycleScrollView.h"
#import "DKYProductImgModel.h"

static NSString* const defaultRightBtnTitle = @"返回";

@interface DKYFabricImageViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) UIButton *rigthBtn;

// 自定义设置
@property (nonatomic, strong) TWNavBtnItem *leftBtnItem;

@property (nonatomic, strong) TWNavBtnItem *rightBtnItem;

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

@end

@implementation DKYFabricImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupDefaultSettings];
}

-(void)didInitialize{
    [super didInitialize];
    
    [self commonInit];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.cycleScrollView.imageURLStringsGroup  = self.productImgModel.detialImgList;
}

#pragma mark - delegate
- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]];
}

- (nullable UIColor *)titleViewTintColor{
    return [UIColor whiteColor];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - ui
- (void)commonInit{
    self.title = @"色卡";
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupBannerView];
    //self.view.backgroundColor = [UIColor randomColor];
}

- (void)setupBannerView{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:NO imageNamesGroup:nil];
    
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScroll = NO;
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    cycleScrollView.currentPageDotColor = [UIColor colorWithHex:0x3C3362];
    self.cycleScrollView = cycleScrollView;
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
//    self.cycleScrollView.imageURLStringsGroup = @[@"http://116.62.246.199:90/img_sl/19D074.jpg?modifieddate=1568104405000",@"http://116.62.246.199:90/img_sl/19D082.jpg?modifieddate=1568104405000"];
}

#pragma mark - 默认值设置
- (void)setupDefaultSettings{
    //self.view.backgroundColor = [UIColor orangeColor];
    TWNavBtnItem *leftBtnItem = [[TWNavBtnItem alloc]init];
    leftBtnItem.itemType = TWNavBtnItemType_ImageAndText;
    leftBtnItem.title = @"返回";
    self.leftBtnItem = leftBtnItem;
}

- (void)setLeftBtnItem:(TWNavBtnItem *)leftBtnItem{
    _leftBtnItem = leftBtnItem;
    [self setupLeftButton];
}


#pragma mark - private method

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
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:flexSpacer,leftItem, nil]];
}

#pragma mark - 导航栏上按钮action 时间
- (void)leftBtnClicked:(UIButton*)sender{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
