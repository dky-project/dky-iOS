//
//  DKYCustomOrderTextFieldView.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYCustomOrderItemModel;
@interface DKYCustomOrderTextFieldView : UIView

@property (nonatomic, strong) DKYCustomOrderItemModel *itemModel;

- (void)clear;

@end
