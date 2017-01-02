//
//  GlobalEnum.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#ifndef GlobalEnum_h
#define GlobalEnum_h

// http 请求返回结果定义 retCode
typedef NS_ENUM(NSInteger, DkyHttpResponseCode) {
    DkyHttpResponseCode_Unset = 0,
};

// HUD 底层实现类型
typedef NS_ENUM(NSInteger, DkyHUDUnderType) {
    DkyHUDUnderType_Unset = 0,
    DkyHUDUnderType_SVProgressHUD = 1,
    DkyHUDUnderType_MBProgressHUD = 2,
};
#endif /* GlobalEnum_h */
