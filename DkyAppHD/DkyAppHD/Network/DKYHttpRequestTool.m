//
//  DKYHttpRequestTool.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYHttpRequestTool.h"
#import "AFNetworking.h"

@interface DKYHttpRequestTool ()<NSURLSessionDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *httpClient;

@end

@implementation DKYHttpRequestTool

+(instancetype) httpRequestToolWithBaseUrlString:(NSString*)urlString
{
    return [[DKYHttpRequestTool alloc]initWithBaseUrlString:urlString];
}

-(id) initWithBaseUrlString:(NSString*)urlString
{
    self = [super init];
    if (self) {
        _httpClient = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:urlString]];
        _httpClient.requestSerializer.timeoutInterval = 30;
        
        _httpClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //http://blog.csdn.net/wangyanchang21/article/details/51180016 配置https
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO 如果是需要验证自建证书，需要设置为YES
        _httpClient.securityPolicy.allowInvalidCertificates = YES;
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO  主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        _httpClient.securityPolicy.validatesDomainName = NO;
        //取出reponseSerilizer可接受的内容类型集合
        NSMutableSet *set = [NSMutableSet setWithSet:_httpClient.responseSerializer.acceptableContentTypes];
        //增加类型
        [set addObject:@"text/plain"];
        [set addObject:@"text/html"];
        [set addObject:@"application/json"];
        
        //设回去
        _httpClient.responseSerializer.acceptableContentTypes = [set copy];
        
    }
    return self;
}

#pragma mark - GET请求
- (void)doGet:(NSString*)urlString
        hDict:(NSDictionary *)hDict
   parameters:(NSDictionary *)pDict
 successBlock:(DKYHttpRequestSuccessBlock)successblock
   errorBlock:(DKYHttpRequestErrorBlock)errorblock
{
    DLog(@"%@Get url = %@%@ \nGet parameter = %@%@",kLogStart,BASE_URL,urlString,pDict,kLogEnd);
    //填充HTTP custom header
    if (hDict !=nil) {
        NSArray *keys = [hDict allKeys];
        for (NSString *key in keys) {
            NSString *value = [hDict objectForKey:key];
            [self.httpClient.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    [self.httpClient GET:urlString parameters:pDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@Get url = %@%@ \nGet response = %@%@",kLogStart,BASE_URL,urlString,responseObject,kLogEnd);
        if (successblock) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse*)task.response;
            successblock(res.statusCode,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorblock) {
            errorblock(error);
        }
    }];
}

#pragma mark - POST请求
- (void)doPost:(NSString*)urlString
         hDict:(NSDictionary *)hDict
    parameters:(NSDictionary *)pDict
  successBlock:(DKYHttpRequestSuccessBlock)successblock
    errorBlock:(DKYHttpRequestErrorBlock)errorblock
{
    DLog(@"%@post url = %@%@ \npost data = %@%@",kLogStart,BASE_URL,urlString,pDict,kLogEnd);
    //填充HTTP custom header
    if (hDict !=nil) {
        NSArray *keys = [hDict allKeys];
        for (NSString *key in keys) {
            NSString *value = [hDict objectForKey:key];
            [_httpClient.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    [self.httpClient POST:urlString
               parameters:pDict
                 progress:^(NSProgress * _Nonnull uploadProgress) {
                     
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     DLog(@"%@post url = %@%@ \nresponse data = %@%@",kLogStart,BASE_URL,urlString,responseObject,kLogEnd);
                     if (successblock) {
                         NSHTTPURLResponse *res = (NSHTTPURLResponse*)task.response;
                         successblock(res.statusCode,responseObject);
                     }
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (errorblock) {
                         errorblock(error);
                     }
                 }];
    
    
}


@end
