//
//  DKYOrderAuditStatusModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYOrderAuditStatusModel : NSObject

+ (instancetype)orderAuditStatusModelMakeWithName:(NSString*)name code:(DKYOrderAuditStatusType)code;

@property (nonatomic, copy) NSString *statusName;

@property (nonatomic, assign) DKYOrderAuditStatusType statusCode;

@end
