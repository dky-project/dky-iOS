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
    cache.maxCacheAge = 60 * 60 * 24 * 365;
    
    // 统一配置 Config 作用于全局样式
    LCActionSheetConfig *config = [LCActionSheetConfig shared];
    config.scrolling = YES;
    config.visibleButtonCount = 10;
    config.cancelButtonTitle  = @"清除";
    config.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
    
    
    // 实时打印设备内存信息
#ifdef DEBUG
    [NSTimer scheduledTimerWithTimeInterval:5.0 block:^(NSTimer * _Nonnull timer) {
        UIDevice *device = [UIDevice currentDevice];
        DLog(@"CPU信息:");
        DLog(@"%@核CPU",@(device.cpuCount));
        DLog(@"当前CPU : %@%%",@((NSInteger)(device.cpuUsage * 100)));
        
        NSInteger i = 0;
        DLog(@"各个CPU使用信息:");
        for (NSNumber *usage in device.cpuUsagePerProcessor) {
            DLog(@"CPU%@:%@%%",@(i),@((NSInteger)([usage doubleValue] * 100)));
            ++i;
        }
        
        DLog(@"内存信息:")
        DLog(@"总共内存 %@MB",@(device.memoryTotal / 1024 / 1024));
        DLog(@"已用内存 %@MB",@(device.memoryUsed / 1024 / 1024));
        DLog(@"可用内存 %@MB",@(device.memoryFree / 1024 / 1024));
    } repeats:YES];
#endif
}

@end
