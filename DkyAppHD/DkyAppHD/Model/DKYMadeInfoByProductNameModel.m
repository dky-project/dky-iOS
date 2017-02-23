//
//  DKYMadeInfoByProductName.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYMadeInfoByProductNameModel.h"

@implementation DKYMadeInfoByProductNameModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"colorViewList" : @"DKYDahuoOrderColorModel",
             @"sizeViewList" : @"DKYDahuoOrderSizeModel",
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    if(self.colorViewList.count > 0 && self.sizeViewList.count > 0){
        self.bigOrder = YES;
    }
}

@end
