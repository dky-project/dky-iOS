//
//  DKYAddDpGroupApproveParamModel.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/14.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYAddDpGroupApproveParamModel : NSObject

/**
 * 款号ID
 */
@property (nonatomic, strong) NSNumber *mProductId;
/**
 * 款号名称
 */
@property (nonatomic, copy) NSString *pdt;
/**
 * 品种
 */
@property (nonatomic, strong) NSNumber *mDimNew14Id;
/**
 *  大（尺寸）
 */
@property (nonatomic, copy) NSString *xwValue;
/**
 *  长（尺寸）
 */
@property (nonatomic, copy) NSString *ycValue;
/**
 *  袖长
 */
@property (nonatomic, copy) NSString *xcValue;
/**
 * 颜色名称
 */
@property (nonatomic, copy) NSString *colorArr;

@end
