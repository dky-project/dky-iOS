//
//  DKYHomeItemView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/6.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYHomeItemDelegate.h"

@class DKYHomeArticleModel;
@interface DKYHomeItemView : UIView

+ (instancetype)homeItemView;

@property (nonatomic, strong) DKYHomeArticleModel *itemModel;

@end
