//
//  DKYRecommendHeaderView.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYRecommendHeaderView : UIView

@property (nonatomic, copy) BlockWithSender preBtnClicked;

@property (nonatomic, copy) BlockWithSender nextBtnClicked;


- (void)clear;

@end
