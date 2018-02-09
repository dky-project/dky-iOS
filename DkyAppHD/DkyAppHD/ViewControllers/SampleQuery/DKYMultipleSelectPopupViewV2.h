//
//  DKYMultipleSelectPopupViewV2.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/2/9.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYAddProductApproveParameter;
@interface DKYMultipleSelectPopupViewV2 : UIView

+ (instancetype)show;

- (void)dismiss;

@property (nonatomic, strong) NSArray *colorViewList;

@property (nonatomic, assign) NSInteger maxSelectedNumber;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, copy) BlockWithSender confirmBtnClicked;

@property (nonatomic, copy) BlockWithSender cancelBtnClicked;

@end
