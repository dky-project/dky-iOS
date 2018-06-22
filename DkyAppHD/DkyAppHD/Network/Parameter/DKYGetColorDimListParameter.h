//
//  DKYGetColorDimListParameter.h
//  DkyAppHD
//
//  Created by HaKim on 2017/5/24.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

@interface DKYGetColorDimListParameter : DKYHttpRequestParameter

@property (nonatomic, strong) NSNumber *mProductId;

@property (nonatomic, copy) NSString *mDimNew14Id;

@property (nonatomic, copy) NSString *groupNo;

@end
