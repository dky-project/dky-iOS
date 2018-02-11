//
//  DKYMultipleSelectPopupView.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYAddProductApproveParameter;
@interface DKYMultipleSelectPopupView : UIView

+ (instancetype)show;

- (void)dismiss;

@property (nonatomic, strong) NSArray *clrRangeArray;

@property (nonatomic, strong) NSArray *colorViewList;

@property (nonatomic, assign) NSInteger maxSelectedNumber;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, copy) BlockWithSender confirmBtnClicked;

@property (nonatomic, copy) BlockWithSender cancelBtnClicked;

@property (nonatomic, assign) BOOL fromGroup;


@end
