//
//  DKYOrderInquiryHeaderView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYOrderInfoHeaderView.h"

@interface DKYOrderInquiryHeaderView : UIView

+ (instancetype)orderInquiryHeaderView;

@property (nonatomic, copy) BlockWithSender faxDateBlock;

@property (nonatomic, copy) BlockWithSender auditStatusBlock;

@property (weak, nonatomic) IBOutlet UITextField *sampleTextField;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *batchPreviewBtn;
@property (weak, nonatomic) IBOutlet UILabel *faxDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *auditStatusLabel;
@property (weak, nonatomic) IBOutlet DKYOrderInfoHeaderView *bottomHeaderView;

@end
