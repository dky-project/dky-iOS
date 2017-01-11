//
//  DKYOrderItemModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderItemModel.h"

@implementation DKYOrderItemModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"Id" : @"id"};
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.displayID = [NSString stringWithFormat:@"%@",@(self.Id)];
    self.displayNo1 = [NSString stringWithFormat:@"%@",@(self.no1)];
    
    
    NSString *faxDate = [self.czDate stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    NSArray *comp = [faxDate componentsSeparatedByString:@"/"];
    if(comp.count == 3){
        faxDate = [faxDate substringFromIndex:2];
    }
    
    self.displayFaxDate = faxDate;
}

@end
