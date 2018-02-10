//
//  DKYSampleQueryParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYSampleQueryParameter : DKYHttpRequestParameter

/**
 * 大类
 */
@property (nonatomic, strong) NSNumber *mDimNew11Id;

/**
 * 性别
 */
@property (nonatomic, strong) NSNumber *mDimNew13Id;

/**
 * 品种
 */
@property (nonatomic, strong) NSNumber *mDimNew14Id;

/**
 * 组织
 */
@property (nonatomic, strong) NSNumber *mDimNew15Id;

/**
 * 针型
 */
@property (nonatomic, strong) NSNumber *mDimNew16Id;

/**
 * 式样
 */
@property (nonatomic, strong) NSNumber *mDimNew12Id;
/**
 * 领型
 */
@property (nonatomic, strong) NSNumber *mDimNew25Id;
/**
 * 袖型
 */
@property (nonatomic, strong) NSNumber *mDimNew9Id;

/**
 * 年份
 */
@property (nonatomic, strong) NSNumber *mDim13Id;


/**
 * ID
 */
@property (nonatomic, strong) NSNumber *mProductId;

/**
 * 品类
 */
@property (nonatomic, strong) NSNumber *mDim16Id;

/**
 * 款号
 */
@property (nonatomic, copy) NSString *name;

// 推荐
@property (nonatomic, copy) NSString *isRecommend;

// 销量排行
@property (nonatomic, copy) NSString *isRank;

// 买家秀
@property (nonatomic, copy) NSString *isBuy;

@end
