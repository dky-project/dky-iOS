//
//  DKYAccountManager.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYAccountManager.h"

static  NSString* const kSSKeychainService = @"DkyAPP";
static  NSString* const kSSKeychainAccount = @"DkyAPPAccount";
static  NSString* const kSSKeychainCustID = @"DkyAPPCustID";


static  NSString* const kSSKeychainAccessToken = @"DkyAccessToken";
static  NSString* const kSSKeychainAccessTokenWithNoBearer = @"DkyAccessTokenWithNoBearer";


static DKYAccountManager *sharedInstance = nil;

@interface DKYAccountManager ()

@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, copy) NSString *accessTokenWithBearer;

@end

@implementation DKYAccountManager

- (void)saveUserAccountInfo:(NSDictionary*)userInfo{
    
}

- (void)saveAccessToken:(NSString*)accessToken{
//    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kSSKeychainAccessTokenWithNoBearer];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kSSKeychainAccessToken];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    self.accessToken = accessToken;
    [[YYCache defaultCache] setObject:self.accessToken forKey:kSSKeychainAccessTokenWithNoBearer];
    
    accessToken = [NSString stringWithFormat:@"Bearer %@",accessToken];
    self.accessTokenWithBearer = accessToken;
    [[YYCache defaultCache] setObject:self.accessTokenWithBearer forKey:kSSKeychainAccessToken];
}

- (NSString*)getAccessToken{
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kSSKeychainAccessToken];
    NSString *accessToken = (NSString*)[[YYCache defaultCache] objectForKey:kSSKeychainAccessToken];
    return accessToken;
}

- (NSString*)getAccessTokenWithNoBearer{
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kSSKeychainAccessTokenWithNoBearer];
    NSString *accessToken = (NSString*)[[YYCache defaultCache] objectForKey:kSSKeychainAccessTokenWithNoBearer];
    return accessToken;
}

- (void)deleteAccesToken{
    [[YYCache defaultCache] removeObjectForKey:kSSKeychainAccessTokenWithNoBearer];
    [[YYCache defaultCache] removeObjectForKey:kSSKeychainAccessToken];
}

- (BOOL)isLogin{
    NSString *accessToken = [self getAccessToken];
    
    return (accessToken && ![accessToken isEqualToString:@""]);
}

#pragma mark - 单例模式，获取DJDHttpRequestManager
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DKYAccountManager alloc] init];
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
        
    }
    return self;
}


@end
