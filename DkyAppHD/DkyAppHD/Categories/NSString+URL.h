//
//  NSString+URL.h
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

+ (NSString *)addQueryParametersUrl:(NSString *)urlStr parameters:(NSDictionary *)params;

@end
