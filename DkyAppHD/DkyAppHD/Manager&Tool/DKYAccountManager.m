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

@implementation DKYAccountManager

- (void)saveUserAccountInfo:(NSDictionary*)userInfo{
    
}

- (void)saveAccessToken:(NSString*)accessToken{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kSSKeychainAccessTokenWithNoBearer];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    accessToken = [NSString stringWithFormat:@"Bearer %@",accessToken];
    
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kSSKeychainAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)getAccessToken{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kSSKeychainAccessToken];
    return accessToken;
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
