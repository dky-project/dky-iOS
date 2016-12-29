//
//  UIDevice+Extensions.h
//  DjdApp
//
//  Created by HaKim on 16/3/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJDSIMCardInfoModel;

typedef NS_ENUM(NSUInteger, TWDeviceType) {
    DeviceAppleUnknown,
    DeviceAppleSimulator,
    DeviceAppleiPhone,
    DeviceAppleiPhone3G,
    DeviceAppleiPhone3GS,
    DeviceAppleiPhone4,
    DeviceAppleiPhone4S,
    DeviceAppleiPhone5,
    DeviceAppleiPhone5C,
    DeviceAppleiPhone5S,
    DeviceAppleiPhone6,
    DeviceAppleiPhone6_Plus,
    DeviceAppleiPhone6s,
    DeviceAppleiPhone6_Plus_s,
    DeviceAppleiPodTouch,
    DeviceAppleiPodTouch2G,
    DeviceAppleiPodTouch3G,
    DeviceAppleiPodTouch4G,
    DeviceAppleiPad,
    DeviceAppleiPad2,
    DeviceAppleiPad3G,
    DeviceAppleiPad4G,
    DeviceAppleiPad5G_Air,
    DeviceAppleiPadMini,
    DeviceAppleiPadMini2G
};


@interface UIDevice (Extensions)

- (NSString *)tw_deviceDescription;
- (TWDeviceType)tw_deviceType;
- (NSString *)tw_deviceName;
- (NSString *)tw_systermVersion;
- (NSString*)tw_systemName;

//获取设备的sim卡信息
+ (DJDSIMCardInfoModel *)getSIMCard;


@end
