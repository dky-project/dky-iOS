//
//  DKYSampleOrderViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleProductInfoModel,DKYProductApproveTitleModel,DKYAddProductApproveParameter;
@interface DKYSampleOrderViewCell : UITableViewCell

+ (instancetype)sampleOrderViewCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)DKYSampleProductInfoModel *sampleProductInfo;

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitleModel;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, copy) BlockWithSender imageBlock;

@end
