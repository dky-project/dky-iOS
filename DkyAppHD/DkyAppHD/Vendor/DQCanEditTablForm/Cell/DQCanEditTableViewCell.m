//
//  DQCanEditTableViewCell.m
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQCanEditTableViewCell.h"
#import "DQFormCollectionView.h"
#import "DQCanEditCell.h"

static NSString *DQCanCellID = @"DQCanCellID";

@interface DQCanEditTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DQCanEditCellDelegate>

@property (nonatomic, strong) NSIndexPath *TotalPath;

@end
@implementation DQCanEditTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self DQAddSubViewFunction];
    }
    return self;
}

- (void)DQAddSubViewFunction{
    UIView *sub = self.contentView;
    self.DQCollectionView = [[DQFormCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    [sub addSubview:self.DQCollectionView];
    
    [self.DQCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub.mas_left).offset(10);
        make.right.equalTo(sub.mas_right).offset(-10);
        make.top.equalTo(sub.mas_top).offset(15);
        make.bottom.equalTo(sub.mas_bottom).offset(-15);
    }];
    self.DQCollectionView.scrollsToTop = NO;
    self.DQCollectionView.alwaysBounceVertical = NO;
    self.DQCollectionView.dataSource = self;
    self.DQCollectionView.delegate = self;
    [self.DQCollectionView registerClass:[DQCanEditCell class] forCellWithReuseIdentifier:DQCanCellID];
    
}
-(void)setDataArr:(NSMutableArray *)DataArr{
    _DataArr = DataArr;
    NSArray *arr = [_DataArr firstObject];
    _TotalSection = _DataArr.count;
    if (!arr.count||!_DataArr.count) {
        return;
    }
    self.TotalPath = [NSIndexPath indexPathForRow:arr.count-1 inSection:self.TotalSection-1];
    [self.DQCollectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return _TotalSection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.DataArr[section];
    return arr.count;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DQCanEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DQCanCellID forIndexPath:indexPath];
    cell.cellPath = self.CellPath;
    NSArray *arr = self.DataArr[indexPath.section];
    cell.currentStr = [arr objectAtIndex:indexPath.row];
    cell.delegate = self;
    //[cell setDataFunction:indexPath andTotalPath:self.TotalPath andTitle:arr[indexPath.row]];
    [cell DQEditSetDataFunction:indexPath andTotalPath:self.TotalPath andTitle:arr[indexPath.row]];
    return cell;
}
- (void)changeDataFromIndexpath:(NSIndexPath *)path andTitle:(NSString *)title{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.DataArr objectAtIndex:path.section]];
    [arr replaceObjectAtIndex:path.row withObject:title];
    [self.DataArr replaceObjectAtIndex:path.section withObject:arr];

}
@end
