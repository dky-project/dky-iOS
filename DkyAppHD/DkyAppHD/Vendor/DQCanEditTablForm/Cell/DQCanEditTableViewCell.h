//
//  DQCanEditTableViewCell.h
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DQFormCollectionView;

@interface DQCanEditTableViewCell : UITableViewCell

@property (nonatomic, strong) DQFormCollectionView *DQCollectionView;

@property (nonatomic, strong) NSMutableArray *DataArr;

@property (nonatomic, assign) NSInteger TotalSection;

@property (nonatomic, strong) NSIndexPath *CellPath;

@end
