//
//  DKYHUDTool.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHUDTool.h"

static BOOL hudWillAotoDismiss = NO;

@interface DKYHUDTool ()

@end

@implementation DKYHUDTool

+ (instancetype)HUDTool{
    return [[DKYHUDTool alloc] init];
}

+ (void)show{
    hudWillAotoDismiss = NO;
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString*)status{
    hudWillAotoDismiss = NO;
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss{
    if(hudWillAotoDismiss) return;
    [SVProgressHUD dismiss];
}

+ (void)showErrorWithStatus:(NSString*)status{
    hudWillAotoDismiss = YES;
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString*)status{
    hudWillAotoDismiss = YES;
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showInfoWithStatus:(NSString*)status{
    hudWillAotoDismiss = YES;
    [SVProgressHUD showInfoWithStatus:status];
}

+ (MBProgressHUD *)showInformation:(NSString*)message toView:(UIView *)view{
    return [MBProgressHUD showInformation:message toView:view];
}

@end
