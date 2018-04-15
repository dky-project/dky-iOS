//
//  AppDelegate.m
//  DkyAppHD
//
//  Created by HaKim on 16/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "AppDelegate.h"
#import "DKYGuidenceViewController.h"
#import "DKYTabBarViewController.h"
#import "DKYConfigManager.h"
#import "DKYLoginViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 假登陆
//    [[DKYAccountManager sharedInstance] saveAccessToken:@"fakeLogin"];
//    [[DKYAccountManager sharedInstance] deleteAccesToken];
    
    
    // 全局配置
    [DKYConfigManager config];
    
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userNotLogin:) name:kUserNotLoginNotification object:nil];
    
    if([[DKYAccountManager sharedInstance] isLogin]){
        [NSThread sleepForTimeInterval:1.5];
        DKYTabBarViewController *mainVc = (DKYTabBarViewController*)[UIStoryboard viewControllerWithClass:[DKYTabBarViewController class]];
        mainVc.delegate = self;
        self.window.rootViewController = mainVc;
    }else{
        DKYGuidenceViewController *guidenceVC = (DKYGuidenceViewController*)[UIStoryboard viewControllerWithClass:[DKYGuidenceViewController class]];
        
        self.window.rootViewController = guidenceVC;
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 移除通知，是否有移除通知的必要性
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserNotLoginNotification object:nil];
}

#pragma mark - 全局通知
- (void)userNotLogin:(NSNotification *)notification{
    // 先清除本地的accessToken
    [[DKYAccountManager sharedInstance] deleteAccesToken];
    
    // 弹出登录界面
    DKYLoginViewController *loginVc = (DKYLoginViewController*)[UIStoryboard viewControllerWithClass:[DKYLoginViewController class]];
    loginVc.fromLogout = YES;
    [self.window.rootViewController presentViewController:loginVc animated:YES completion:^(){
        
    }];
}

@end
