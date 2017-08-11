//
//  DKYGetProductListByGroupNoModel.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYGetProductListByGroupNoModel : NSObject

@property (nonatomic, strong) NSArray * colorViewList;
@property (nonatomic, copy) NSString * imgUrl;
@property (nonatomic, copy) NSString *mDimNew14Id;
@property (nonatomic, strong) NSNumber *mProductId;
@property (nonatomic, copy) NSString * mptbelongtype;
@property (nonatomic, copy) NSString * xwValue;
@property (nonatomic, copy) NSString * ycValue;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *isYcAffix;

@property (nonatomic, strong) NSArray *xwArrayJson;

@property (nonatomic, strong) NSArray *sizeViewList;

@property (nonatomic, copy) NSArray *pzJsonstr;

@property (nonatomic, strong) NSNumber *iscollect;

// 客户端自己的属性
@property (nonatomic, assign) BOOL isCollected;

@end
