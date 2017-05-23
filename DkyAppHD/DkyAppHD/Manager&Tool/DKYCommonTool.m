//
//  DKYCommonTool.m
//  DkyAppHD
//
//  Created by HaKim on 2017/5/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCommonTool.h"

@implementation DKYCommonTool

+ (NSString *)getCurrentAppVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return version;
}

@end
