//
//  DkySampleOrderImageViewCell.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/7/28.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DkySampleOrderImageViewCell : UITableViewCell

+ (instancetype)sampleOrderImageViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *imageUrl;

@end
