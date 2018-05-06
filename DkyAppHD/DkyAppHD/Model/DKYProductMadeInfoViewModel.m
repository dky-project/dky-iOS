//
//  DKYProductMadeInfoViewModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYProductMadeInfoViewModel.h"
#import "DKYDimlistItemModel.h"

@implementation DKYProductMadeInfoViewModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    NSDictionary *dict = nil;
    NSArray *array = nil;
    
    if(self.pzJsonstr.length > 0){
        dict = [self.pzJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.pzJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
    }
    
    if(self.zzJsonstr.length > 0){
        dict = [self.zzJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.zzJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
    }
    
    if(self.zxJsonstr.length > 0){
        dict = [self.zxJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.zxJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
    }
    
    if(self.zbJsonstr.length > 0){
        dict = [self.zbJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.zbJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
    }
    
    if(self.clrRange.length > 0){
        self.clrRangeArray = [self.clrRange componentsSeparatedByString:@","];
    }
    
    NSRange range = [self.xcValue rangeOfString:@"+"];
    if(range.location == NSNotFound){
        self.xcHasAdd = NO;
        self.xcLeftValue = self.xcValue;
        self.xcRightValue = nil;
    }else{
        NSString *prefix = [self.xcValue substringToIndex:range.location];
        NSString *suffix = [self.xcValue substringFromIndex:range.location];
        
        self.xcHasAdd = YES;
        self.xcLeftValue = prefix;
        self.xcRightValue = suffix;
    }
}

@end
