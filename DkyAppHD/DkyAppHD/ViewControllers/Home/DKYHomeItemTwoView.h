//
//  DKYHomeItemTwoView.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/7.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYHomeItemDelegate.h"

@class DKYHomeArticleModel;
@interface DKYHomeItemTwoView : UIView

+ (instancetype)homeItemTwoView;

@property (nonatomic, strong) DKYHomeArticleModel *itemModel;

@end
