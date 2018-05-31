//
//  DKYGetProductListByGroupNoModel.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYGetProductListByGroupNoModel.h"

@implementation  DKYGetProductListByGroupNoModel

+ (NSDictionary*)mj_objectClassInArray{
    return @{@"colorViewList" : @"DKYDahuoOrderColorModel",
             @"sizeViewList":@"DKYSizeViewListItemModel",
             @"pzJsonstr":@"DKYDimlistItemModel",
             @"zxJsonstr":@"DKYDimlistItemModel",
             @"pinList":@"DKYDimlistItemModel"
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.isCollected = (!([self.iscollect integerValue] == 1));
    self.isBigOrder = ([self.mptbelongtype caseInsensitiveCompare:@"C"] == NSOrderedSame);
    
    NSRange range = [self.xcValue rangeOfString:@"+"];
    
    if(self.xcValue == nil || range.location == NSNotFound){
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
    
    if(self.isBigOrder){
        self.addDpGroupBmptParam = [[DKYAddDpGroupBmptParamModel alloc] init];
        self.addDpGroupBmptParam.mProductId = self.mProductId;
        self.addDpGroupBmptParam.pdt = self.productName;
        self.addDpGroupBmptParam.issource = @3;
    }else{
        self.addDpGroupApproveParam = [[DKYAddDpGroupApproveParamModel alloc] init];
        self.addDpGroupApproveParam.mProductId = self.mProductId;
        self.addDpGroupApproveParam.pdt = self.productName;
        self.addDpGroupApproveParam.mDimNew14Id = self.mDimNew14Id;
        self.addDpGroupApproveParam.xwValue = self.xwValue;
        self.addDpGroupApproveParam.ycValue = self.ycValue;
        self.addDpGroupApproveParam.mDimNew16Id = self.mDimNew16Id;
        self.addDpGroupApproveParam.xcValue = self.xcValue;
        self.addDpGroupApproveParam.xcLeftValue = self.xcLeftValue;
        self.defaultXcValue = self.xcLeftValue;
        self.addDpGroupApproveParam.issource = @3;
    }
    self.sum = 1;
}

- (void)setSum:(NSInteger)sum{
    _sum = sum;
    
    if(sum > 0){
        self.sumText = [NSString stringWithFormat:@"%@",@(sum)];
        
        if(self.isBigOrder){
            self.addDpGroupBmptParam.sum = @(sum);
        }else{
            self.addDpGroupApproveParam.sum = @(sum);
        }
    }
}

@end
