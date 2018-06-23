//
//  DKYAllCollectParameter.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/23.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYAllCollectParameter : DKYHttpRequestParameter

@property (nonatomic, copy) NSArray *productIds;

@property (nonatomic, copy) NSString *cancel;

@end
