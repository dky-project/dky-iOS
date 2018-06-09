//
//  DKYDisplayCategoryDahuoViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYGetProductListByGroupNoModel;
@interface DKYDisplayCategoryDahuoViewCell : UITableViewCell

+ (instancetype)displayCategoryDahuoViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYGetProductListByGroupNoModel *getProductListByGroupNoModel;

- (void)selectStatusChanged;

@end
