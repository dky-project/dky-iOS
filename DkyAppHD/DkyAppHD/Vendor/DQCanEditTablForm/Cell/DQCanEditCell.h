//
//  DQCanEditCell.h
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/24.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQFormCollectionViewCell.h"

@class DQTextField;
@protocol DQCanEditCellDelegate <NSObject>

//TextFild的内容发生改变的代理方法
- (void)changeDataFromIndexpath:(NSIndexPath *)path andTitle:(NSString *)title;

@end

@interface DQCanEditCell : DQFormCollectionViewCell

@property (nonatomic, weak) id <DQCanEditCellDelegate> delegate;

- (void)DQEditSetDataFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title;
@property (nonatomic, strong) NSIndexPath *cellPath;
@property (nonatomic, strong) DQTextField *DQTextFd;
/** 保存TextFild的输入的内容 */
@property (nonatomic, strong) NSString *currentStr;
@end
