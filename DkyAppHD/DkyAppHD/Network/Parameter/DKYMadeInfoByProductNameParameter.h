//
//  DKYMadeInfoByProductNameParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYMadeInfoByProductNameParameter : DKYHttpRequestParameter

/**
 * 款号名称
 */
@property (nonatomic, copy) NSString *productName;

@end
