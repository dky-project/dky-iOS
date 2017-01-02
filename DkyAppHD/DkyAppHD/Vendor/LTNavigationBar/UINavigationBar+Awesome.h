//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;

// 状态栏的背景色
- (void)tw_setStatusBackgroundColor:(UIColor *)backgroundColor;
// 去掉导航栏下面的黑线
- (void)tw_hideNavigantionBarBottomLine:(BOOL)hide;
@end
