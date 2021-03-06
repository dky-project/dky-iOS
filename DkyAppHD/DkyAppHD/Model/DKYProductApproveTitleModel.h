//
//  DKYProductApproveTitleModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/21.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKYCustomOrderDimList.h"
#import "DKYDimlistItemModel.h"
#import "DKYStaticDimListModel.h"

@interface DKYProductApproveTitleModel : NSObject
/**
 * 机构号
 */
@property (nonatomic, copy) NSString * code;
/**
 * 传真日期
 */
@property (nonatomic, copy) NSString * czDate;
/**
 * 订单号
 */
@property (nonatomic, copy) NSString * orderNo;
/**
 * 发货日期
 */
@property (nonatomic, copy) NSString * sendDate;
/**
 * 操作者
 */
@property (nonatomic, copy) NSString * userName;

/**
 * 下拉框json字符串
 */
@property (nonatomic, copy) NSString * dimList;

/**
 * 下拉框
 */
@property (nonatomic, strong) DKYCustomOrderDimList *dimListModel;

/**
 * 原本写死在前端的下拉框的选项
 */
@property (nonatomic, copy) NSString *staticDimList;

@property (nonatomic, strong) DKYStaticDimListModel *staticDimListModel;

@property (nonatomic, copy) NSString *no;

@end
