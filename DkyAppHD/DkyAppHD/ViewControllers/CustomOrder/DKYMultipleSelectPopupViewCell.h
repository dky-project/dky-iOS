//
//  DKYMultipleSelectPopupViewCell.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYDahuoOrderColorModel.h"

@class DKYMultipleSelectPopupItemModel;
@interface DKYMultipleSelectPopupViewCell : UITableViewCell

+ (instancetype)multipleSelectPopupViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYDahuoOrderColorModel *itemModel;

@property (nonatomic, copy) BlockWithSender cancelBtnClicked;

@end
