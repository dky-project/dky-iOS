//
//  DKYPageModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    totalPageNum = 0,
//    items = [
//    ],
//    pageSize = 10,
//    total = 0,
//    pageNo = 1
//}

@interface DKYPageModel : NSObject

@property (nonatomic, strong) NSArray * items;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger totalPageNum;

@property (nonatomic, copy) NSArray *groupNoList;
@property (nonatomic, copy) NSArray *ghList;

@end
