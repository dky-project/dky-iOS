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

- (void)articlePageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kArticlePageUrl withParameter:parameter Success:success failure:failure];
}

- (void)articleDetaiWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kArticleDetailUrl withParameter:parameter Success:success failure:failure];
}

- (void)productPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kProductPageUrl withParameter:parameter Success:success failure:failure];
}

- (void)getSexEnumWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kGetSexEnumUrl withParameter:parameter Success:success failure:failure];
}

- (void)getBigClassEnumWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kGetBigClassEnumUrl withParameter:parameter Success:success failure:failure];
}

- (void)getProductInfoWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
//    [self p_doGetWithAuthorizationToken:kGetProductInfoUrl withParameter:parameter Success:success failure:failure];
    [self p_doPostWithAuthorizationToken:kGetProductInfoUrl withParameter:parameter Success:success failure:failure];
    
}

- (void)queryPriceListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kQueryPriceListUrl withParameter:parameter Success:success failure:failure];
}

- (void)queryValueWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kQueryValueListUrl withParameter:parameter Success:success failure:failure];
}

- (void)productApprovePageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kProductApproveUrl withParameter:parameter Success:success failure:failure];
}

- (void)productApproveInfoListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kProductApproveInfoListUrl withParameter:parameter Success:success failure:failure];
}

- (void)getProductApproveTitleWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kGetProductApproveTitleUrl withParameter:parameter Success:success failure:failure];
}

- (void)getMadeInfoByProductNameWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithAuthorizationToken:kGetMadeInfoByProductNameUrl withParameter:parameter Success:success failure:failure];
}

- (void)LoginUserWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    [self p_doPostWithNoAuthorizationToken:kLoginUserUrl withParameter:parameter Success:success failure:failure];
}


#pragma mark - private method
- (void)p_doPostWithAuthorizationToken:(NSString*)url withParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    NSDictionary *pDict = nil;
    if(parameter){
        pDict = [parameter mj_keyValues];
    }
    
    NSDictionary *hDict = nil;
    NSString *accessTokenWithBearer = [[DKYAccountManager sharedInstance] getAccessToken];
    if (accessTokenWithBearer)
    {
        DLog(@"Authorization = %@",accessTokenWithBearer);
        hDict = @{@"Authorization":accessTokenWithBearer};
    }
    
    [self.httpRequestTool doPost:url
                           hDict:hDict
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

- (void)p_doGetWithAuthorizationToken:(NSString*)url withParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    NSDictionary *pDict = nil;
    if(parameter){
        pDict = [parameter mj_keyValues];
    }
    
    NSDictionary *hDict = nil;
    NSString *accessTokenWithBearer = [[DKYAccountManager sharedInstance] getAccessToken];
    if (accessTokenWithBearer)
    {
        DLog(@"Authorization = %@",accessTokenWithBearer);
        hDict = @{@"Authorization":accessTokenWithBearer};
    }
    
    [self.httpRequestTool doGet:url
                           hDict:hDict
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


- (void)p_doGetWithNoAuthorizationToken:(NSString*)url withParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure{
    NSDictionary *pDict = nil;
    if(parameter){
        pDict = parameter.mj_keyValues;
    }
    
    [self.httpRequestTool doGet:url
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
