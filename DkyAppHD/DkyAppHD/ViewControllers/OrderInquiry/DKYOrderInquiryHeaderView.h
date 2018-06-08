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

@property (nonatomic, copy) BlockWithSender sourceBlock;

@property (nonatomic, copy) BlockWithSender sizeBlock;

@property (nonatomic, copy) BlockWithSender batchPreviewBtnClicked;

@property (nonatomic, copy) BlockWithSender findBtnClicked;

@property (nonatomic, copy) BlockWithSender deleteBtnClicked;

@property (weak, nonatomic) IBOutlet UITextField *sampleTextField;
@property (weak, nonatomic) IBOutlet UITextField *clientTextField;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *batchPreviewBtn;
@property (weak, nonatomic) IBOutlet UILabel *faxDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *auditStatusLabel;
@property (weak, nonatomic) IBOutlet UITextField *sizeTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@property (weak, nonatomic) IBOutlet DKYOrderInfoHeaderView *bottomHeaderView;
@property (weak, nonatomic) IBOutlet DKYOrderInfoHeaderView *headerView;

@end
