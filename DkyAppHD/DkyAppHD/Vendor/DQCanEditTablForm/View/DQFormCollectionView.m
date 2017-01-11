//
//  DQFormCollectionView.m
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQFormCollectionView.h"

const CGFloat CellHegiht = 30.0f;//cell的高度
const CGFloat CellWidth = 45.0f;//cell的宽度

@interface DQFormCollectionView ()


@end
@implementation DQFormCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    UICollectionViewFlowLayout *DQlaoyout = [UICollectionViewFlowLayout new];
    DQlaoyout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    DQlaoyout.minimumLineSpacing = 0.0f;
    DQlaoyout.minimumInteritemSpacing = 0.0f;
    DQlaoyout.itemSize = CGSizeMake(CellWidth, CellHegiht);
//    DQlaoyout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    self = [super initWithFrame:frame collectionViewLayout:DQlaoyout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        
    }

    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(CellWidth, CellHegiht);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}

@end
