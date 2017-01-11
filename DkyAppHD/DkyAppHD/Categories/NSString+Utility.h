//
//  NSString+Utility.h
//  DjdApp
//
//  Created by HaKim on 16/5/18.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params needEncode:(BOOL)need;
+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params;
+ (NSString *)urlEscape:(NSString *)unencodedString ;
+ (NSString *)urlUnescape: (NSString *) input;

- (BOOL)isNilOrEmpty;

//判断字符串时候为空
- (BOOL)isEmptyString;

/**
 *  数字转化 没隔三位 逗号隔开 123,456,78
 *
 *  @param num 要转化的数字
 *   返回处理好的数字字符串
 */
+(NSString *)countNumAndChangeformat:(NSString *)num;

/*!
 *
 * 根据任意对象转换成json字符串
 * 任意对象
 *return json字符串
 */
+ (NSString *)jsonStringFromObject:(id)object;


+ (NSString*)formatRateStringWithRate:(CGFloat)rate;
@end
