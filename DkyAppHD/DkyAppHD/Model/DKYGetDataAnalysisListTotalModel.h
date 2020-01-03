//
//  DKYGetDataAnalysisListTotalModel.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/17.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYGetDataAnalysisListTotalModel : NSObject

/*
 *  下单总数
 */
@property (nonatomic, strong) NSNumber *QTY;

/*
 *  零售总金额
 */
@property (nonatomic, strong) NSNumber *TOTALAMOUNT;

/*
 *  折扣
 */
@property (nonatomic, strong) NSNumber *GHPRICE;

/*
 *  返利金额
 */
@property (nonatomic, strong) NSNumber *FLPRICE;

/*
 *  进货价总金额
 */
@property (nonatomic, strong) NSNumber *AFTERAMOUNT;

/*
 *  类型
 */
@property (nonatomic, assign) NSInteger STORETYPE;

@property (nonatomic, copy) NSString *FLPRICE1;

@property (nonatomic, copy) NSString *FLPRICE2;

// 客户端自己属性
@property (nonatomic, assign, getter=isZmd) BOOL zmd;

@end
