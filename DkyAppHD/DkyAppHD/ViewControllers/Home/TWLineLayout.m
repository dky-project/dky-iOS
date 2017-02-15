//
//  TWLineLayout.m
//  UICollectionViewLayoutTest
//
//  Created by HaKim on 16/8/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "TWLineLayout.h"

static const CGFloat ACTIVE_DISTANCE = 0.0f; //Distance of given cell from center of visible rect

@interface TWLineLayout ()

@property (nonatomic, strong) NSArray *layoutAttributesArray;

@end

@implementation TWLineLayout

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.height - self.itemSize.height) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(inset, 0, inset, 0);
}

/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 */
/**
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    if(self.collectionView.mj_header.state != MJRefreshStateIdle){
        // 表示在上拉或者下拉的操作
        return self.layoutAttributesArray;
    }
    
    if(self.collectionView.mj_footer.state != MJRefreshStateIdle){
        // 表示在上拉或者下拉的操作
        return self.layoutAttributesArray;
    }

    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerY = self.collectionView.contentOffset.y + self.collectionView.frame.size.height * 0.5;
    
    CGFloat contentOffsetY = self.collectionView.contentOffset.y;
    CGFloat contentInsetTop = self.collectionView.contentInset.top;
    if((contentOffsetY <= -contentInsetTop && self.layoutAttributesArray.count > 0)){
        for (UICollectionViewLayoutAttributes *attrs in array) {
            CGRect visibleRect;
            visibleRect.origin = self.collectionView.contentOffset;
            visibleRect.size = self.collectionView.bounds.size;
            CGRect frame = attrs.frame;
            if (CGRectIntersectsRect(frame, rect)) {
                CGFloat visibleY = CGRectGetMidY(visibleRect);
                CGFloat centerY = attrs.center.y;
                CGFloat distance = visibleY - centerY;
                // Make sure given cell is center
//                DLog(@"distance = %@",@(distance));
                if (ABS(distance) == ACTIVE_DISTANCE) {
                    [self.mydelegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attrs.indexPath];
                }
            }
        }
        return self.layoutAttributesArray;
    }
    
    MJRefreshFooter *footer = self.collectionView.mj_footer;
    CGFloat happenOffset = 0;
    CGFloat h = footer.scrollView.frame.size.height - footer.scrollViewOriginalInset.bottom - footer.scrollViewOriginalInset.top;
    CGFloat deltaH = footer.scrollView.contentSize.height - h;
    if (deltaH > 0) {
        happenOffset = deltaH - footer.scrollViewOriginalInset.top;
    } else {
        happenOffset = - footer.scrollViewOriginalInset.top;
    }

    if(contentOffsetY >= happenOffset && self.layoutAttributesArray.count > 0){
        for (UICollectionViewLayoutAttributes *attrs in array) {
            CGRect visibleRect;
            visibleRect.origin = self.collectionView.contentOffset;
            visibleRect.size = self.collectionView.bounds.size;
            CGRect frame = attrs.frame;
            if (CGRectIntersectsRect(frame, rect)) {
                CGFloat visibleY = CGRectGetMidY(visibleRect);
                CGFloat centerY = attrs.center.y;
                CGFloat distance = visibleY - centerY;
                // Make sure given cell is center
                //                DLog(@"distance = %@",@(distance));
                if (ABS(distance) == ACTIVE_DISTANCE) {
                    [self.mydelegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attrs.indexPath];
                }
            }
        }
        return self.layoutAttributesArray;
    }
    
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attrs.center.y - centerY);
        
        // 根据间距值 计算 cell的缩放比例
        CGFloat scale = 1 - delta * 0.2 / self.collectionView.frame.size.height;
        
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        
        NSIndexPath *indexPath = attrs.indexPath;
        
        id<TWLineLayoutDelegate> cell = (id)[self.collectionView cellForItemAtIndexPath:indexPath];
        if(cell){
            if([cell respondsToSelector:@selector(setMaskViewAlpha:)]){
                [cell setMaskViewAlpha:delta * 0.2 / self.collectionView.frame.size.height];
            }
        }
        
        CGRect visibleRect;
        visibleRect.origin = self.collectionView.contentOffset;
        visibleRect.size = self.collectionView.bounds.size;
        CGRect frame = attrs.frame;
        if (CGRectIntersectsRect(frame, rect)) {
            CGFloat visibleY = CGRectGetMidY(visibleRect);
            CGFloat centerY = attrs.center.y;
            CGFloat distance = visibleY - centerY;
            // Make sure given cell is center
//            DLog(@"distance = %@",@(distance));
            if (ABS(distance) == ACTIVE_DISTANCE) {
                [self.mydelegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attrs.indexPath];
            }
        }
    }
    self.layoutAttributesArray = array;
    return array;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = proposedContentOffset.y;
    rect.origin.x = 0;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerY = proposedContentOffset.y + self.collectionView.frame.size.height * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    UICollectionViewLayoutAttributes *centerAttr = nil;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.y - centerY)) {
            minDelta = attrs.center.y - centerY;
            centerAttr = attrs;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.y += minDelta;
    return proposedContentOffset;
}


@end
