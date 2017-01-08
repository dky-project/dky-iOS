//
//  DKYHUDTool.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHUDTool.h"

@implementation DKYHUDTool

+ (instancetype)HUDTool{
    return [[DKYHUDTool alloc] init];
}

+ (void)show{
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString*)status{
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)showErrorWithStatus:(NSString*)status{
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString*)status{
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showInfoWithStatus:(NSString*)status{
    [SVProgressHUD showInfoWithStatus:status];
}

+ (MBProgressHUD *)showInformation:(NSString*)message toView:(UIView *)view{
    return [MBProgressHUD showInformation:message toView:view];
}

@end
