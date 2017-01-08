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
 *  登录接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)LoginUserWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

+(instancetype)sharedInstance;

@end
