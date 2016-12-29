//
//  DKYHttpRequestResult.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYHttpRequestResult : NSObject

@property (nonatomic, strong) NSNumber *retCode;

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSNumber *totalCount;

@end
