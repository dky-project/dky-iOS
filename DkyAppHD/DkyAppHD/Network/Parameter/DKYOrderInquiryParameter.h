//
//  DKYOrderInquiryParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYOrderInquiryParameter : DKYHttpRequestParameter

/**
 * 传真日期
 */
@property (nonatomic, copy) NSString *czDate;

/**
 * 来源样衣
 */
@property (nonatomic, copy) NSString *pdt;

/**
 * 客户
 */
@property (nonatomic, copy) NSString *customer;

/**
 * 审核状态
 */
@property (nonatomic, copy) NSNumber *isapprove;

/**
 * 样衣来源
 */
@property (nonatomic, copy) NSNumber *issource;

@end
