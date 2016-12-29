//
//  DKYHttpRequestManager.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "DKYHttpRequestManager.h"

static DKYHttpRequestManager *sharedInstance = nil;

@interface DKYHttpRequestManager ()

@property (nonatomic, strong) DKYHttpRequestTool *httpRequestTool;

@end

@implementation DKYHttpRequestManager


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
