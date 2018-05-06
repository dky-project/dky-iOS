//
//  DKYCustomOrderItemModel.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYCustomOrderItemModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL lock;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *subText;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *placeholder2;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, assign) CGFloat textFieldLeftOffset;

@property (nonatomic, copy) BlockWithSender textFieldDidEndEditing;

@property (nonatomic, copy) BlockWithSender textFieldDidEditing;

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, assign) BOOL zoomed;

@property(nonatomic, assign) BOOL showRightView;
@property (nonatomic, copy) NSString *rightText;

@end
