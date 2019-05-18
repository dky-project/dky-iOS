//
//  DKYAccountManager.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYAccountManager : NSObject

+(instancetype)sharedInstance;

- (void)saveUserAccountInfo:(NSDictionary*)userInfo;

- (void)saveAccessToken:(NSString*)accessToken;
- (NSString*)getAccessToken;
- (NSString*)getAccessTokenWithNoBearer;
- (void)deleteAccesToken;
- (BOOL)isLogin;

- (NSString*)getJgno;
- (void)saveJgno:(NSString*)jgno;
- (void)deleteJgno;

@end
