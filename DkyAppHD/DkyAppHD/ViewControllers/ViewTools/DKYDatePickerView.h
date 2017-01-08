//
//  DKYDatePickerView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "MMPopupView.h"

@interface DKYDatePickerView : MMPopupView

@property (nonatomic, strong) NSDate *selectedDate;

@property (nonatomic, copy) BlockWithSenderAndType doneBlock;

@end
