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
//#define BASE_URL       @"http://122.227.138.34:99/dky-web/"

#define BASE_URL       @"http://60.190.63.14:99/dky-web/"

//#define BASE_URL     @"http://192.168.68.155:99/dky-web/"

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

#define kAddProductDefaultUrl           @"productApprove/addProductDefault"            // 样衣查询页面下单

#define kGetColorDimListUrl             @"dimNew/getColorDimList"  // 详情页下单品种，颜色

#define kGetProductInfoUrl              @"product/getProductInfo"       // 样衣详细信息查询
#define kQueryPriceListUrl              @"product/queryPriceList"       // 查询价格列表
#define kQueryValueListUrl              @"product/queryValueList"       // 查询胸围、衣长、肩宽、袖长列表

#define kGetSizeDataUrl                 @"dimNew/getSizeData"           // 胸围大 ，获取数据

// 定制订单
#define kGetProductApproveTitleUrl      @"productApprove/getProductApproveTitle"    // 定制订单

#define kGetMadeInfoByProductNameUrl    @"productApprove/getMadeInfoByProductName"  // 输入款号之后的调用

#define kGetVipInfoUrl                  @"user/getVipName"

#define kMptApproveSaveUrl              @"productApprove/bMptApproveSave"           // 大货订单保存接口
#define kAddProductApproveUrl           @"productApprove/addProductApprove"         // 基础下单
#define kGetPzsJsonUrl                  @"dimNew/getPzsJson"                        // 品种、组织、针型、支别下拉框操作时需要调用后台接口返回新的下拉框值给这四个下拉框重新填充

#define kConfirmProductApproveUrl       @"productApprove/confirmProductApprove"     // 生成订单接口
#define kGetColorListUrl                @"dimNew/getColorList"                      // 品种下拉框选择需要动态调用接口获取颜色列表

#define kOrderHtmlUrl                    @"boot/table"

// 订单查询
#define kProductApproveUrl              @"productApprove/page"          // 订单查询
#define kProductApproveInfoListUrl      @"productApprove/productApproveInfoList"  // 订单详细信息查询
#define kUpdateProductApproveUrl        @"productApprove/updateProductApprove"    // 删除订单

#define kProductApproveBmptPageUrl      @"productApprove/bmptPage"              // 大货订单查询

// 收藏
#define kProductCollectPageUrl          @"productCollect/page"                  // 收藏列表
#define kAddProductCollectUrl           @"productCollect/addProductCollect"     // 添加收藏
#define kDelProductCollectUrl           @"productCollect/delProductCollect"     // 取消收藏

/**陈列，搭配*/
#define kGetProductListByGroupNoUrl     @"product/getProductListByGroupNo"      // 根据组号查询

// 登陆
#define kLoginUserUrl                   @"user/loginUser"               // 登陆

#endif /* DKYHttpUrl_h */
