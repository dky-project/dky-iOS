//
//  DKYOrderInqueySearchColorPopupView.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/16.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYOrderInqueySearchColorPopupView : UIView

+ (instancetype)show;

- (void)dismiss;

@property (nonatomic, copy) NSArray *dataArray;

@end
