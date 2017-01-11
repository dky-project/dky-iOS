//
//  DKYOrderBrowserViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DKYOrderItemDetailModel;
@interface DKYOrderBrowserViewCell : UITableViewCell

+ (instancetype)orderBrowserViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYOrderItemDetailModel *itemModel;

@end
