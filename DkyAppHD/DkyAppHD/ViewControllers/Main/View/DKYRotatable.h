//
//  DKYRotatable.h
//  DkyAppHD
//
//  Created by HaKim on 16/12/30.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DKYRotatable <NSObject>

@optional
/**
 *  旋转
 *
 *  @param landscape 是否为横屏
 */
- (void)rotate:(BOOL)landscape;

@end
