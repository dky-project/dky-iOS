//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation UINavigationBar (Awesome)
static char overlayKey;
static char statusBarBgKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)statusBarBgView
{
    return objc_getAssociatedObject(self, &statusBarBgKey);
}

- (void)setStatusBarBgView:(UIView *)statusBarBgView
{
    objc_setAssociatedObject(self, &statusBarBgKey, statusBarBgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)tw_setStatusBackgroundColor:(UIColor *)backgroundColor{
    if (!self.statusBarBgView) {
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        self.statusBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), rectStatus.size.height)];
        self.statusBarBgView.userInteractionEnabled = NO;
        self.statusBarBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
//        [self.overlay.superview insertSubview:self.statusBarBgView aboveSubview:self.overlay];
        [[self.subviews firstObject] addSubview:self.statusBarBgView];
        [[self.subviews firstObject] bringSubviewToFront:self.statusBarBgView];
    }
    self.statusBarBgView.backgroundColor = backgroundColor;
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
            obj.alpha = alpha;
        }
    }];
}

- (void)tw_hideNavigantionBarBottomLine:(BOOL)hide
{
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.subviews;
        if(IS_IOS_10_OR_LATER){
            for (UIView *obj in list) {
                if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                    for (id objEx in obj.subviews){
                        UIImageView *imageView=(UIImageView *)objEx;
                        CGFloat height = CGRectGetHeight(imageView.frame);
                        if(height < 1.0){
                            imageView.hidden = hide;
                        }
                    }
                }
            }

        }else{
            for (id obj in list) {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=hide;
                        }
                    }
                }
            }
        }
    }
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
    
    [self.statusBarBgView removeFromSuperview];
    self.statusBarBgView = nil;
    
    [self tw_hideNavigantionBarBottomLine:NO];
}

@end
