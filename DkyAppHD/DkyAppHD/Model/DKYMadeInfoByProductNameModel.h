//
//  DKYMadeInfoByProductName.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKYDahuoOrderColorModel.h"
#import "DKYDahuoOrderSizeModel.h"
#import "DKYProductMadeInfoViewModel.h"
#import "DKYProductCusmptcateViewModel.h"

@interface DKYMadeInfoByProductNameModel : NSObject

// 大货订单时候用的action sheet 数组
@property (nonatomic, strong) NSArray *colorViewList;

@property (nonatomic, strong) NSArray *sizeViewList;

@property (nonatomic, strong) DKYProductMadeInfoViewModel *productMadeInfoView;

@property (nonatomic, strong) DKYProductCusmptcateViewModel *productCusmptcateView;
// 客户端自己的属性
@property (nonatomic, assign, getter=isBigOrder) BOOL bigOrder;

@end
