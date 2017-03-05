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
    if(self.pzJsonstr.length > 0){
        NSDictionary *dict = [self.pzJsonstr jsonValueDecoded];
        NSArray *array = [dict objectForKey:@"value"];
        self.pzJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
        
        dict = [self.zzJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.zzJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
        
        dict = [self.zxJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.zxJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
        
        dict = [self.zbJsonstr jsonValueDecoded];
        array = [dict objectForKey:@"value"];
        self.zbJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:array];
    }
}

@end
