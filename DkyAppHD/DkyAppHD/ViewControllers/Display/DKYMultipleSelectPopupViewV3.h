//
//  DKYMultipleSelectPopupViewV3.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/5/3.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYAddDpGroupApproveParamModel;

@interface DKYMultipleSelectPopupViewV3 : UIView

+ (instancetype)show;

- (void)dismiss;

@property (nonatomic, strong) NSArray *colorViewList;

@property (nonatomic, assign) NSInteger maxSelectedNumber;

@property (nonatomic, strong) DKYAddDpGroupApproveParamModel *addDpGroupApproveParam;

@property (nonatomic, copy) BlockWithSender confirmBtnClicked;

@property (nonatomic, copy) BlockWithSender cancelBtnClicked;

@end
