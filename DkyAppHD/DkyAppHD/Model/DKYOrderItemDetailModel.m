//
//  DKYOrderItemDetailModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderItemDetailModel.h"

@implementation DKYOrderItemDetailModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.displayNo1 = [NSString stringWithFormat:@"%@",@(self.no1)];
    
    self.displayFhDate = [self.fhDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
}


@end
