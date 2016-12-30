//
//  UIStoryboard+Utility.h
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Utility)

+ (UIViewController*)viewControllerWithStoryboardID:(NSString*)storyboardID;

+ (UIViewController*)viewControllerWithClass:(Class)classVC;

+ (UIViewController*)viewControllerWithClassName:(NSString*)className;

@end
