//
//  DKYSampleModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleModel.h"

@implementation DKYSampleModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.sampleId = [NSString stringWithFormat:@"%@",@(self.mProductId)];
    
    self.collected = ([self.iscollect integerValue] == 2) ? YES : NO;
}

@end
