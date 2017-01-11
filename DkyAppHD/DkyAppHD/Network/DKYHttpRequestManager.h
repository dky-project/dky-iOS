//
//  DKYHttpRequestManager.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKYHttpRequestTool.h"

@class DKYHttpRequestParameter;
@interface DKYHttpRequestManager : NSObject

/**
 *  获取启动页
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)queryValidUrlWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  获取首页数据
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)articlePageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;


/**
 *  样衣查询接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)productPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   获取性别选项的文案和枚举值
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getSexEnumWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   获取大类选项的文案和枚举值
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getBigClassEnumWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   样衣详细信息查询
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductInfoWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   查询价格列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)queryPriceListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   查询胸围、衣长、肩宽、袖长列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)queryValueWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  登录接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)LoginUserWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;


+(instancetype)sharedInstance;

@end
