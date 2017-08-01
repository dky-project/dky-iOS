//
//  DKYDahuoOrderInfoHeaderView.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYDahuoOrderInfoHeaderView : UIView

+ (instancetype)orderInfoHeaderViewWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;

// 序号
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

// 图片
@property (nonatomic, weak) UILabel *pictureLabel;

// 款号
@property (weak, nonatomic) IBOutlet UILabel *sourceOfSampleLabel;

// 尺寸
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

// 颜色
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;

// 金额
@property (nonatomic, weak) UILabel *orderAmountLabel;

// 数量
@property (nonatomic, weak) UILabel *countLabel;

@property (nonatomic, copy) BlockWithSenderAndBOOL taped;

@end
