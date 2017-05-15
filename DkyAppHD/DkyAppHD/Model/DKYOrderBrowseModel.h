//
//  DKYOrderBrowseModel.h
//  DkyAppHD
//
//  Created by HaKim on 2017/5/15.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYOrderBrowseModel : NSObject
/**
 * 订单ID
 */
@property (nonatomic, strong) NSNumber *productApproveId;

/**
 * 机构
 */
@property (nonatomic, copy) NSString * jgNo;

/**
 * 交期
 */
@property (nonatomic, copy) NSString * jqDate;

/**
 * 名
 */
@property (nonatomic, copy) NSString * userName;

/**
 * 性别
 */
@property (nonatomic, copy) NSString *sexName;

/**
 * 颜色
 */
@property (nonatomic, copy) NSString *colorName;

/**
 * 大
 */
@property (nonatomic, copy) NSString * xwValue;

/**
 * 长
 */
@property (nonatomic, copy) NSString * ycValue;
/**
 * 肩
 */
@property (nonatomic, copy) NSString *jValue;

/**
 * 袖
 */
@property (nonatomic, copy) NSString *xValue;

/**
 * 下边
 */
@property (nonatomic, copy) NSString *xbValue;

/**
 * 袖口
 */
@property (nonatomic, copy) NSString *xkValue;

/**
 * 领
 */
@property (nonatomic, copy) NSString * lingValue;

/**
 * 式样
 */
@property (nonatomic, copy) NSString *syValue;

/**
 * 配套
 */
@property (nonatomic, copy) NSString *ptValue;
/**
 * 附件
 */
@property (nonatomic, copy) NSString *fjValue;

/**
 * 袖型
 */
@property (nonatomic, copy) NSString *xxValue;
/**
 * 袋
 */
@property (nonatomic, copy) NSString *dValue;

/**
 * 后道
 */
@property (nonatomic, copy) NSString *hdValue;
/**
 * 净胸围
 */
@property (nonatomic, copy) NSString *jxwValue;

/**
 * 实际袖长
 */
@property (nonatomic, copy) NSString *sjxcValue;
/**
 * 备注
 */
@property (nonatomic, copy) NSString *bzValue;

/**
 * 分隔行（单面，开衫，16S.....）
 */
@property (nonatomic, copy) NSString *content;

/**
 * 订单预览999
 */
@property (nonatomic, copy) NSString *no;
//如果ptValue不为空则显示配套文本框，否则隐藏。

@end
