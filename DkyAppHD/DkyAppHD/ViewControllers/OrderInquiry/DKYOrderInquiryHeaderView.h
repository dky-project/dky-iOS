//
//  DKYOrderInquiryHeaderView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYOrderInquiryHeaderView : UIView

+ (instancetype)orderInquiryHeaderView;

@property (nonatomic, copy) BlockWithSender faxDateBlock;

@property (nonatomic, copy) BlockWithSender auditStatusBlock;

@end
