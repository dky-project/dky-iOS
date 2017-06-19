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
    DkyHttpResponseCode_Success = 200,
    
    
    DkyHttpResponseCode_NotLogin = 400,
};

// HUD 底层实现类型
typedef NS_ENUM(NSInteger, DkyHUDUnderType) {
    DkyHUDUnderType_Unset = 0,
    DkyHUDUnderType_SVProgressHUD = 1,
    DkyHUDUnderType_MBProgressHUD = 2,
};

// Btn type
typedef NS_ENUM(NSInteger, DkyButtonStatusType) {
    DkyButtonStatusType_Unset = 0,
    DkyButtonStatusType_Confirm,
    DkyButtonStatusType_Done,
    
    
    DkyButtonStatusType_Cancel = 1000,
};

// DKYOrderBrowserLineView
typedef NS_ENUM(NSInteger, DkyOrderBrowserLineViewType) {
    DkyOrderBrowserLineViewType_Unset = 0,
    DkyOrderBrowserLineViewType_Both,
    DkyOrderBrowserLineViewType_Left,
    DkyOrderBrowserLineViewType_right,
    DkyOrderBrowserLineViewType_center
};

// 订单查询审核状态
typedef NS_ENUM(NSInteger, DKYOrderAuditStatusType) {
    DKYOrderAuditStatusType_Unset = 0,
    DKYOrderAuditStatusType_Auding,
    DKYOrderAuditStatusType_Success,
    DKYOrderAuditStatusType_Fail = -1,
};

// 定制订单页面，按钮枚举
typedef NS_ENUM(NSInteger, DKYCustomOrderActionsType) {
    DKYCustomOrderActionsType_Unset = 0,
    DKYCustomOrderActionsType_LastStep,
    DKYCustomOrderActionsType_Edit,
    DKYCustomOrderActionsType_Save,
    DKYCustomOrderActionsType_NextStep,
    DKYCustomOrderActionsType_ConfirmOrder,
    DKYCustomOrderActionsType_reWrite,
};

// 表格类型
typedef NS_ENUM(NSInteger, DKYFormType) {
    DKYFormType_Default = 0,
    DKYFormType_TypeOne,
    DKYFormType_TypeTwo,    // 设置表格背景色没0xf1f1f1，非这个类型，为默认的白色
};

#endif /* GlobalEnum_h */
