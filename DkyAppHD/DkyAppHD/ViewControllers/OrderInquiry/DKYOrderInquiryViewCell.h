//
//  DKYOrderInquiryViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DKYOrderInquiryHeaderView,DKYOrderItemModel;
@interface DKYOrderInquiryViewCell : UITableViewCell

+ (instancetype)orderInquiryViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) DKYOrderInquiryHeaderView *headerView;

@property (nonatomic, strong) DKYOrderItemModel *itemModel;

@end
