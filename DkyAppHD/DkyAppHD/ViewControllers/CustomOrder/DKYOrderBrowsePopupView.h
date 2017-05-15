//
//  DKYOrderBrowsePopupView.h
//  DkyAppHD
//
//  Created by HaKim on 2017/5/15.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYOrderBrowseModel;
@interface DKYOrderBrowsePopupView : UIView

+ (instancetype)show;

+ (instancetype)showWithcreateOrderBtnBlock:(BlockWithSender)createOrderBtnClicked cancelBtnBlock:(BlockWithSender)cancelBtnClicked;

- (void)dismiss;

@property (nonatomic, copy) BlockWithSender createOrderBtnClicked;

@property (nonatomic, copy) BlockWithSender cancelBtnClicked;

@property (nonatomic, strong) DKYOrderBrowseModel *orderBrowseModel;

@end
