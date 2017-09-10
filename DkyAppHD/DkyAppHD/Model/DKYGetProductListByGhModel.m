//
//  DKYGetProductListByGhModel.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYGetProductListByGhModel.h"

@implementation DKYGetProductListByGhModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.isCollected = ([self.iscollect integerValue] == 2);
}

@end
