//
//  DKYProductCusmptcateViewModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYProductCusmptcateViewModel : NSObject

@property (nonatomic, copy) NSString * gjxfShow;
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

@property (nonatomic, copy) NSString * jxShow;
@property (nonatomic, copy) NSString * lbShow;
@property (nonatomic, copy) NSString * lxShow;
@property (nonatomic, copy) NSString * syShow;
@property (nonatomic, copy) NSString * xbShow;
@property (nonatomic, copy) NSString * xkShow;
@property (nonatomic, copy) NSString * xwArray;
@property (nonatomic, copy) NSString * xxShow;

/**
 * 是否配置衣长
 * 值为“Y”时，请选择收腰下拉框下面的长[文本框]不可编辑
 */
@property (nonatomic, strong) NSString *isYcAffix;

@end
