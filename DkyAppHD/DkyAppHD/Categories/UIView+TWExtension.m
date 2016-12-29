//
//  UIView+TWExtension.m
//  DjdApp
//
//  Created by HaKim on 16/3/21.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "UIView+TWExtension.h"

@implementation UIView (TWExtension)

- (void)setTw_x:(CGFloat)jjw_x
{
    CGRect frame = self.frame;
    frame.origin.x = jjw_x;
    self.frame = frame;
}

- (CGFloat)tw_x
{
    return self.frame.origin.x;
}

- (void)setTw_y:(CGFloat)jjw_y
{
    CGRect frame = self.frame;
    frame.origin.y = jjw_y;
    self.frame = frame;
}

- (CGFloat)tw_y
{
    return self.frame.origin.y;
}

- (void)setTw_width:(CGFloat)jjw_width
{
    CGRect frame = self.frame;
    frame.size.width = jjw_width;
    self.frame = frame;
}

- (CGFloat)tw_width
{
    return self.frame.size.width;
}

- (void)setTw_height:(CGFloat)jjw_height
{
    CGRect frame = self.frame;
    frame.size.height = jjw_height;
    self.frame = frame;
}

- (CGFloat)tw_height
{
    return self.frame.size.height;
}

- (void)setTw_size:(CGSize)jjw_size
{
    CGRect frame = self.frame;
    frame.size = jjw_size;
    self.frame = frame;
}

- (CGSize)tw_size
{
    return self.frame.size;
}

- (void)setTw_origin:(CGPoint)jjw_origin
{
    CGRect frame = self.frame;
    frame.origin = jjw_origin;
    self.frame = frame;
}

- (CGPoint)tw_origin
{
    return self.frame.origin;
}

- (NSString*)tw_frame
{
    return NSStringFromCGRect(self.frame);
}

- (void)setTw_frame:(NSString *)jjw_frame
{
    
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
