//
//  DKYGetProductListByGroupNoModel.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYGetProductListByGroupNoModel.h"
#import "DKYSizeViewListItemModel.h"
#import "DKYDahuoOrderColorModel.h"

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
        //[self updateColorBigOrder];
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
        
        //[self updateColor];
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

- (void)updateColorBigOrder{
    DKYDahuoOrderColorModel *defaultColor;
    for(DKYDahuoOrderColorModel *color in self.colorViewList){
        if(color.isDefault != nil && [color.isDefault caseInsensitiveCompare:@"Y"] == NSOrderedSame){
            defaultColor = color;
            break;
        }
    }
    
    self.addDpGroupBmptParam.colorId = @(defaultColor.colorId);
}

- (void)updateColor{
    if(self.colorRangeViewList.count > 0){
        NSString *defaulColor = nil;
        for(NSDictionary *obj in self.colorRangeViewList){
            NSString *isDefault = [obj objectForKey:@"isDefault"];
            if(isDefault != nil && [isDefault caseInsensitiveCompare:@"Y"] == NSOrderedSame){
                defaulColor = [obj objectForKey:@"colorName"];
                break;
            }
        }
        
        // 解析选中颜色，取出()前面
        NSArray *temp = [defaulColor componentsSeparatedByString:@";"];
        
        NSMutableArray *colors = [NSMutableArray arrayWithCapacity:temp.count];
        
        for (NSString *item in temp) {
            NSRange range = [item rangeOfString:@"("];
            NSString *colorName = nil;
            if(range.location != NSNotFound){
                colorName = [item substringToIndex:range.location];
            }else{
                colorName = item;
            }
            
            [colors addObject:colorName];
        }
        
        [self colorGroupSelected:colors.copy];
    }else{
        self.addDpGroupApproveParam.colorArr = nil;
    }
}

- (void)colorGroupSelected:(NSArray*)selectedColors{
    NSMutableArray *selectedColor = [NSMutableArray array];
    
    for (NSString *colorName in selectedColors) {
        BOOL match = NO;
        DKYDahuoOrderColorModel *color  = nil;
        for (color in self.colorViewList) {
            if([color.colorName isEqualToString:colorName]){
                match = YES;
                break;
            }
        }
        if(match){
            NSString *oneColor = [NSString stringWithFormat:@"%@(%@)",color.colorName,color.colorDesc];
            [selectedColor addObject:oneColor];
        }
    }
    
    NSString *color = [selectedColor componentsJoinedByString:@";"];
    
    if(selectedColor.count == 0){
        self.addDpGroupApproveParam.colorArr = nil;
    }else{
        self.addDpGroupApproveParam.colorArr = color;
    }
}

@end
