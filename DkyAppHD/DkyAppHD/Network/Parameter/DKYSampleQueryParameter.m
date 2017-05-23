//
//  DKYSampleQueryParameter.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleQueryParameter.h"

@implementation DKYSampleQueryParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isRecommend = @"N";
        self.isRank = @"N";
    }
    return self;
}

@end
