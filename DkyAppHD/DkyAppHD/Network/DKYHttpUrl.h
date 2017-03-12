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
#define BASE_URL       @"http://60.190.63.14:99/dky-web/"
//#define BASE_URL       @"http://122.227.138.34:99/dky-web/"


//#define BASE_URL     @"https:"

//#define BASE_URL     @"http://192.168.3.171:8080/dky-web/"
//#define BASE_URL     @"http://192.168.3.76:7071/dky-web/"


// 接口
#define kQueryValidUrl                  @"boot/queryValid"              // 查询启动页

// 首页
#define kArticlePageUrl                 @"article/page"                 // 首页
#define kArticleDetailUrl               @"article/getById"              // 文章详细信息

// 样衣查询
#define kProductPageUrl                 @"product/page"                 // 样衣查询

#define kGetSexEnumUrl                  @"dimNew/getSexEnum"            // 性别列表
#define kGetBigClassEnumUrl             @"dimNew/getBigClassEnum"       // 大类

#define kGetDimNewListUrl               @"dimNew/getDimNewList"         // 获取所有选项的条件



#define kGetProductInfoUrl              @"product/getProductInfo"       // 样衣详细信息查询
#define kQueryPriceListUrl              @"product/queryPriceList"       // 查询价格列表
#define kQueryValueListUrl              @"product/queryValueList"       // 查询胸围、衣长、肩宽、袖长列表

// 定制订单
#define kGetProductApproveTitleUrl      @"productApprove/getProductApproveTitle"    // 定制订单

#define kGetMadeInfoByProductNameUrl    @"productApprove/getMadeInfoByProductName"  // 输入款号之后的调用

#define kGetVipInfoUrl                  @"getVipInfo"

// 订单查询
#define kProductApproveUrl              @"productApprove/page"          // 订单查询
#define kProductApproveInfoListUrl      @"productApprove/productApproveInfoList"  // 订单详细信息查询

// 登陆
#define kLoginUserUrl                   @"user/loginUser"               // 登陆

#endif /* DKYHttpUrl_h */
