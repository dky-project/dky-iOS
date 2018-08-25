//
//  DKYOrderBrowserViewCell2.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/8/11.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYOrderItemDetailModel;
@interface DKYOrderBrowserViewCell5 : UITableViewCell

+ (instancetype)orderBrowserViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYOrderItemDetailModel *itemModel;

@end
