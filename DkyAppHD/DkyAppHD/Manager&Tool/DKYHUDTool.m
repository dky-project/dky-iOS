//
//  DKYHUDTool.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHUDTool.h"

@implementation DKYHUDTool

+ (instancetype)HUDTool{
    return [[DKYHUDTool alloc] init];
}

+ (void)show{
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString*)status{
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

@end
