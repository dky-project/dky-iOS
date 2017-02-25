//
//  NSObject+Utility.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/25.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "NSObject+Utility.h"
#import <objc/runtime.h>

@implementation NSObject (Utility)

- (NSArray*)ivars{
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList([self class], &numIvars);
    
    NSMutableArray *ivars = [NSMutableArray arrayWithCapacity:numIvars];
    
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
//        DLog(@"variable name :%@", key);
        [ivars addObject:key];
    }
    free(vars);
    
    return ivars.copy;
}

@end
