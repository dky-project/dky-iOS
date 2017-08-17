//
//  DKYAddDpGroupBmptParamModel.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/14.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYAddDpGroupBmptParamModel : NSObject

/**
 * 款号ID
 */
@property (nonatomic, strong) NSNumber *mProductId;

/**
 * 款号名称
 */
@property (nonatomic, copy) NSString *pdt;

/**
 * 尺寸
 */
@property (nonatomic, strong) NSNumber *sizeId;

/**
 * 颜色
 */
@property (nonatomic, strong) NSNumber *colorId;

/**
 * 数量
 */
@property (nonatomic, strong) NSNumber *sum;


@end
