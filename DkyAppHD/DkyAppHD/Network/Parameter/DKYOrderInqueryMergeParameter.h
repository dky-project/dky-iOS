//
//  DKYOrderInqueryMergeParameter.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/8.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYOrderInqueryMergeParameter : DKYHttpRequestParameter
// 订货会版本

/**
 * 款号
 */
@property (nonatomic, copy) NSString *pdt;

/**
 * 样衣来源
 */
@property (nonatomic, copy) NSNumber *issource;

// 加盟店版本

/**
 * 机构
 */
@property (nonatomic, copy) NSString *jgno;

/**
 * 传真日期
 */
@property (nonatomic, copy) NSString *czDate;

/**
 * 客户
 */
@property (nonatomic, copy) NSString *customer;

/**
 * 审核状态
 */
@property (nonatomic, copy) NSNumber *isapprove;

/**
 * 颜色
 */
@property (nonatomic, copy) NSString *colorName;

@property (nonatomic, copy) NSString *size;

@end
