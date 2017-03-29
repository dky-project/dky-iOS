//
//  DKYConfigManager.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYConfigManager.h"
#import "LCActionSheet.h"

@implementation DKYConfigManager

+ (void)config{
    // SVProgressHUD 配置
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD setMaximumDismissTimeInterval:3.5];
    
    // 键盘处理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = YES;
    manager.shouldShowTextFieldPlaceholder = NO;
    manager.toolbarTintColor = [UIColor colorWithHex:0x0074fb];
    
    // SDWebimage 缓存，保存1年
    SDImageCache * cache = [SDImageCache sharedImageCache];
    cache.maxCacheAge = 30;
    
    // 统一配置 Config 作用于全局样式
    LCActionSheetConfig *config = [LCActionSheetConfig shared];
    config.scrolling = YES;
    config.visibleButtonCount = 10;
    config.cancelButtonTitle  = @"清除";
    config.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
}

@end
