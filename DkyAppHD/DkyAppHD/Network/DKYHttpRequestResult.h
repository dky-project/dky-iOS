//
//  DKYHttpRequestResult.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "code": 200,
//    "msg": "成功",
//    "data": [],
//    "success": true
//}

@interface DKYHttpRequestResult : NSObject

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) id data;

@property (nonatomic, assign, getter=isSuccess) BOOL success;

@property (nonatomic, strong) NSNumber *totalCount;

@property (nonatomic, copy) NSString *jgno;

@end
