//
//  DKYDisplayImageViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKYDisplayImageViewCell : UITableViewCell

+ (instancetype)displayImageViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NSArray *productList;

@property (nonatomic, copy) NSString *bigImageUrl;

@property (nonatomic, copy) NSString *groupNo;

@end
