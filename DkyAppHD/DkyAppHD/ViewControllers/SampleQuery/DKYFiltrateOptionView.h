//
//  DKYFiltrateOptionView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYFiltrateOptionView : UIView

@property (nonatomic, copy) NSString *selectedOption;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) BlockWithSender optionViewTaped;

@end
