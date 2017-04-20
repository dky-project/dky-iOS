//
//  DKYTongkuanFiveViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYProductApproveTitleModel,DKYAddProductApproveParameter,DKYMadeInfoByProductNameModel;
@interface DKYTongkuanFiveViewCell : UITableViewCell

+ (instancetype)tongkuanFiveViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitleModel;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, strong) DKYMadeInfoByProductNameModel *madeInfoByProductName;

@property (nonatomic, copy) BlockWithSender refreshBlock;

- (void)reset;
- (void)fetchAddProductApproveInfo;

@end
