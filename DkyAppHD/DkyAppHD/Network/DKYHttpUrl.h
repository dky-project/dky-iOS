//
//  DKYHttpUrl.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#ifndef DKYHttpUrl_h
#define DKYHttpUrl_h

// 主机
//#define BASE_URL     @"https:"

//#define BASE_URL     @"http://192.168.3.171:8080/dky-web/"

#define BASE_URL     @"http://192.168.3.76:7071/dky-web/"


// 接口
#define kQueryValidUrl                  @"boot/queryValid"              // 查询启动页

// 首页
#define kArticlePageUrl                 @"article/page"                 // 首页


// 样衣查询
#define kProductPageUrl                 @"product/page"                 // 样衣查询

#define kGetSexEnumUrl                  @"dimNew/getSexEnum"            // 性别列表
#define kGetBigClassEnumUrl             @"dimNew/getBigClassEnum"       // 大类


#define kGetProductInfoUrl              @"product/getProductInfo"       // 样衣详细信息查询
#define kQueryPriceListUrl              @"product/queryPriceList"       // queryPriceList
#define kQueryValueListUrl              @"roduct/queryValueList"        // 查询胸围、衣长、肩宽、袖长列表

// 登陆
#define kLoginUserUrl                   @"user/loginUser"               // 登陆

#endif /* DKYHttpUrl_h */
