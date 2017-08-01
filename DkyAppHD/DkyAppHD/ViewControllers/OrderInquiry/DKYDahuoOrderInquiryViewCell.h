//
//  DKYDahuoOrderInquiryViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYDahuoOrderInquiryHeaderView,DKYOrderItemModel;
@interface DKYDahuoOrderInquiryViewCell : UITableViewCell

+ (instancetype)orderInquiryViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) DKYDahuoOrderInquiryHeaderView *headerView;

@property (nonatomic, strong) DKYOrderItemModel *itemModel;

@end
