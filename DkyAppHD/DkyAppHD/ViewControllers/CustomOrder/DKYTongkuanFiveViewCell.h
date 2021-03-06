//
//  DKYTongkuanFiveViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/5/18.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKYMadeInfoByProductNameModel.h"

@class DKYProductApproveTitleModel,DKYAddProductApproveParameter,DKYMadeInfoByProductNameModel;

@interface DKYTongkuanFiveViewCell : UITableViewCell

+ (instancetype)tongkuanFiveViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) BlockWithSenderAndType optionsBtnClicked;

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitleModel;

@property (nonatomic, strong) DKYAddProductApproveParameter *addProductApproveParameter;

@property (nonatomic, strong) DKYMadeInfoByProductNameModel *madeInfoByProductName;

- (void)reset;
- (void)fetchAddProductApproveInfo;

@property (nonatomic, copy) BlockWithSender refreshBlock;

@end
