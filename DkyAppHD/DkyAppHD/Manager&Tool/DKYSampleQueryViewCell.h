//
//  DKYSampleQueryViewCell.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleModel;
@interface DKYSampleQueryViewCell : UICollectionViewCell

@property (nonatomic, strong) DKYSampleModel *itemModel;

@property (nonatomic, copy) BlockWithSenderAndModel collectBtnClicekd;

@end
