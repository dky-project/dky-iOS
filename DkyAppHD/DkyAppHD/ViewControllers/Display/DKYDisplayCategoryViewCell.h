//
//  DKYDisplayCategoryViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYGetProductListByGroupNoModel;
@interface DKYDisplayCategoryViewCell : UITableViewCell

+ (instancetype)displayCategoryViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYGetProductListByGroupNoModel *getProductListByGroupNoModel;

@property (nonatomic, copy) BlockWithSender amountTextFieldChanged;

@end
