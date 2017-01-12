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

@end

@interface TWLineLayout : UICollectionViewFlowLayout

@end
