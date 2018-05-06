//
//  DKYGetProductListByGroupNoModel.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKYAddDpGroupApproveParamModel.h"
#import "DKYAddDpGroupBmptParamModel.h"

@interface DKYGetProductListByGroupNoModel : NSObject

@property (nonatomic, strong) NSArray * colorViewList;
@property (nonatomic, copy) NSString * imgUrl;
@property (nonatomic, copy) NSString *mDimNew14Id;
@property (nonatomic, strong) NSNumber *mDimNew16Id;
@property (nonatomic, strong) NSNumber *mProductId;
@property (nonatomic, copy) NSString * mptbelongtype;
@property (nonatomic, copy) NSString * xwValue;
@property (nonatomic, copy) NSString * ycValue;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *isYcAffix;

@property (nonatomic, strong) NSArray *xwArrayJson;

@property (nonatomic, strong) NSArray *sizeViewList;

@property (nonatomic, copy) NSArray *pzJsonstr;

@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSNumber *iscollect;

@property (nonatomic, copy) NSString *xcValue;

// 是否是 这种形式的数据 88+6
@property (nonatomic, assign) BOOL xcHasAdd;

// 88
@property (nonatomic, copy) NSString *xcLeftValue;

// 6
@property (nonatomic, copy) NSString *xcRightValue;


@property (nonatomic, strong) NSArray *zxJsonstr;

@property (nonatomic, copy) NSArray *pinList;

/**
 * 颜色组
 */
@property (nonatomic, strong) NSArray *colorRangeViewList;

// 客户端自己的属性
@property (nonatomic, assign) BOOL isCollected;

@property (nonatomic, assign) BOOL isBigOrder;

@property (nonatomic, strong) DKYAddDpGroupApproveParamModel *addDpGroupApproveParam;
@property (nonatomic, strong) DKYAddDpGroupBmptParamModel *addDpGroupBmptParam;

@property (nonatomic, assign) NSInteger sum;
@property (nonatomic, copy) NSString *sumText;

@property (nonatomic, strong) NSString *defaultXcValue;

@end
