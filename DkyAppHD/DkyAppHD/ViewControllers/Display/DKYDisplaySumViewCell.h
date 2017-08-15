//
//  DKYDisplaySumViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYDisplaySumViewCell : UITableViewCell

+ (instancetype)displaySumViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSArray *productList;

@end
