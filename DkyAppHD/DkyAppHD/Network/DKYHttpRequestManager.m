//
//  DKYHttpRequestManager.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYHttpRequestManager.h"
#import "DKYHttpRequestParameter.h"

static DKYHttpRequestManager *sharedInstance = nil;

@interface DKYHttpRequestManager ()

@property (nonatomic, strong) DKYHttpRequestTool *httpRequestTool;

@end

@implementation DKYHttpRequestManager

- (void)queryValidUrlWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithNoAuthorizationToken:kQueryValidUrl withParameter:parameter Success:success failure:failure];
}

- (void)LoginUserWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithNoAuthorizationToken:kLoginUserUrl withParameter:parameter Success:success failure:failure];
}


#pragma mark - private method
- (void)p_doPostWithNoAuthorizationToken:(NSString*)url withParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    NSDictionary *pDict = nil;
    if(parameter){
        pDict = parameter.mj_keyValues;
    }
    
    [self.httpRequestTool doPost:url
                           hDict:nil
                      parameters:pDict
                    successBlock:^(NSInteger statusCode, id data) {
                        if(success){
                            success(statusCode,data);
                        }
                    }
                      errorBlock:^(NSError *error) {
                          if(failure){
                              failure(error);
                          }
                      }];
}

#pragma mark - 单例模式，获取DJDHttpRequestManager
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DKYHttpRequestManager alloc] init];
    });
    return sharedInstance;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

-(id)copyWithZone:(NSZone*)zone
{
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.httpRequestTool = [DKYHttpRequestTool httpRequestToolWithBaseUrlString:BASE_URL];
    }
    return self;
}

@end
