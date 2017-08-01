//
//  DKYDahuoOrderInquiryHeaderView.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYDahuoOrderInfoHeaderView.h"

@interface DKYDahuoOrderInquiryHeaderView : UIView

+ (instancetype)orderInquiryHeaderView;

@property (nonatomic, copy) BlockWithSender faxDateBlock;

@property (nonatomic, copy) BlockWithSender auditStatusBlock;

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
@property (weak, nonatomic) IBOutlet DKYDahuoOrderInfoHeaderView *bottomHeaderView;
@property (weak, nonatomic) IBOutlet DKYDahuoOrderInfoHeaderView *headerView;

@end
