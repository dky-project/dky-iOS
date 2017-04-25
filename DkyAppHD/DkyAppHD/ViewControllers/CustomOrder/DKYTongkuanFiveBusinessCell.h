//
//  DKYTongkuanFiveBusinessCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/4/25.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYProductApproveTitleModel,DKYAddProductApproveParameter;
@interface DKYTongkuanFiveBusinessCell : UITableViewCell

+ (instancetype)customOrderBusinessCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitleModel;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@end
