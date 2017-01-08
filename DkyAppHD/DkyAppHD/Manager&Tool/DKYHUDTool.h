//
//  DKYHUDTool.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYHUDTool : NSObject

+ (instancetype)HUDTool;

+ (void)show;

+ (void)showWithStatus:(NSString*)status;

+ (void)showErrorWithStatus:(NSString*)status;

+ (void)showSuccessWithStatus:(NSString*)status;

+ (void)showInfoWithStatus:(NSString*)status;

+ (void)dismiss;

+ (MBProgressHUD *)showInformation:(NSString*)message toView:(UIView *)view;

@property (nonatomic, assign) DkyHUDUnderType HUDUnderType;
@end
