//
//  DKYTabBar.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYTabBar.h"

@interface DKYTabBar ()

@property (nonatomic, strong) UIImage *mySelectionIndicatorImage;

@end

@implementation DKYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
    
    self.itemWidth = [UIApplication sharedApplication].keyWindow.frame.size.width / self.items.count;
    DLog(@"self.itemWidth = %@",@(self.itemWidth));
    
    self.selectionIndicatorImage = self.mySelectionIndicatorImage;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated{
    [super setItems:items animated:animated];
    
    if(self.items.count <= 0) return;
    
    self.itemWidth = [UIApplication sharedApplication].keyWindow.frame.size.width / self.items.count;
}

- (void)setSelectedBackgrounColor:(UIColor *)selectedBackgrounColor{
    _selectedBackgrounColor = selectedBackgrounColor;
    
    if(!selectedBackgrounColor || self.itemWidth == 0 || self.tw_width == 0) return;
    
    _mySelectionIndicatorImage = [UIImage imageWithColor:selectedBackgrounColor size:CGSizeMake(self.itemWidth, self.tw_height)];
    self.selectionIndicatorImage = self.mySelectionIndicatorImage;
}

- (void)rotate:(BOOL)landscape{
    [self setNeedsLayout];
    if (landscape) { // 横屏
        
    } else { // 竖屏
        
    }
}

#pragma private method

- (void)setupAllTabBarButtonsFrame
{
    NSInteger index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(NSInteger)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.tw_width / (self.items.count);
    CGFloat buttonH = self.tw_height;
    
    tabBarButton.tw_width = buttonW;
    tabBarButton.tw_height = buttonH;
    tabBarButton.tw_x = buttonW * index;
    tabBarButton.tw_y = 0;
    
    // 计算button的尺寸
//    CGFloat areaW = self.tw_width / (self.items.count);
//    CGFloat areaX = areaW * index;
//    CGFloat areaY = 1;
//    
//    CGFloat buttonW = tabBarButton.tw_width;
//    CGFloat buttonH = tabBarButton.tw_height;
//    
//    tabBarButton.tw_width = buttonW;
//    tabBarButton.tw_height = buttonH;
//    tabBarButton.tw_x = (areaW - buttonW) / 2.0 + areaX;
//    tabBarButton.tw_y = areaY;
}

#pragma mark - get & set method

- (UIImage*)mySelectionIndicatorImage{
    UIColor *color = self.selectedBackgrounColor ? self.selectedBackgrounColor : [UIColor clearColor];
    _mySelectionIndicatorImage = [UIImage imageWithColor:color size:CGSizeMake(self.itemWidth, self.tw_height)];
    return _mySelectionIndicatorImage;
}

@end
