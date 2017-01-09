//
//  Constant.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//device
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define iPhone6p ([UIScreen mainScreen].bounds.size.height > 667)

//------------------------------------系统版本-------------------------------------------
#define IOS_VERSION          [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_IOS_9_OR_PREVIOUS  ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)

#define IS_IOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_IOS_7_OR_PREVIOUS ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define isiPad  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kTabBarHeight              (49)
#define kNavigationBarHeight       (64)

#define kPageSize                   (20)
#define iOS_VER [[[UIDevice currentDevice] systemVersion] floatValue]

#define WeakSelf(weakSelf)      __weak __typeof(&*self)weakSelf = self;
#define StrongSelf(weakSelf)    __strong __typeof(weakSelf)strongSelf = weakSelf;

#define kOnePixLine         (1.0/[UIScreen mainScreen].scale)

#define isLandscape(size)   [self isLandscape:size];

// Block 类型定义

typedef void(^BlockWithSender)(id sender);

typedef void(^BlockWithSenderAndType)(id sender, NSInteger type);

// 信号量为1的，模拟互斥锁
#define Lock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define Unlock() dispatch_semaphore_signal(self->_lock)

//消息通知
#define kUserNotLoginNotification @"UserNotLoginNotification"


#endif /* Constant_h */
