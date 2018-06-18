//
//  DKYGetDataAnalysisFormItemModel.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/18.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYGetDataAnalysisFormItemModel.h"

@implementation DKYGetDataAnalysisFormItemModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"Id" : @"id"};
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    if(self.proportion == nil){
        self.proportion = @"";
    }
}

@end
