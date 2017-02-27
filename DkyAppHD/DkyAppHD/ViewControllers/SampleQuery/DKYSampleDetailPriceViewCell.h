//
//  DKYSampleDetailPriceViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/27.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleProductInfoModel;
@interface DKYSampleDetailPriceViewCell : UITableViewCell

+ (instancetype)sampleDetailPriceViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYSampleProductInfoModel *sampleProductInfo;

@end
