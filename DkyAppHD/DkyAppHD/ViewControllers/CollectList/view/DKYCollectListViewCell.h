//
//  DKYCollectListViewCell.h
//  DkyAppHD
//
//  Created by HaKim on 2017/5/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYSampleModel;
@interface DKYCollectListViewCell : UICollectionViewCell

@property (nonatomic, strong) DKYSampleModel *itemModel;

@property (nonatomic, copy) BlockWithSenderAndModel cancelBtnClicekd;

@end
