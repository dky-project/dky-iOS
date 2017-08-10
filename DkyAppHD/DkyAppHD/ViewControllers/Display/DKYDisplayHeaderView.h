//
//  DKYDisplayHeaderView.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYGetProductListByGroupNoParameter;
@interface DKYDisplayHeaderView : UIView

@property (nonatomic, copy) BlockWithSender searchBtnClicked;

@property (nonatomic, copy) BlockWithSender preBtnClicked;

@property (nonatomic, copy) BlockWithSender nextBtnClicked;

@property (nonatomic, strong) DKYGetProductListByGroupNoParameter *getProductListByGroupNoParameter;

@end
