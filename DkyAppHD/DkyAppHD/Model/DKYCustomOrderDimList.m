//
//  DKYCustomOrderDimList.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/21.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderDimList.h"
#import "DKYDimlistItemModel.h"

@implementation DKYCustomOrderDimList

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"DIMFLAG_NEW24" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW25" : @"DKYDimlistItemModel"
             };
}

@end
