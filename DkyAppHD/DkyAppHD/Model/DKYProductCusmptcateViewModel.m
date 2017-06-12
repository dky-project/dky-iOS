//
//  DKYProductCusmptcateViewModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYProductCusmptcateViewModel.h"

@implementation DKYProductCusmptcateViewModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    NSArray *temp = [self.xwArray jsonValueDecoded];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:temp.count];
    for (NSDictionary *dict in temp) {
        [array addObject:[dict objectForKey:@"value"]];
    }
    
    self.xwArrayList = [array copy];
}

+ (NSDictionary*)mj_objectClassInArray{
    return @{@"syShow" : @"DKYDimlistItemModel",
             @"lbShow" : @"DKYDimlistItemModel",
             @"lxShow" : @"DKYDimlistItemModel",
             @"gjxfShow" : @"DKYDimlistItemModel",
             @"xbShow" : @"DKYDimlistItemModel",
             @"xkShow" : @"DKYDimlistItemModel",
             @"xxShow" : @"DKYDimlistItemModel",
             @"mjzzShow" : @"DKYDimlistItemModel",
             @"jxShow" : @"DKYDimlistItemModel"
             };
}

@end
