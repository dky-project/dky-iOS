//
//  DKYCustomOrderBusinessCell.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYProductApproveTitleModel,DKYAddProductApproveParameter;
@interface DKYCustomOrderBusinessCell : UITableViewCell

+ (instancetype)customOrderBusinessCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitleModel;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@end
