//
//  DKYOrderInfoHeaderView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYOrderInfoHeaderView : UIView

+ (instancetype)orderInfoHeaderViewWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceOfSampleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;

@property (nonatomic, weak) UILabel *orderAmountLabel;
@property (nonatomic, weak) UILabel *countLabel;

//@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
//@property (weak, nonatomic) IBOutlet UILabel *clientLabel;
//@property (weak, nonatomic) IBOutlet UILabel *faxDateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

@property (nonatomic, copy) BlockWithSenderAndBOOL taped;

@end
