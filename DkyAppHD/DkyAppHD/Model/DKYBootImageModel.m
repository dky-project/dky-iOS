//
//  DKYBootImageModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYBootImageModel.h"

@implementation DKYBootImageModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"Id" : @"id"};
}

// NSCoding Implementation
MJExtensionCodingImplementation

@end
