//
//  DKYHttpRequestTool.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DKYHttpRequestSuccessBlock)(NSInteger statusCode,id data);
typedef void(^DKYHttpRequestErrorBlock)(NSError *error);

@interface DKYHttpRequestTool : NSObject

+(instancetype) httpRequestToolWithBaseUrlString:(NSString*)urlString;
-(instancetype) initWithBaseUrlString:(NSString*)urlString;

- (void)doGet:(NSString*)urlString
        hDict:(NSDictionary *)hDict
   parameters:(NSDictionary *)pDict
 successBlock:(DKYHttpRequestSuccessBlock)successblock
   errorBlock:(DKYHttpRequestErrorBlock)errorblock;

- (void)doPost:(NSString*)urlString
         hDict:(NSDictionary *)hDict
    parameters:(NSDictionary *)pDict
  successBlock:(DKYHttpRequestSuccessBlock)successblock
    errorBlock:(DKYHttpRequestErrorBlock)errorblock;

@end
