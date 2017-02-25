//
//  DKYTitleInputView.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYCustomOrderItemModel;
@interface DKYTitleInputView : UIView

@property (nonatomic, strong) DKYCustomOrderItemModel *itemModel;

@property (nonatomic, weak) UITextField *textField;

@end
