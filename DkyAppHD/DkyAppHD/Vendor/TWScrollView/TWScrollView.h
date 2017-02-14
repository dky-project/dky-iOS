//
//  TWScrollView.h
//  TWScrollView
//
//  Created by HaKim on 16/2/26.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TWScrollViewType) {
    TWScrollViewType_Unset = 0,
    TWScrollViewType_Horizontal,  // 横向滑动
    TWScrollViewType_Vertical,    // 垂直滑动
};

@interface TWScrollView : UIScrollView

@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, assign) TWScrollViewType scrollViewType;

@end
