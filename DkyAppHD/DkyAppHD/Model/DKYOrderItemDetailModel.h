//
//  DKYOrderItemDetailModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYOrderItemDetailModel : NSObject

/**
 * 颜色
 */
@property (nonatomic, copy) NSString * colorArr;
/**
 * 客户
 */
@property (nonatomic, copy) NSString * customer;
/**
 * 交期
 */
@property (nonatomic, copy) NSString * fhDate;
/**
 * 后道
 */
@property (nonatomic, copy) NSString * hdTxt;
/**
 * 机构
 */
@property (nonatomic, copy) NSString * jgNo;
/**
 * 净胸围
 */
@property (nonatomic, copy) NSString * jxwValue;
/**
 * 领
 */
@property (nonatomic, copy) NSString * lingValue;
/**
 * 下边
 */
@property (nonatomic, copy) NSString * mDimNew10Text;
/**
 * 式样
 */
@property (nonatomic, copy) NSString * mDimNew12Text;
/**
 * 袖口
 */
@property (nonatomic, copy) NSString * mDimNew32Text;
/**
 * 编号
 */
@property (nonatomic, assign) NSInteger no1;
/**
 * 品名
 */
@property (nonatomic, copy) NSString * productValue;
/**
 * 实际袖长
 */
@property (nonatomic, copy) NSString * sjxcValue;
/**
 * 大
 */
@property (nonatomic, copy) NSString * xwValue;
/**
 * 袖型
 */
@property (nonatomic, copy) NSString * xxTxt;
/**
 * 长
 */
@property (nonatomic, copy) NSString * ycValue;

/**
 * 肩
 */
@property (nonatomic, copy) NSString *jkValue;

/**
 * 袖
 */
@property (nonatomic, copy) NSString *xcValue;

/**
 * 附件
 */
@property (nonatomic, copy) NSString *fuj;

/**
 * 袋
 */
@property (nonatomic, copy) NSString *dTxt;

/**
 * 备注
 */
@property (nonatomic, copy) NSString *remark;

/**
 * 款号
 */
@property (nonatomic, copy) NSString *pdt;

/**
 * 针型
 */
@property (nonatomic, copy) NSString *mDimNew16Text;

/**
 * 肩型
 */
@property (nonatomic, copy) NSString *mDimNew22Text;

/**
 * 花型
 */
@property (nonatomic, copy) NSString *huax;

/**
 * 版型
 */
@property (nonatomic, copy) NSString *bxText;

/**
 *  列表显示的样式
 */
@property (nonatomic, assign) NSInteger viewType;

/**
 * 工艺袖长
 */
@property (nonatomic, copy) NSString *hzxcValue;

/**
 * 性别
 */
@property (nonatomic, copy) NSString *mDimNew13Text;

/**
 * 袖边
 */
@property (nonatomic, copy) NSString *xTxt;

/**
 * 新袖口
 */
@property (nonatomic, copy) NSString *xkTxt;

/**
 * 新下边
 */
@property (nonatomic, copy) NSString *xbTxt;

/**
 * 领
 */
@property (nonatomic, copy) NSString *lTxt;


// bmpt

@property (nonatomic, assign) BOOL isBigOrder;

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
 * 数量
 */
@property (nonatomic, assign) NSInteger qty;
/**
 * 性质
 */
@property (nonatomic, copy) NSString *fair;
/**
 * 标准价
 */
@property (nonatomic, copy) NSString *pricelist;

// 客户端自己属性
@property (nonatomic, copy) NSString *displayNo1;

@property (nonatomic, copy) NSString *displayFhDate;

@property (nonatomic, copy) NSString *displayqty;

@end
