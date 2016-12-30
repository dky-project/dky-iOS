//
//  DKYTabBar.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYTabBar.h"

@interface DKYTabBar ()

@property (nonatomic, weak) UIImageView *selectionIndicatorImageView;

@property (nonatomic, weak) UITabBarItem *lastSelectedTabBarItem;

@end

@implementation DKYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemWidth = kScreenWidth / 4;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}

- (void)setSelectedBackgrounColor:(UIColor *)selectedBackgrounColor{
    _selectedBackgrounColor = selectedBackgrounColor;
    
    if(!selectedBackgrounColor) return;
    
    
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem{
    [super setSelectedItem:selectedItem];
    
    DLog(@"selectedItem.title = %@, tag = %@",selectedItem.title,@(selectedItem.tag));
    
    if(self.lastSelectedTabBarItem == selectedItem) return;
    
    self.lastSelectedTabBarItem = selectedItem;
    CGFloat w = self.tw_width / self.items.count;
    CGFloat h = self.tw_height;
    self.selectionIndicatorImageView.frame = CGRectMake(selectedItem.tag * w, 0, w, h);
}

- (void)setupSelectionIndicatorImageView:(UIView*)tabBarButton{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor randomColor]]];
    CGFloat w = self.tw_width;
    imageView.frame = CGRectMake(0, 0, w/4, self.tw_height);
    [self insertSubview:imageView belowSubview:tabBarButton];
    self.selectionIndicatorImageView = imageView;
}

- (void)setupAllTabBarButtonsFrame
{
    NSInteger index = 0;
    
    for(UITabBarItem *tabbarItem in self.items){
        tabbarItem.tag = index++;
    }
    
    index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        if(index == 0){
            [self setupSelectionIndicatorImageView:(UIView*)tabBarButton];
        }
        
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

@end
