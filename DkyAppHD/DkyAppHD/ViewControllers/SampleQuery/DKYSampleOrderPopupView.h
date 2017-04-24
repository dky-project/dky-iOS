//
//  DKYSampleOrderPopupView.h
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleProductInfoModel;
@interface DKYSampleOrderPopupView : UIView

+ (instancetype)show;

+ (instancetype)showWithSampleProductInfoModel:(DKYSampleProductInfoModel *)sampleProductInfo;

- (void)dismiss;

@property(nonatomic,strong)DKYSampleProductInfoModel *sampleProductInfo;

@end
