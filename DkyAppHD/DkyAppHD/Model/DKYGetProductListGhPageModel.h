//
//  DKYGetProductListGhPageModel.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYGetProductListGhPageModel : NSObject

@property (nonatomic, copy) NSString * clImgUrl;
@property (nonatomic, copy) NSString * gh;
@property (nonatomic, copy) NSString * modifieddate;

@property (nonatomic, strong) NSNumber *no1ProductId;
@property (nonatomic, strong) NSNumber *no2ProductId;
@property (nonatomic, strong) NSNumber *no3ProductId;
@property (nonatomic, strong) NSNumber *no4ProductId;
@property (nonatomic, strong) NSNumber *no5ProductId;
@property (nonatomic, strong) NSNumber *no6ProductId;

@property (nonatomic, copy) NSString *hallName;

@end
