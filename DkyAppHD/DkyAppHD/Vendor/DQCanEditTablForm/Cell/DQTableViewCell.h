//
//  DQTableViewCell.h
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQTableViewCell : UITableViewCell

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

//表格的数据源
@property (nonatomic, strong) NSMutableArray *DataArr;

//表格的组数
@property (nonatomic, assign) NSInteger TotalSection;

@property (nonatomic, assign) BOOL hideBottomLine;
@end
