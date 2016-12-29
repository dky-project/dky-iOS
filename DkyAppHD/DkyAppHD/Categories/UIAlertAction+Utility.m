//
//  UIAlertAction+Utility.m
//  DjdApp
//
//  Created by HaKim on 16/7/28.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "UIAlertAction+Utility.h"
#import "objc/runtime.h"

static NSString* const kTitleTextColor = @"_titleTextColor";

@implementation UIAlertAction (Utility)

+ (BOOL)isSupportTitleTextColor{
    unsigned int count = 0;
    Ivar *ivarArray = class_copyIvarList([self class], &count);
    
    for(int i = 0; i < count; i++)
    {
        Ivar ivar = ivarArray[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([ivarName isEqualToString:kTitleTextColor]){
            return YES;
        }
    }
    return NO;
}

@end
