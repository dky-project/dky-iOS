//
//  DKYSampleProductInfoModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYSampleProductInfoModel : NSObject

// 图片列表
@property (nonatomic, strong) NSArray *imgList;
/**
 * 大类
 */
@property (nonatomic, copy) NSString * mDimNew11Text;
/**
 * 性别
 */
@property (nonatomic, copy) NSString * mDimNew13Text;
/**
 * 所属类别
 */
@property (nonatomic, copy) NSString * mptbelongtypeText;
/**
 * 款号
 */
@property (nonatomic, copy) NSString * name;

// 温馨提示
@property (nonatomic, copy) NSString *description3;

// 设计说明
@property (nonatomic, copy) NSString *description5;
/**
 * 领子
 */
@property (nonatomic, copy) NSString *description4;

/**
 * 品种
 */
@property (nonatomic, copy) NSString *mDimNew14Text;
/**
 * 针型
 */
@property (nonatomic, copy) NSString *mDimNew16Text;
/**
 * 颜色
 */
@property (nonatomic, copy) NSString *clrRange;
/**
 * 胸围
 */
@property (nonatomic, copy) NSString *defaultXwValue;
/**
 * 衣长
 */
@property (nonatomic, copy) NSString *defaultYcValue;
/**
 * 袖长
 */
@property (nonatomic, copy) NSString *defaultXcValue;

@property (nonatomic, copy) NSString *mptbelongtype;

@property (nonatomic, copy) NSString *pdtPrice;

@property (nonatomic, copy) NSString *gw;

/**
 * 杆位表格
 */
@property (nonatomic, strong) NSDictionary *gwView;

// 客户端自己的属性
@property (nonatomic, strong) NSNumber *mProductId;

@property (nonatomic, copy) NSString *pdt;

@property (nonatomic, assign) BOOL isBigOrder;

@property (nonatomic, copy) NSString *mDim16Text;
@end
