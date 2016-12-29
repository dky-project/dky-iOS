//
//  NSDate+Calendar.h
//  DycApp
//
//  Created by HaKim on 15/12/22.
//  Copyright © 2015年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

//获得NSDate对应的年月日
- (NSUInteger)year;
- (NSUInteger)month;
- (NSUInteger)quarter; //季度
- (NSUInteger)day;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
- (NSString*)weekday; //星期几

- (NSUInteger)weekdOfYear; //该年中第几周
- (NSUInteger)weekOfMonth;
//- (NSString *)yearMonthWeek; //返回年月日，如2015-8-11

/**
 *  获取两个日期的间隔的天数
 *
 *  @param fromDate  开始日期
 *  @param toDate 结束日期
 *
 *  @return days
 */
+ (NSInteger)getDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
