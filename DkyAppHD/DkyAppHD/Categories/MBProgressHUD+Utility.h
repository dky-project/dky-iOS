//
//  MBProgressHUD+Utility.h
//  GushiJianghu
//
//  Created by Wang on 15/9/12.
//  Copyright (c) 2015年 com.jijinwan. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Utility)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showInformation:(NSString*)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
