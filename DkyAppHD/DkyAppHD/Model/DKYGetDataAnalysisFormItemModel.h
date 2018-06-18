//
//  DKYGetDataAnalysisFormItemModel.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/18.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYGetDataAnalysisFormItemModel : NSObject

/**
 * 数量
 */
@property (nonatomic, strong) NSNumber *zxQty;

/**
 * 总数
 */
@property (nonatomic, strong) NSNumber *allSum;

/**
 * 占比
 */
@property (nonatomic, copy) NSString *bfb;

/**
 * 推荐比例
 */
@property (nonatomic, copy) NSString *proportion;

/**
 * 属性名称
 */
@property (nonatomic, copy) NSString *attribname;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSNumber *Id;

@end
