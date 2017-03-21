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

@end
