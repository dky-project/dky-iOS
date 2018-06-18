//
//  DKYGetDataAnalysisListTotalModel.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/17.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYGetDataAnalysisListTotalModel.h"

@implementation DKYGetDataAnalysisListTotalModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.zmd = (self.STORETYPE == 7);
}

@end
