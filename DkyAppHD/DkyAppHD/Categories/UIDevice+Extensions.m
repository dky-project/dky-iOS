//
//  UIDevice+Extensions.m
//  DjdApp
//
//  Created by HaKim on 16/3/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "UIDevice+Extensions.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "DJDDeviceRequestParameter.h"
#import "UUIDHelper.h"


@implementation UIDevice (Extensions)
- (NSString *)tw_deviceDescription
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (TWDeviceType)tw_deviceType
{
    NSNumber *deviceType = [[self tw_deviceTypeLookupTable] objectForKey:[self tw_deviceDescription]];
    return [deviceType unsignedIntegerValue];
}

- (NSString *)tw_deviceName{
    NSNumber *deviceType = [[self tw_deviceTypeLookupTable] objectForKey:[self tw_deviceDescription]];
    return [[self tw_deviceNameTypeLookupTable] objectForKey:deviceType];
}

- (NSString *)tw_systermVersion{
    return [UIDevice currentDevice].systemVersion;
}

- (NSString*)tw_systemName{
    return [UIDevice currentDevice].systemName;
}

- (NSDictionary *)tw_deviceTypeLookupTable
{
    return @{
             @"i386": @(DeviceAppleSimulator),
             @"x86_64": @(DeviceAppleSimulator),
             @"iPod1,1": @(DeviceAppleiPodTouch),
             @"iPod2,1": @(DeviceAppleiPodTouch2G),
             @"iPod3,1": @(DeviceAppleiPodTouch3G),
             @"iPod4,1": @(DeviceAppleiPodTouch4G),
             @"iPhone1,1": @(DeviceAppleiPhone),
             @"iPhone1,2": @(DeviceAppleiPhone3G),
             @"iPhone2,1": @(DeviceAppleiPhone3GS),
             @"iPhone3,1": @(DeviceAppleiPhone4),
             @"iPhone3,3": @(DeviceAppleiPhone4),
             @"iPhone4,1": @(DeviceAppleiPhone4S),
             @"iPhone5,1": @(DeviceAppleiPhone5),
             @"iPhone5,2": @(DeviceAppleiPhone5),
             @"iPhone5,3": @(DeviceAppleiPhone5C),
             @"iPhone5,4": @(DeviceAppleiPhone5C),
             @"iPhone6,1": @(DeviceAppleiPhone5S),
             @"iPhone6,2": @(DeviceAppleiPhone5S),
             @"iPhone7,1": @(DeviceAppleiPhone6_Plus),
             @"iPhone7,2": @(DeviceAppleiPhone6),
             @"iPhone8,1": @(DeviceAppleiPhone6s),
             @"iPhone8,2": @(DeviceAppleiPhone6_Plus_s),
             @"iPad1,1": @(DeviceAppleiPad),
             @"iPad2,1": @(DeviceAppleiPad2),
             @"iPad3,1": @(DeviceAppleiPad3G),
             @"iPad3,4": @(DeviceAppleiPad4G),
             @"iPad2,5": @(DeviceAppleiPadMini),
             @"iPad4,1": @(DeviceAppleiPad5G_Air),
             @"iPad4,2": @(DeviceAppleiPad5G_Air),
             @"iPad4,4": @(DeviceAppleiPadMini2G),
             @"iPad4,5": @(DeviceAppleiPadMini2G)
             };
}

- (NSDictionary *)tw_deviceNameTypeLookupTable
{
    return @{
             @(DeviceAppleSimulator) : @"Simulator_i386",
             @(DeviceAppleSimulator) : @"Simulator_x86_64",
             @(DeviceAppleiPodTouch) : @"iPod",
             @(DeviceAppleiPodTouch2G) : @"iPod2",
             @(DeviceAppleiPodTouch3G) :@"iPod3",
             @(DeviceAppleiPodTouch4G) :@"iPod4",
             @(DeviceAppleiPhone) :@"iPhone",
             @(DeviceAppleiPhone3G):@"iPhone3",
             @(DeviceAppleiPhone3GS):@"iPhone3",
             @(DeviceAppleiPhone4):@"iPhones",
             @(DeviceAppleiPhone4):@"iPhone4",
             @(DeviceAppleiPhone4S):@"iPhone4s",
             @(DeviceAppleiPhone5):@"iPhone5",
             @(DeviceAppleiPhone5):@"iPhone5",
             @(DeviceAppleiPhone5C):@"iPhone5c",
             @(DeviceAppleiPhone5C):@"iPhone5c",
             @(DeviceAppleiPhone5S):@"iPhone5s",
             @(DeviceAppleiPhone5S):@"iPhone5s",
             @(DeviceAppleiPhone6_Plus):@"iPhone6Plus",
             @(DeviceAppleiPhone6):@"iPhone6",
             @(DeviceAppleiPhone6s):@"iPhone6s",
             @(DeviceAppleiPhone6_Plus_s):@"iPhone6Ps",
             @(DeviceAppleiPad) : @"iPad",
             @(DeviceAppleiPad2): @"iPad2",
             @(DeviceAppleiPad3G): @"iPad3",
             @(DeviceAppleiPad4G): @"iPad4",
             @(DeviceAppleiPadMini): @"iPadMini",
             @(DeviceAppleiPad5G_Air): @"iPad5_Air",
             @(DeviceAppleiPad5G_Air): @"iPad5_Air",
             @(DeviceAppleiPadMini2G): @"iPadMini2",
             @(DeviceAppleiPadMini2G): @"iPadMini2"
             };
}

//获取设备的sim卡信息
+ (DJDSIMCardInfoModel *)getSIMCard
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    DJDSIMCardInfoModel *simCardModel = [[DJDSIMCardInfoModel alloc] init];
    simCardModel.imei = [UUIDHelper getUUID];
    simCardModel.simIsp = carrier.carrierName;
    
    return simCardModel;
}

@end
