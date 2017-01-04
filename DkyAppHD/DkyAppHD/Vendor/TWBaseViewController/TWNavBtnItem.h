//
//  TWNavBtnItem.h
//  TWBaseViewController
//
//  Created by HaKim on 16/2/22.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TWNavBtnItemType) {
    TWNavBtnItemType_Unset = -1,
    TWNavBtnItemType_Image,  // 返回的image <
    TWNavBtnItemType_Text,   // 文字
    TWNavBtnItemType_ImageAndText,  // 文字和image
};

@interface TWNavBtnItem : NSObject

// 按钮类型
@property (nonatomic, assign) TWNavBtnItemType itemType;

// 整一个button x的坐标
@property (nonatomic, assign) CGFloat offetX;

// 如果有文字，文字距离image的偏移
@property (nonatomic, assign) CGFloat titleOffsetX;

// 按钮的图片
// normal 状态下的图片
@property (nonatomic, strong) UIImage *normalImage;

// 高亮状态下的图片
@property (nonatomic, strong) UIImage *hilightedImage;

// 文字状态设置,字体，颜色
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *normalTitleColor;

@property (nonatomic, strong) UIColor *hilightedTitleColor;

@property (nonatomic, assign) CGSize size;

@end


