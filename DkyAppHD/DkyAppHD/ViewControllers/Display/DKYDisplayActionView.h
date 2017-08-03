//
//  DKYDisplayActionView.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYDisplayActionView : UIView

+ (instancetype)displayActionViewView;

@property (nonatomic, copy) BlockWithSender confirmBtnClicked;

@property (nonatomic, copy) BlockWithSender saveBtnClicked;

@end
