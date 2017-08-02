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
    
    UIButtonCustomType_Six, // 字体12，黑色，边界线淡一点
    UIButtonCustomType_Seven, // 字体12，黑色，边界线深一点
    UIButtonCustomType_Eigh, // 用作checkbox
    UIButtonCustomType_Nine, // 红色边框，红色字体
    UIButtonCustomType_Ten, // 类似five
    
    UIButtonCustomType_Eleven, // six 类似，字体大一点
    
    UIButtonCustomType_Twelve,  // 白底，和边框，黑字
};

@interface UIButton (Custom)

- (void)customButtonWithType:(UIButtonCustomType)type;

- (void)customButtonWithTypeEx:(UIButtonCustomType)type;

+ (instancetype)buttonWithCustomType:(UIButtonCustomType)type;

// 额外信息
@property (nonatomic, strong) NSString *extraInfo;

// 初始标题
@property (nonatomic, strong) NSString *originalTitle;

@end
