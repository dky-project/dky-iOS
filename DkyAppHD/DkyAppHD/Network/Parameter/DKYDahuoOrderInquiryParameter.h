//
//  DKYDahuoOrderInquiryParameter.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYDahuoOrderInquiryParameter : DKYHttpRequestParameter

/**
 * 款号
 */
@property (nonatomic, copy) NSString *productName;

/**
 * 颜色
 */
@property (nonatomic, copy) NSString *colorName;

/**
 * 尺寸
 */
@property (nonatomic, copy) NSString *sizeName;

/**
 * 来源
 */
@property (nonatomic, strong) NSNumber *issource;

@end
