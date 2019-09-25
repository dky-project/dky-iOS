//
//  FabricCollectionViewCell.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2019/9/18.
//  Copyright © 2019 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DKYProductImgModel;
@interface FabricCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) DKYProductImgModel *imgModel;

@end

NS_ASSUME_NONNULL_END
