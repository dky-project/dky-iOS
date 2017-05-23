//
//  DKYHttpRequestParameter.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@implementation DKYHttpRequestParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.version = kAppVersion;
    }
    return self;
}

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"Id" : @"id"};
}

@end
