//
//  DKYProductMadeInfoViewModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYProductMadeInfoViewModel : NSObject

/**
 * 款号ID
 */
@property (nonatomic, strong) NSNumber *productId;

/**
 * 商品所属类别
 */
@property (nonatomic, copy) NSString * mptbelongtype;

/**
 * 性别
 */
@property (nonatomic, assign) NSInteger mDimNew13Id;

/**
 * 品种
 */
@property (nonatomic, assign) NSInteger mDimNew14Id;

/**
 * 组织
 */
@property (nonatomic, assign) NSInteger mDimNew15Id;

/**
 * 针型
 */
@property (nonatomic, assign) NSInteger mDimNew16Id;

/**
 * 支别
 */
@property (nonatomic, assign) NSInteger mDimNew17Id;

/**
 * 颜色
 */
@property (nonatomic, copy) NSString * clrRange;

@property (nonatomic, copy) NSArray *clrRangeArray;

/**
 * 式样
 */
@property (nonatomic, assign) NSInteger mDimNew12Id;

/**
 * 钉[文本框]#扣
 */
@property (nonatomic, copy) NSString *dkValue;

/**
 * 钉扣
 */
@property (nonatomic, assign) NSInteger mDimNew4Id;

/**
 * 门襟宽
 */
@property (nonatomic, copy) NSString *mjkValue;


/**
 * 门禁1
 */

@property (nonatomic, assign) NSInteger mDimNew6Id;

/**
 * 门禁2
 */
@property (nonatomic, assign) NSInteger mDimNew7Id;

// #连接的两个输入框，后面的那个
@property (nonatomic, copy) NSString *mjzzRemark;

/**
 * 加穗
 */
@property (nonatomic, assign) NSInteger mDimNew37Id;

/**
 * 裤类别
 */
@property (nonatomic, assign) NSInteger mDimNew38Id;
/**
 * 开口
 */
@property (nonatomic, assign) NSInteger mDimNew39Id;
/**
 * 加档
 */
@property (nonatomic, assign) NSInteger mDimNew1Id;
/**
 * 裙类别
 */
@property (nonatomic, assign) NSInteger mDimNew3Id;
/**
 * 挂件袖肥
 */
@property (nonatomic, assign) NSInteger mDimNew18Id;

/**
 * 收腰
 */
@property (nonatomic, assign) NSInteger mDimNew19Id;



/**
 * 尺寸：大
 * 请选择胸围
 */
@property (nonatomic, copy) NSString * xwValue;

/**
 * 实际袖长上面：长[文本框]，尺寸 长
 */
@property (nonatomic, copy) NSString * ycValue;


/**
 * 肩型
 */
@property (nonatomic, assign) NSInteger mDimNew22Id;

@property (nonatomic, strong) NSNumber *hzxcValue;

/**
 * 肩宽cm
 */
@property (nonatomic, copy) NSString * jkValue;



/**
 * 袖型
 */
@property (nonatomic, assign) NSInteger mDimNew9Id;

/**
 * 袖型2
 */
@property (nonatomic, assign) NSInteger mDimNew9Id2;

/**
 * 袖型3
 */
@property (nonatomic, assign) NSInteger mDimNew9Id3;

/**
 * 其他备注
 */
@property (nonatomic, copy) NSString *qtxRemark;
/**
 * 其他备注2
 */
@property (nonatomic, copy) NSString *qtxRemark2;
/**
 * 其他备注3
 */
@property (nonatomic, copy) NSString *qtxRemark3;

/**
 * 袖长cm
 */
@property (nonatomic, copy) NSString * xcValue;


/**
 * 袖边
 */
@property (nonatomic, assign) NSInteger mDimNew45Id;

/**
 * 袖边cm
 */
@property (nonatomic, copy) NSString *xbcValue;

/**
 * 袖边组织
 */
@property (nonatomic, assign) NSInteger mDimNew46Id;


/**
 * 领：完全（领下拉框内的值）
 */
@property (nonatomic, copy) NSString * lwqt;

/**
 * 领:领边（领下拉框内的值）
 */
@property (nonatomic, copy) NSString *lbt;
/**
 * 领:领型（领下拉框内的值）
 */
@property (nonatomic, copy) NSString *lxt;

/**
 * 领边尺寸
 */
@property (nonatomic, copy) NSString *lbccValue;

/**
 * 领边层
 */
@property (nonatomic, assign) NSInteger mDimNew28Id;

/**
 * 领边
 */
@property (nonatomic, assign) NSInteger mDimNew26Id;

/**
 * 领型
 */
@property (nonatomic, assign) NSInteger mDimNew25Id;

/**
 * 粒扣后面的备注
 */
@property (nonatomic, copy) NSString *lxRemark;


/**
 * 其他领边
 */
@property (nonatomic, copy) NSString *lbqt;



/**
 * 花型
 */
@property (nonatomic, strong) NSArray * hxShow;

/**
 * 抽条
 */
@property (nonatomic, copy) NSString *ct;
/**
 * 抽条1
 */
@property (nonatomic, copy) NSString *ct1;


/**
 * 烫珠（勾选框列表）
 */
@property (nonatomic, strong) NSArray *tzShow;

//烫珠tzRemark
@property (nonatomic, copy) NSString *tzRemark;

// 绣花tzRemark1
@property (nonatomic, copy) NSString *tzRemark1;

// 串珠tzRemark2
@property (nonatomic, copy) NSString *tzRemark2;

/**
 * 口袋（勾选框列表）
 */
@property (nonatomic, copy) NSArray *kdShow;

/**
 * 口袋（其他）
 */
@property (nonatomic, copy) NSString *qtkdRemark;

/**
 * 附件（勾选框列表）
 */
@property (nonatomic, copy) NSArray *fjShow;

/**
 * 特殊工艺（勾选框列表）
 */
@property (nonatomic, copy) NSArray *tsgyShow;

/**
 * 特殊工艺（其他）
 */
@property (nonatomic, copy) NSString *qttsgyRemark;


/**
 * 下边cm
 */
@property (nonatomic, assign) NSInteger xbccValue;

/**
 * 下边
 */
@property (nonatomic, assign) NSInteger mDimNew10Id;

/**
 * 其他下边
 */
@property (nonatomic, copy) NSString *xbRemark;


/**
 * 袖口cm
 */
@property (nonatomic, copy) NSString * xkccValue;

/**
 * 袖口
 */
@property (nonatomic, assign) NSInteger mDimNew32Id;

/**
 * 袖口备注，其它
 */
@property (nonatomic, copy) NSString *xkRemark;

/**
 * 加注
 */
@property (nonatomic, copy) NSString *jzValue;


/**
 * 配套
 */
@property (nonatomic, assign) NSInteger mDimNew41Id;


/**
 * 展示的图片地址
 */
@property (nonatomic, copy) NSString *imgUrl;


/**
 * 尺寸类型
 */
@property (nonatomic, copy) NSString * sizeType;


/**
 * 品种json字符串
 */
@property (nonatomic, copy) NSString * pzJsonstr;
@property (nonatomic, copy) NSArray *pzJsonArray;

/**
 * 支别json字符串
 */
@property (nonatomic, copy) NSString * zbJsonstr;
@property (nonatomic, copy) NSArray *zbJsonArray;

/**
 * 组织json字符串
 */
@property (nonatomic, copy) NSString * zxJsonstr;
@property (nonatomic, copy) NSArray *zxJsonArray;

/**
 * 针型json字符串
 */
@property (nonatomic, copy) NSString * zzJsonstr;
@property (nonatomic, copy) NSArray *zzJsonArray;

@end
