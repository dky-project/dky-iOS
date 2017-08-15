//
//  DKYGetProductListByGroupNoModel.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYGetProductListByGroupNoModel.h"

@implementation DKYGetProductListByGroupNoModel

+ (NSDictionary*)mj_objectClassInArray{
    return @{@"colorViewList" : @"DKYDahuoOrderColorModel",
             @"sizeViewList":@"DKYSizeViewListItemModel",
             @"pzJsonstr":@"DKYDimlistItemModel"};
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.isCollected = (!([self.iscollect integerValue] == 1));
    self.isBigOrder = ([self.mptbelongtype caseInsensitiveCompare:@"C"] == NSOrderedSame);
    
    if(self.isBigOrder){
        self.addDpGroupBmptParam = [[DKYAddDpGroupBmptParamModel alloc] init];
        self.addDpGroupBmptParam.mProductId = self.mProductId;
        self.addDpGroupBmptParam.pdt = self.productName;
    }else{
        self.addDpGroupApproveParam = [[DKYAddDpGroupApproveParamModel alloc] init];
        self.addDpGroupApproveParam.mProductId = self.mProductId;
        self.addDpGroupApproveParam.pdt = self.productName;
        self.addDpGroupApproveParam.mDimNew14Id = self.mDimNew14Id;
        self.addDpGroupApproveParam.xwValue = self.xwValue;
        self.addDpGroupApproveParam.ycValue = self.ycValue;
    }
}

- (void)setSum:(NSInteger)sum{
    _sum = sum;
    
    self.sumText = [NSString stringWithFormat:@"%@",@(sum)];
}

@end
