//
//  DKYProductCusmptcateViewModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYProductCusmptcateViewModel : NSObject

/**
 * 是否配置衣长
 * 值为“Y”时，花型对应的勾选框都不可编辑
 */
@property (nonatomic, copy) NSString * isHxAffix;
/**
 * 是否配置肩宽
 * 值为“Y”时，肩宽：[文本框]cm不可编辑
 */
@property (nonatomic, copy) NSString * isJkAffix;
/**
 * 是否配置袖长
 * 值为“Y”时，袖长：[文本框]cm不可编辑
 */
@property (nonatomic, copy) NSString * isXcAffix;

@property (nonatomic, copy) NSArray * jxShow;
//领边
@property (nonatomic, copy) NSArray * lbShow;
//领型
@property (nonatomic, copy) NSArray * lxShow;
//式样
@property (nonatomic, copy) NSArray * syShow;
//下边
@property (nonatomic, copy) NSArray * xbShow;
//袖口
@property (nonatomic, copy) NSArray * xkShow;
//袖型
@property (nonatomic, copy) NSArray * xxShow;
//挂肩袖肥
@property (nonatomic, copy) NSArray * gjxfShow;

@property (nonatomic, copy) NSString * xwArray;
@property (nonatomic, copy) NSArray * xwArrayList;


/**
 * 是否配置衣长
 * 值为“Y”时，请选择收腰下拉框下面的长[文本框]不可编辑
 */
@property (nonatomic, strong) NSString *isYcAffix;

@end
