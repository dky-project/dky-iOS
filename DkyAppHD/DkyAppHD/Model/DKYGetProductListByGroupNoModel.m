//
//  DKYGetProductListByGroupNoModel.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYGetProductListByGroupNoModel.h"
#import "DKYSizeViewListItemModel.h"

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
    
    if([self.mDimNew22Id integerValue] == 131){
        self.xcHasAdd = NO;
        self.xcRightValue = nil;
        self.xcLeftValue = self.hzxcValue;
    }else{
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
    }
    
    if(self.isBigOrder){
        self.addDpGroupBmptParam = [[DKYAddDpGroupBmptParamModel alloc] init];
        self.addDpGroupBmptParam.mProductId = self.mProductId;
        self.addDpGroupBmptParam.pdt = self.productName;
        self.addDpGroupBmptParam.issource = @3;
        
        for(DKYSizeViewListItemModel *model in self.sizeViewList){
            if(model.isDefault != nil && [model.isDefault caseInsensitiveCompare:@"Y"] == NSOrderedSame){
                self.addDpGroupBmptParam.sizeId = model.sizeId;
                break;
            }
        }
    }else{
        self.addDpGroupApproveParam = [[DKYAddDpGroupApproveParamModel alloc] init];
        self.addDpGroupApproveParam.mProductId = self.mProductId;
        self.addDpGroupApproveParam.pdt = self.productName;
        self.addDpGroupApproveParam.mDimNew14Id = self.mDimNew14Id;
        self.addDpGroupApproveParam.xwValue = self.xwValue;
        self.addDpGroupApproveParam.ycValue = self.ycValue;
        self.addDpGroupApproveParam.mDimNew16Id = self.mDimNew16Id;
        if([self.mDimNew22Id integerValue] == 131){
            self.addDpGroupApproveParam.xcValue = self.hzxcValue;
        }else{
            self.addDpGroupApproveParam.xcValue = self.xcValue;
        }
        
        self.addDpGroupApproveParam.xcLeftValue = self.xcLeftValue;
        self.defaultXcValue = self.xcLeftValue;
        self.addDpGroupApproveParam.issource = @3;
        self.defaultYcValue = self.ycValue;
    }
    self.sum = 1;
    
    self.choosed = YES;
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
