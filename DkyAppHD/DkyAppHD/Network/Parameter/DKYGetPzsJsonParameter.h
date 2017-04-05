//
//  DKYGetPzsJsonParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/4/5.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYGetPzsJsonParameter : DKYHttpRequestParameter

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, strong) NSNumber *productId;

@property (nonatomic, strong) NSNumber *mDimNew14Id;

@property (nonatomic, strong) NSNumber *mDimNew15Id;

@property (nonatomic, strong) NSNumber *mDimNew16Id;

@end
