//
//  DKYMptApproveSaveParameter.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/3/18.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYMptApproveSaveParameter : DKYHttpRequestParameter
/**
 * 机构号
 */
@property (nonatomic, strong) NSNumber *jgNo;
/**
 * 款号名称
 */
@property (nonatomic, copy) NSString *productName;
/**
 * 尺寸
 */
@property (nonatomic, strong) NSNumber *sizeId;
/**
 * 颜色
 */
@property (nonatomic, strong) NSNumber *colorId;
@end
