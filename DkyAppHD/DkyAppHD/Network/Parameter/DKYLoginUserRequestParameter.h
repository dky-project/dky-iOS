//
//  DKYLoginUserRequestParameter.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHttpRequestParameter.h"

// 参数：email、password

@interface DKYLoginUserRequestParameter : DKYHttpRequestParameter

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *password;

@end
