//
//  DKYOrderItemModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "id": 14485,
//    "pdt": "J86",
//    "customer": "刘传君",
//    "czDate": "2016-10-09",
//    "mDimNew12Text": "套衫",
//    "mDimNew15Text": "单面",
//    "mDimNew16Text": "12G",
//    "mDimNew17Text": "26S",
//    "xwValue": "85",
//    "ycValue": "62"
//}

@interface DKYOrderItemModel : NSObject

@property (nonatomic, copy) NSString * customer;
@property (nonatomic, copy) NSString * czDate;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString * mDimNew12Text;
@property (nonatomic, copy) NSString * mDimNew15Text;
@property (nonatomic, copy) NSString * mDimNew16Text;
@property (nonatomic, copy) NSString * mDimNew17Text;
@property (nonatomic, copy) NSString * pdt;
@property (nonatomic, copy) NSString * xwValue;
@property (nonatomic, copy) NSString * ycValue;
@property (nonatomic, assign) NSInteger no1;
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *sum;

@property (nonatomic, copy) NSString *totalAmount;

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
 * 金额
 */
@property (nonatomic, copy) NSString *amount;
/**
 * 数量
 */
@property (nonatomic, copy) NSString *qty;

/**
 * 大图
 */
@property (nonatomic, copy) NSString *bigImgUrl;

/**
 * 样衣来源
 */
@property (nonatomic, copy) NSString *issourceText;


// 客户端自己属性
@property (nonatomic, copy) NSString *displayID;
@property (nonatomic, copy) NSString *displayNo1;
@property (nonatomic, copy) NSString *displayFaxDate;
@property (nonatomic, assign) BOOL selected;

// 序号
@property (nonatomic, copy) NSString *order;

@end
