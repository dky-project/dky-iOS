//
//  DKYSampleDetailTypeViewCell2.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/8/26.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleProductInfoModel;
@interface DKYSampleDetailTypeViewCell2 : UITableViewCell

+ (instancetype)sampleDetailTypeViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYSampleProductInfoModel *model;

@end
