//
//  DKYHttpRequestParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//字段名称	说明
//version	客户端版本version，例：1.0.0
//token	登陆成功后，server返回的登陆令牌token
//os	手机系统版本（Build.VERSION.RELEAS）例：4.4，4.5
//from	请求来源，例：android/ios/h5
//screen	手机尺寸，例：1080*1920
//model	机型信息（Build.MODEL），例：Redmi Note 3
//channel	渠道信息，例：com.wandoujia
//net	APP当前网络状态，例：wifi，mobile；部分接口可以根据用户当前的网络状态，下发不同数据策略，如：wifi则返回高清图，mobile情况则返回缩略图
//appid	APP唯一标识，有的公司一套server服务多款APP时，需要区分开每个APP来源

@interface DKYHttpRequestParameter : NSObject

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *os;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *screen;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *net;
@property (nonatomic, copy) NSString *appid;

@end
