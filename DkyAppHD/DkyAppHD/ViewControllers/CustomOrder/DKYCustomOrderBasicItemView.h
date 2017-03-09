//
//  DKYCustomOrderBasicItemView.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYCustomOrderItemModel.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYTitleSelectView.h"
#import "DKYTitleInputView.h"
#import "DKYCustomOrderDimList.h"
#import "DKYDimlistItemModel.h"
#import "DKYMadeInfoByProductNameModel.h"

@interface DKYCustomOrderBasicItemView : UIView

@property (nonatomic, strong) DKYCustomOrderItemModel *itemModel;

@property (nonatomic, strong) DKYCustomOrderDimList *customOrderDimList;

@property (nonatomic, strong) DKYMadeInfoByProductNameModel *madeInfoByProductName;

@property (nonatomic, assign) BOOL canEdit;

- (void)clear;

@end
