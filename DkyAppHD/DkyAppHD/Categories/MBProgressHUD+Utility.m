//
//  MBProgressHUD+Utility.m
//  GushiJianghu
//
//  Created by Wang on 15/9/12.
//  Copyright (c) 2015年 com.jijinwan. All rights reserved.
//

#import "MBProgressHUD+Utility.h"

@implementation MBProgressHUD (Utility)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    hud.minSize = CGSizeMake(100, 100);
    return hud;
}

+ (MBProgressHUD *)showInformation:(NSString*)message toView:(UIView *)view{
    MBProgressHUD *preHud = [MBProgressHUD HUDForView:view];
    if(preHud && preHud.mode == MBProgressHUDModeText){
        return nil;
    }
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText= message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    //hud.color = [UIColor colorWithHex:0x4d4d4d];
    hud.color = [UIColor colorWithWhite:0.1 alpha:0.7];
    hud.minSize = CGSizeMake(180, 49);
    hud.cornerRadius = 10.0;
    [hud hide:YES afterDelay:1.7];
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


@end
