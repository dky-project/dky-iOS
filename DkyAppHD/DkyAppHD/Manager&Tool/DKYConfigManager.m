//
//  DKYConfigManager.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYConfigManager.h"

@implementation DKYConfigManager

+ (void)config{
    // SVProgressHUD 配置
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
    
    // 键盘处理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = YES;
    manager.shouldShowTextFieldPlaceholder = NO;
    manager.toolbarTintColor = [UIColor colorWithHex:0x0074fb];
}

@end
