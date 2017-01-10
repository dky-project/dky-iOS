//
//  DKYSampleDetailTypeViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleProductInfoModel;
@interface DKYSampleDetailTypeViewCell : UITableViewCell

+ (instancetype)sampleDetailTypeViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYSampleProductInfoModel *model;

@end
