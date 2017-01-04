//
//  UIView+TWExtension.h
//  DjdApp
//
//  Created by HaKim on 16/3/21.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TWExtension)

@property (assign, nonatomic) CGFloat tw_x;
@property (assign, nonatomic) CGFloat tw_y;
@property (assign, nonatomic) CGFloat tw_width;
@property (assign, nonatomic) CGFloat tw_height;
@property (assign, nonatomic) CGSize tw_size;
@property (assign, nonatomic) CGPoint tw_origin;
@property (copy, nonatomic) NSString *tw_frame;

- (UIViewController*)viewController;

@end
