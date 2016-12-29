//
//  UIBarButtonItem+Extension.m
//  DjdApp
//
//  Created by Rio on 16/8/1.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    
    // 设置尺寸
    //    btn.size = btn.currentImage.size;
    btn.mj_w = 20;
    btn.mj_h = 20;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
