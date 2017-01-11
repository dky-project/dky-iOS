//
//  NSString+Utility.m
//  DjdApp
//
//  Created by HaKim on 16/5/18.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "NSString+Utility.h"


@implementation NSString (Utility)


- (BOOL)isNilOrEmpty{
    return (self == nil || self.length == 0) ? YES : NO;
}

- (BOOL)isEmptyString
{
    if (self == (NSString *)[NSNull null] || [self isEqual:[NSNull null]] || [self isEqual:@""])
    {
        return YES;
    }
    else if([self length] == 0)
    {
        return YES;
    }
    // 去除字符串前后的空格
    else if([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}

//格式化年化收益
+(NSString *)formatRateStringWithRate:(CGFloat)rate
{
    NSString *rateStr = [NSString stringWithFormat:@"%.2f",rate];
    NSRange range = [rateStr rangeOfString:@"."];
    NSInteger location = range.location;
    if(location != NSNotFound)
    {
        while (rateStr.length > location) {
            NSString *lastChar = [rateStr substringWithRange:NSMakeRange(rateStr.length-1, 1)];
            if ([lastChar isEqualToString:@"0"] || [lastChar isEqualToString:@"."]) {
                rateStr = [rateStr substringToIndex:rateStr.length-1];
            }
            else
            {
                break;
            }
        }
        return rateStr;
    }
    return [NSString stringWithFormat:@"%.0f",rate];
}

//添加url后的参数
+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params
{
    if (nil == url) {
        return @"";
    }
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:url];
    // Convert the params into a query string
    if (params) {
        for(id key in params) {
            NSString *sKey = [key description];
            NSString *sVal = [[params objectForKey:key] description];
            //是否有？，必须处理这个
            if ([urlWithQuerystring rangeOfString:@"?"].location==NSNotFound) {
                [urlWithQuerystring appendFormat:@"?%@=%@", [self.class urlEscape:sKey], [self.class  urlEscape:sVal]];
            } else {
                [urlWithQuerystring appendFormat:@"&%@=%@", [self.class  urlEscape:sKey], [self.class  urlEscape:sVal]];
            }
        }
    }
    
    return urlWithQuerystring;
}

+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params needEncode:(BOOL)need
{
    if(need){
        return [self addQueryStringToUrl:url params:params];
    }else{
        if (nil == url) {
            return @"";
        }
        NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:url];
        // Convert the params into a query string
        if (params) {
            for(id key in params) {
                NSString *sKey = [key description];
                NSString *sVal = [[params objectForKey:key] description];
                //是否有？，必须处理这个
                if ([urlWithQuerystring rangeOfString:@"?"].location==NSNotFound) {
                    [urlWithQuerystring appendFormat:@"?%@=%@", sKey,sVal];
                } else {
                    [urlWithQuerystring appendFormat:@"&%@=%@", sKey, sVal];
                }
            }
        }
        
        return urlWithQuerystring;
    }
}

+ (NSString *)urlEscape:(NSString *)unencodedString {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)unencodedString,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 kCFStringEncodingUTF8));
}

+ (NSString *)urlUnescape: (NSString *) input{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (CFStringRef)input,
                                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                 kCFStringEncodingUTF8));
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

/*!
 @method
 @abstract 根据任意对象转换成json字符串
 @param object 任意对象
 @return json字符串
 */
+ (NSString *)jsonStringFromObject:(id)object
{
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            //DB_LOG(@"jsonStringFromObject error: %@", error);
        }
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}

@end
