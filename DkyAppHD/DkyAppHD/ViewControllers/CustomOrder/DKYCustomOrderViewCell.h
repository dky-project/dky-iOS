//
//  DKYCustomOrderViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYProductApproveTitleModel;
@interface DKYCustomOrderViewCell : UITableViewCell

+ (instancetype)customOrderViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) BlockWithSenderAndType optionsBtnClicked;

@property (nonatomic, strong) DKYProductApproveTitleModel *productApproveTitleModel;

- (void)reset;

@property (nonatomic, copy) BlockWithSender refreshBlock;

@end
