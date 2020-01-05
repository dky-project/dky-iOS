//
//  DKYSampleDiscountItemView.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2020/1/5.
//  Copyright © 2020 haKim. All rights reserved.
//

#import "DKYCustomOrderBasicItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKYSampleDiscountItemView : DKYCustomOrderBasicItemView

@property (nonatomic, copy) BlockWithSenderAndType approve_type2Block;

@property (nonatomic, copy) NSArray *discountArray;

@end

NS_ASSUME_NONNULL_END
