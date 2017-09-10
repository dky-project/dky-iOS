//
//  DKYGetProductListByGhModel.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//productName = 2644,
//imgUrl = http://60.190.63.14:90/img/2644.jpg?random=9,
//iscollect = 1,
//mProductId = 2540,
//mptbelongtype = A

@interface DKYGetProductListByGhModel : NSObject

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, strong) NSNumber *iscollect;

@property (nonatomic, strong) NSNumber *mProductId;

@property (nonatomic, copy) NSString *mptbelongtype;

// 客户端自己的属性
@property (nonatomic, assign) BOOL isCollected;

@end
