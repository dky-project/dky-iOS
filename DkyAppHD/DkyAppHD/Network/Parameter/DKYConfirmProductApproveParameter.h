//
//  DKYConfirmProductApproveParameter.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/15.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYConfirmProductApproveParameter : DKYHttpRequestParameter

/**
 * 大货订单ID
 */
@property (nonatomic, strong) NSArray *bmptIds;

/**
 * 定制订单ID
 */
@property (nonatomic, strong) NSArray *approveIds;

@end
