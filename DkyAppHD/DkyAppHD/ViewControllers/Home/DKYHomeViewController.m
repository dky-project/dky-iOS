//
//  DKYHomeViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeViewController.h"
#import "DKYHomeItemView.h"
#import "DKYHomeItemTwoView.h"

@interface DKYHomeViewController ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,weak) iCarousel *iCarousel;

@property (nonatomic, weak) id<DKYHomeItemDelegate> previousItemView;

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

#pragma mark - private method
- (UIView*)createItemViewWithIndex:(NSInteger)index{
    UIView *view = nil;
    switch (index) {
        case 0:
        case 2:{
            view = [DKYHomeItemView homeItemView];
            if(index == 0){
                id<DKYHomeItemDelegate> itemView = (id<DKYHomeItemDelegate>)view;
                self.previousItemView = itemView;
            }
        }
            break;
        case 1:
        case 3:{
            view = [DKYHomeItemTwoView homeItemTwoView];
            if(index == 1){
                id<DKYHomeItemDelegate> itemView = (id<DKYHomeItemDelegate>)view;
                [itemView updateFrame:NO];
            }
        }
            break;
            
        default:
            view = [DKYHomeItemView homeItemView];
            break;
    }
    return view;
}

- (UIView*)checkItemViewClass:(UIView *)view index:(NSInteger)index{
    if(view == nil) return [self createItemViewWithIndex:index];

    switch (index) {
        case 0:
        case 2:{
            if(![view isKindOfClass:[DKYHomeItemView class]]){
                return [self createItemViewWithIndex:index];
            }
        }
            break;
            
        case 1:
        case 3:{
            if(![view isKindOfClass:[DKYHomeItemView class]]){
                return [self createItemViewWithIndex:index];
            }
        }
            break;
            
        default:
            view = [DKYHomeItemView homeItemView];
            break;
    }
    return view;
}

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar tw_setStatusBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    [self.navigationController.navigationBar tw_hideNavigantionBarBottomLine:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupiCarousel];
}

- (void)setupiCarousel{
    iCarousel *view = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight - 20)];
    [self.view addSubview:view];
    view.delegate = self;
    view.dataSource = self;
    view.bounces = YES;
    view.pagingEnabled = YES;
    view.type = iCarouselTypeCustom;
    view.vertical = YES;
    view.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
//    view.numberOfVisibleItems = 4;
    self.iCarousel = view;
    [view scrollToItemAtIndex:1 animated:NO];
}

#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Tapped view number: %@", @(index));
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
//    CATransform3D transform = CATransform3DIdentity;
//    CATransform3DScale(transform, 1.0, 0.5, 1);
//    transform = CATransform3DInvert(transform);
//    [self.previousItemView updateTransform:transform];
//    
    [self.previousItemView hideReadMoreBtn:YES];
    [self.previousItemView updateFrame:YES];
    
    id<DKYHomeItemDelegate> itemView = (id<DKYHomeItemDelegate>)carousel.currentItemView;
    if([itemView respondsToSelector:@selector(hideReadMoreBtn:)]){
        [itemView hideReadMoreBtn:NO];
        [itemView updateFrame:NO];
    }
    self.previousItemView = itemView;
    NSLog(@"Index: %@", @(self.iCarousel.currentItemIndex));
}

#pragma mark - iCarousel代理
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    return [self checkItemViewClass:view index:index];
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
//    NSLog(@"offset = %lf",offset);
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.5f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, 1.0, scale, 1);
    }else{
        transform = CATransform3DScale(transform, 1.0, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, 0.0, offset * self.iCarousel.itemWidth * 0.9, 0.0);
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 4;
}

@end
