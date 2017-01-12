//
//  TWLineLayout.h
//  UICollectionViewLayoutTest
//
//  Created by HaKim on 16/8/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TWLineLayoutDelegate <NSObject>

@optional
- (void)setMaskViewAlpha:(CGFloat)alpha;

- (void)hideReadMoreBtn:(BOOL)hide;

/** Informs delegate about location of centered cell in grid.
 *  Delegate should use this location 'indexPath' information to
 *   adjust it's conten associated with this cell.
 *   @param indexPath of cell in collection view which is centered.
 */

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface TWLineLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<TWLineLayoutDelegate> mydelegate;
@end
