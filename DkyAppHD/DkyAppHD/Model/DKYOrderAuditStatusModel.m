//
//  DKYOrderAuditStatusModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderAuditStatusModel.h"

@implementation DKYOrderAuditStatusModel

+ (instancetype)orderAuditStatusModelMakeWithName:(NSString*)name code:(DKYOrderAuditStatusType)code{
    DKYOrderAuditStatusModel *model = [[DKYOrderAuditStatusModel alloc] init];
    model.statusName = name;
    model.statusCode = code;
    return model;
}

@end
