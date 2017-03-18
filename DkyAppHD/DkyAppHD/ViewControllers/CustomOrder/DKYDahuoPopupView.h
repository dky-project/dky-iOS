//
//  DKYDahuoPopupView.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYMadeInfoByProductNameModel,DKYMptApproveSaveParameter;
@interface DKYDahuoPopupView : UIView

+ (instancetype)show;

- (void)dismiss;

@property (nonatomic, copy) BlockWithSender cancelBtnClicked;

@property (nonatomic, copy) BlockWithSender confirmBtnClicked;

@property (nonatomic, strong) DKYMadeInfoByProductNameModel *madeInfoByProductNameModel;

@property (nonatomic, strong) DKYMptApproveSaveParameter *mptApproveSaveParameter;

@end
