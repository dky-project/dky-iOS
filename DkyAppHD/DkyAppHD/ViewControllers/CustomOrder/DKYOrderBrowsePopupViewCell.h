//
//  DKYOrderBrowsePopupViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/5/15.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYOrderBrowseModel;
@interface DKYOrderBrowsePopupViewCell : UITableViewCell

+ (instancetype)orderBrowserViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYOrderBrowseModel *orderBrowseModel;

@end
