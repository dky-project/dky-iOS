//
//  DKYAddProductApproveParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/3/22.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYAddProductApproveParameter : DKYHttpRequestParameter

/**
 * 款号名称
 */
@property (nonatomic, copy) NSString *pdt;

/**
 * 机构号
 */
@property (nonatomic, copy) NSString *jgno;

/**
 * 客户
 */
@property (nonatomic, copy) NSString *customer;

/**
 * 编号
 */
@property (nonatomic, copy) NSString *no;

/**
 * 传真日期
 */
@property (nonatomic, copy) NSString *czDate;

/**
 * 要求发货日期
 */
@property (nonatomic, copy) NSString *fhDate;
/**
 * 手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 * 主颜色ID（第一个勾选的颜色）
 */
@property (nonatomic, strong) NSNumber *colorValue;
/**
 * 颜色群（多个颜色用英文分号拼接的字符串）
 */
@property (nonatomic, copy) NSString *colorArr;
/**
 * 花型（多个花型英文分号拼接）
 * 如果花型后面带有文本框，需要单独做拼接
 * 为挑花时单独拼接：挑花（文本框-文本框），例如：挑花(1-2)
 * 为绞花时单独拼接：绞花（文本框-文本框），例如：绞花(1-2)
 * 为抽条时单独拼接：抽条（文本框抽文本框）,例如：抽条(1-2)
 */
@property (nonatomic, copy) NSString *huax;
/**
 * 口袋（多个口袋英文分号拼接）
 * 选中其他时获取其他后面的文本框拼接
 */
@property (nonatomic, copy) NSString *koud;
/**
 * 附件（多个附件英文分号拼接）
 * 选中其他时获取其他后面的文本框拼接
 */
@property (nonatomic, copy) NSString *fuj;
/**
 * 特殊工艺（多个特殊工艺英文分号拼接）
 * 选中其他时获取其他后面的文本框拼接
 */
@property (nonatomic, copy) NSString *tesgy;
/**
 * 烫珠（多个烫珠英文分号拼接）
 * 选中烫珠、绣花、串珠需要单独进行一次拼接：例如：烫珠(1-2#)
 * 为空时：(-#)
 */
@property (nonatomic, copy) NSString *tangz;
/**
 * 式样
 */
@property (nonatomic, strong) NSNumber *mDimNew12Id;
/**
 * 性别
 */
@property (nonatomic, strong) NSNumber *mDimNew13Id;
/**
 * 品种
 */
@property (nonatomic, strong) NSNumber *mDimNew14Id;
/**
 *  组织
 */
@property (nonatomic, strong) NSNumber *mDimNew15Id;
/**
 *   针型
 */
@property (nonatomic, strong) NSNumber *mDimNew16Id;
/**
 *   支别
 */
@property (nonatomic, strong) NSNumber *mDimNew17Id;
/**
 *   挂肩袖肥
 */
@property (nonatomic, strong) NSNumber *mDimNew18Id;
/**
 *   收腰
 */
@property (nonatomic, strong) NSNumber *mDimNew19Id;
/**
 *   肩型
 */
@property (nonatomic, strong) NSNumber *mDimNew22Id;
/**
 *   领型
 */
@property (nonatomic, strong) NSNumber *mDimNew25Id;
/**
 *   领边
 */
@property (nonatomic, strong) NSNumber *mDimNew26Id;
/**
 *   领边层
 */
@property (nonatomic, strong) NSNumber *mDimNew28Id;
/**
 *   下边
 */
@property (nonatomic, strong) NSNumber *mDimNew10Id;
/**
 *   袖口
 */
@property (nonatomic, strong) NSNumber *mDimNew32Id;
/**
 *   加穗
 */
@property (nonatomic, strong) NSNumber *mDimNew37Id;
/**
 *   裤类别
 */
@property (nonatomic, strong) NSNumber *mDimNew38Id;
/**
 *   开口
 */
@property (nonatomic, strong) NSNumber *mDimNew39Id;
/**
 *   加裆
 */
@property (nonatomic, strong) NSNumber *mDimNew1Id;
/**
 *   裙类别
 */
@property (nonatomic, strong) NSNumber *mDimNew3Id;
/**
 *   钉扣拉链
 */
@property (nonatomic, strong) NSNumber *mDimNew4Id;
/**
 *   门襟
 */
@property (nonatomic, strong) NSNumber *mDimNew6Id;
/**
 *   第二袖型
 */
@property (nonatomic, strong) NSNumber *mDimNew9Id1;
/**
 *   门襟组织
 */
@property (nonatomic, strong) NSNumber *mDimNew7Id;
/**
 *   配套
 */
@property (nonatomic, strong) NSNumber *mDimNew41Id;
/**
 *   第一袖型
 */
@property (nonatomic, strong) NSNumber *mDimNew9Id;
/**
 *   第三袖型
 */
@property (nonatomic, strong) NSNumber *mDimNew9Id2;
/**
 *  大（尺寸）
 */
@property (nonatomic, copy) NSString *xwValue;
/**
 *  长（尺寸）
 */
@property (nonatomic, copy) NSString *ycValue;
/**
 *  肩宽
 */
@property (nonatomic, copy) NSString *qtjxValue;
/**
 *  其他肩型
 */
@property (nonatomic, strong) NSNumber *jkValue;
/**
 *  袖长
 */
@property (nonatomic, strong) NSNumber *xcValue;
/**
 * 备忘录
 */
@property (nonatomic, copy) NSString *shRemark;

/**
 * 袖边组织
 */
@property (nonatomic, strong) NSNumber *xbzzValue;

/**
 * 领：尺寸
 */
@property (nonatomic, strong) NSNumber *lingCcValue;
/**
 *  袖边
 */
@property (nonatomic, strong) NSNumber *xbValue;
/**
 *  袖边：袖边长
 */
@property (nonatomic, strong) NSNumber *xbcValue;
/**
 *  袖边：其他袖边组织
 */
@property (nonatomic, copy) NSString *qtxbzzValue;
/**
 *  领
 */
@property (nonatomic, copy) NSString *lingValue;
/**
 *  领：样衣编码1(文本框)
 */
@property (nonatomic, copy) NSString *lingNumber1Value;
/**
 *  领：样衣编码2(文本框)
 */
@property (nonatomic, copy) NSString *lingNumber2Value;
/**
 *  领：其他备注
 */
@property (nonatomic, strong) NSNumber *qtLingOther;
/**
 *  领：其他领边
 */
@property (nonatomic, copy) NSString *qtlbValue;
/**
 * 领：领型属性1
 */
@property (nonatomic, copy) NSString *lxsx1Value;
/**
 * 领：领型属性2
 */
@property (nonatomic, copy) NSString *lxsx2Value;
/**
 * 领：领型属性3
 */
@property (nonatomic, copy) NSString *lxsx3Value;
/**
 * 领：粒扣
 */
@property (nonatomic, copy) NSString *lxsx4Value;
/**
 *  领：备注
 */
@property (nonatomic, copy) NSString *lxsx5Value;
/**
 *     下边：其他下边
 */
@property (nonatomic, copy) NSString *qtxbValue;
/**
 *     下边：下边尺寸cm
 */
@property (nonatomic, strong) NSNumber *xbccValue;
/**
 *     加注
 */
@property (nonatomic, copy) NSString *jzValue;
/**
 *     袖口：袖口尺寸
 */
@property (nonatomic, strong) NSNumber *xkccValue;
/**
 *     袖口：其他袖口
 */
@property (nonatomic, copy) NSString *qtxkValue;
/**
 *     式样：工艺袖长
 */
@property (nonatomic, strong) NSNumber *hzxcValue;
/**
 *     肩型：工艺袖长
 */
@property (nonatomic, strong) NSNumber *hzxc1Value;
/**
 *     式样：带长
 */
@property (nonatomic, strong) NSNumber *dc1Value;
/**
 *     式样：档长
 */
@property (nonatomic, strong) NSNumber *dcValue;
/**
 *     式样：门襟宽
 */
@property (nonatomic, strong) NSNumber *mjkValue;
/**
 *     式样：门襟长
 */
@property (nonatomic, strong) NSNumber *mjcValue;
/**
 *     式样：其他门禁1（带长前面的文本框1）
 */
@property (nonatomic, copy) NSString *amjValue;
/**
 *     式样：其他门禁2（带长前面的文本框2）
 */
@property (nonatomic, copy) NSString *qtmjValue;
/**
 * 式样：钉【】扣#
 */
@property (nonatomic, copy) NSString *dkNumber;
/**
 * 袖型：其他袖型1
 */
@property (nonatomic, copy) NSString *qtxxValue;
/**
 * 袖型：其他袖型2
 */
@property (nonatomic, copy) NSString *qtxxValue1;
/**
 * 袖型：其他袖型3
 */
@property (nonatomic, copy) NSString *qtxxValue2;
/**
 * 净尺寸：净胸围
 */
@property (nonatomic, copy) NSString *jxwValue;
/**
 * 净尺寸：实际袖长
 */
@property (nonatomic, copy) NSString *sjxcValue;

@end
