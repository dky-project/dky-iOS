//
//  DKYTabBar.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYTabBar.h"

@interface DKYTabBar ()

// 横屏选中的背景色
@property (nonatomic, strong) UIImage *landscapeImage;

// 竖屏选中的背景色
@property (nonatomic, strong) UIImage *portraitImage;

@property (nonatomic, assign) BOOL landscape;

@end

@implementation DKYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemWidth = kScreenWidth / 4;
        self.itemPositioning = UITabBarItemPositioningFill;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.selectionIndicatorImage = [self getSelectionIndicatorImage];
}

- (void)setSelectedBackgrounColor:(UIColor *)selectedBackgrounColor{
    _selectedBackgrounColor = selectedBackgrounColor;
    
    if(!selectedBackgrounColor || [self tabBarButtonWidth] < 1.0) return;
    
    if(self.landscape){
        self.landscapeImage = [UIImage imageWithColor:selectedBackgrounColor size:CGSizeMake([self tabBarButtonWidth], self.tw_height)];
        self.portraitImage = nil;
    }else{
        self.landscapeImage = nil;
        self.portraitImage = [UIImage imageWithColor:selectedBackgrounColor size:CGSizeMake([self tabBarButtonWidth], self.tw_height)];
    }
}

- (void)rotate:(BOOL)landscape{
    self.landscape = landscape;
    [self setNeedsLayout];
}

- (UIImage*)getSelectionIndicatorImage{
    UIColor *color = self.selectedBackgrounColor ? self.selectedBackgrounColor : [UIColor clearColor];
    UIImage *image = nil;
    if(self.landscape){
        if(!self.landscapeImage){
            self.landscapeImage = [UIImage imageWithColor:color size:CGSizeMake([self tabBarButtonWidth], self.tw_height)];
        }
        image = self.landscapeImage;
    }else{
        if(!self.portraitImage){
            self.portraitImage = [UIImage imageWithColor:color size:CGSizeMake([self tabBarButtonWidth], self.tw_height)];
        }
        image = self.portraitImage;
    }
    return image;
}

- (CGFloat)tabBarButtonWidth{
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        return tabBarButton.size.width;
    }
    return CGFLOAT_MIN;
}

@end
