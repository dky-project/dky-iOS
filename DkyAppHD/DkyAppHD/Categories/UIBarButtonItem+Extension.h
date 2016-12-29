//
//  UIBarButtonItem+Extension.h
//  DjdApp
//
//  Created by Rio on 16/8/1.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+MJExtension.h"

@interface UIBarButtonItem (Extension)

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
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
