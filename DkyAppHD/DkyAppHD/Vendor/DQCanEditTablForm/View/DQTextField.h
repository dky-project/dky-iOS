//
//  DQTextField.h
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/24.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQCanEditCell.h"


@interface DQTextField : UITextField
//TableCell的下标
@property (nonatomic, strong) NSIndexPath *Cellpath;

//TextFild的父视图 cell
@property (nonatomic, strong) DQCanEditCell *DQCell;
@end
