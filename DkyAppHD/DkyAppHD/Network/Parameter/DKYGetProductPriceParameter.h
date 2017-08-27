//
//  DKYGetProductPriceParameter.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/8/27.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYGetProductPriceParameter : DKYHttpRequestParameter

/**
 
 * 款号名称
 
 */

@property (nonatomic, copy) NSString *pdt;

/**
 
 * 款号ID
 
 */

@property (nonatomic, strong) NSNumber *pdtId;;

/**
 
 * 商品所属类别
 
 */

@property (nonatomic, copy) NSString *mptbelongtype;

/**
 
 * 品种默认值
 
 */

@property (nonatomic, strong) NSNumber *mDimNew14Id;;

/**
 
 * 针型默认值
 
 */

@property (nonatomic, strong) NSNumber *mDimNew16Id;

/**
 
 * 尺寸：大 默认值
 
 */

@property (nonatomic, copy) NSString *xwValue;

/**
 
 * 袖长
 
 */

@property (nonatomic, copy) NSString *xcValue;

/**
 
 * 尺寸：长
 
 */

@property (nonatomic, copy) NSString *ycValue;;

@end
