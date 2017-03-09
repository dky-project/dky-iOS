//
//  DKYTextFieldAndTextFieldView.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYCustomOrderItemModel;
@interface DKYTextFieldAndTextFieldView : UIView

@property (nonatomic, strong) DKYCustomOrderItemModel *itemModel;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UITextField *textFieldTwo;

@end
