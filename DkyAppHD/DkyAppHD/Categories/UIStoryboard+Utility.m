//
//  UIStoryboard+Utility.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "UIStoryboard+Utility.h"

@implementation UIStoryboard (Utility)

+ (UIViewController*)viewControllerWithStoryboardID:(NSString*)storyboardID{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:storyboardID];
    return vc;
}

+ (UIViewController*)viewControllerWithClass:(Class)classVC{
    
    return [self viewControllerWithClassName:NSStringFromClass(classVC)];
}

+ (UIViewController*)viewControllerWithClassName:(NSString*)className{
    return [self viewControllerWithStoryboardID:className];
}

@end
