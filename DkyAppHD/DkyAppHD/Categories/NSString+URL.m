//
//  NSString+URL.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

+ (NSString *)addQueryParametersUrl:(NSString *)urlStr parameters:(NSDictionary *)params{
    if(![urlStr isNotBlank]) return urlStr;
    
    if(params.count == 0) return urlStr;
    
    
    
    NSString *query = AFQueryStringFromParameters(params);
    
    if (query && query.length > 0) {
        NSURL *url = [NSURL URLWithString:urlStr];
        NSString *urlWithQuery = [[url absoluteString] stringByAppendingFormat:url.query ? @"&%@" : @"?%@", query];
        return urlWithQuery;
    }
    
    return urlStr;
}

@end
