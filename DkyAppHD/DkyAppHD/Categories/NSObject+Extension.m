//
//  NSObject+Extension.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (BOOL)isLandscape:(CGSize)size{
    return size.width > size.height;
}

@end
