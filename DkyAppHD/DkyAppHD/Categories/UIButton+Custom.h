//
//  UIButton+Custom.h
//  DycApp
//
//  Created by HaKim on 15/12/24.
//  Copyright © 2015年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonCustomType) {
    UIButtonCustomType_Unset = 0,
    UIButtonCustomType_One, // 偏橙色
    UIButtonCustomType_Two, // 偏蓝色
    UIButtonCustomType_Three, // 白色
    UIButtonCustomType_Four, // 普通白色背景，橙色字，高亮橙色背景，白色字
    UIButtonCustomType_Five, // 用在产品列表，敬请期待里的按钮
    
    UIButtonCustomType_Six
};

@interface UIButton (Custom)

- (void)customButtonWithType:(UIButtonCustomType)type;

+ (instancetype)buttonWithCustomType:(UIButtonCustomType)type;

@end
