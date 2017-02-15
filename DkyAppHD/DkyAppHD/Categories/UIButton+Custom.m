//
//  UIButton+Custom.m
//  DycApp
//
//  Created by HaKim on 15/12/24.
//  Copyright © 2015年 haKim. All rights reserved.
//

#import "UIButton+Custom.h"
#import "UIImage+Color.h"

@implementation UIButton (Custom)

- (void)customButtonWithType:(UIButtonCustomType)type
{
    UIImage *imageN = nil;
    UIImage *imageH = nil;
    UIImage *imageD = nil;

    switch (type) {
        case UIButtonCustomType_One:
            imageN = [UIImage imageWithColor:[UIColor colorWithHex:0xfe5722]];
            imageH = [UIImage imageWithColor:[UIColor colorWithHex:0xe74a18]];
            imageD = [UIImage imageWithColor:[UIColor colorWithHex:0xc8c7cc]];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self setTitleColor:[UIColor colorWithHex:0xeff0f1] forState:UIControlStateDisabled];
            [self setBackgroundImage:imageD forState:UIControlStateDisabled];
            break;
        case UIButtonCustomType_Two:
            imageN = [UIImage imageWithColor:[UIColor colorWithHex:0x3f569a]];
            imageH = [UIImage imageWithColor:[UIColor colorWithHex:0x1f3b8e]];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithHex:0xffa487] forState:UIControlStateDisabled];
            //imageD = [UIImage imageWithColor:[UIColor colorWithHex:0xc8c7cc]];
            break;
        case UIButtonCustomType_Three:
            imageN = [UIImage imageWithColor:[UIColor colorWithHex:0xffffff]];
            imageH = [UIImage imageWithColor:[UIColor colorWithHex:0xbdbdbd]];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor colorWithHex:0xffa487] forState:UIControlStateDisabled];
//            imageD = [UIImage imageWithColor:[UIColor colorWithHex:0xbdbdbd]];
            break;
        case UIButtonCustomType_Four:
            imageN = [UIImage imageWithColor:[UIColor colorWithHex:0xfeffff]];
            imageH = [UIImage imageWithColor:[UIColor colorWithHex:0xfe5722]];
            [self setTitleColor:[UIColor colorWithHex:0xfe5722] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        case UIButtonCustomType_Five:
            imageD = [UIImage imageWithColor:[UIColor colorWithHex:0xc8c7cc]];
            [self setBackgroundImage:imageD forState:UIControlStateDisabled];
            [self setTitleColor:[UIColor colorWithHex:0xeff0f1] forState:UIControlStateDisabled];
            break;
        default:
            break;
    }
    self.adjustsImageWhenDisabled = NO;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10.0;
    [self setBackgroundImage:imageN forState:UIControlStateNormal];
    [self setBackgroundImage:imageH forState:UIControlStateHighlighted];
    
    self.titleLabel.font = [UIFont systemFontOfSize:18];
}

+ (instancetype)buttonWithCustomType:(UIButtonCustomType)type{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    switch (type) {
        case UIButtonCustomType_Six:
            [btn setTitleColor:[UIColor colorWithHex:0x251E1D] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.layer.borderWidth = 1.0;
            btn.layer.borderColor = [UIColor colorWithHex:0x686868].CGColor;
            break;
        case UIButtonCustomType_Seven:
            [btn setTitleColor:[UIColor colorWithHex:0x251E1D] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.layer.borderWidth = 1.0;
            btn.layer.borderColor = [UIColor colorWithHex:0x333333].CGColor;
            break;
        default:
            break;
    }
    return btn;
}

@end
