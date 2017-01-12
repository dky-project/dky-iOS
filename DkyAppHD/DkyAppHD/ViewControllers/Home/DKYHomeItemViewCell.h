//
//  DKYHomeItemViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/12.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYHomeArticleModel;
@interface DKYHomeItemViewCell: UICollectionViewCell

@property (nonatomic, strong) DKYHomeArticleModel *itemModel;

- (void)hideReadMoreBtn:(BOOL)hide;

@end
