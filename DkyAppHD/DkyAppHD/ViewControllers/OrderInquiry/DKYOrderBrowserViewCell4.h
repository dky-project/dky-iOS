//
//  DKYOrderBrowserViewCell4.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/8/24.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYOrderItemDetailModel;
@interface DKYOrderBrowserViewCell4 : UITableViewCell

+ (instancetype)orderBrowserViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYOrderItemDetailModel *itemModel;

@end
