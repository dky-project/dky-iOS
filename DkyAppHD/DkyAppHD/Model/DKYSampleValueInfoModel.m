//
//  DKYSampleValueInfoModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleValueInfoModel.h"

@implementation DKYSampleValueInfoModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    if(!self.jkValue){
        self.jkValue = @"";
    }
    if(!self.xcValue){
        self.xcValue = @"";
    }
    
    if(!self.xwValue){
        self.xwValue = @"";
    }
    
    if(!self.ycValue){
        self.ycValue = @"";
    }
}

@end
