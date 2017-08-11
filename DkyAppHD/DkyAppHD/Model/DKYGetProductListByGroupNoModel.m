//
//  DKYGetProductListByGroupNoModel.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYGetProductListByGroupNoModel.h"

@implementation DKYGetProductListByGroupNoModel

+ (NSDictionary*)mj_objectClassInArray{
    return @{@"colorViewList" : @"DKYDahuoOrderColorModel",
             @"sizeViewList":@"DKYSizeViewListItemModel",
             @"pzJsonstr":@"DKYDimlistItemModel"};
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.isCollected = (!([self.iscollect integerValue] == 1));
}

@end
