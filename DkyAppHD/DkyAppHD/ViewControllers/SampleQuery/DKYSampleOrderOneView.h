//
//  DKYSampleOrderOneView.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/2/11.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYCustomOrderItemModel;
@interface DKYSampleOrderOneView : UIView

@property (nonatomic, strong) DKYCustomOrderItemModel *itemModel;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UITextField *textField2;



@end
