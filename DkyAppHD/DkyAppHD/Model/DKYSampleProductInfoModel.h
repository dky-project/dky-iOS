//
//  DKYSampleProductInfoModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYSampleProductInfoModel : NSObject

@property (nonatomic, strong) NSArray *imgList;
@property (nonatomic, copy) NSString * mDimNew11Text;
@property (nonatomic, copy) NSString * mDimNew13Text;
@property (nonatomic, copy) NSString * mptbelongtypeText;
@property (nonatomic, copy) NSString * name;

// 温馨提示
@property (nonatomic, copy) NSString *description3;

// 设计说明
@property (nonatomic, copy) NSString *description5;

@end
