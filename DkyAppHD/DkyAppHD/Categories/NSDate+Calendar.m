//
//  NSDate+Calendar.m
//  DycApp
//
//  Created by HaKim on 15/12/22.
//  Copyright © 2015年 haKim. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (NSDateComponents *)componentsOfDay
{
    static NSDateComponents *dateComponents = nil;
    static NSDate *previousDate = nil;
    static NSCalendar *greCalendar;
    
    if (!greCalendar) {
        greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    if (!previousDate || ![previousDate isEqualToDate:self]) {
        previousDate = self;
        dateComponents = [greCalendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitWeekday | kCFCalendarUnitWeekdayOrdinal | kCFCalendarUnitWeekOfMonth | kCFCalendarUnitWeekOfYear | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond  fromDate:self];
    }
    
    return dateComponents;
}

- (NSUInteger)year
{
    return [self componentsOfDay].year;
}

- (NSUInteger)month
{
    return [self componentsOfDay].month;
}

- (NSUInteger)day
{
    return [self componentsOfDay].day;
}

- (NSUInteger)hour
{
    return [self componentsOfDay].hour;
}

- (NSUInteger)minute
{
    return [self componentsOfDay].minute;
}

- (NSUInteger)second
{
    return [self componentsOfDay].second;
}

//一周中第几天
- (NSString*)weekday
{
    NSArray *arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSInteger week = [self componentsOfDay].weekday;
    return arrWeek[--week];
}

- (NSUInteger)weekOfMonth
{
    return [self componentsOfDay].weekOfMonth;
}

- (NSUInteger)quarter
{
    return [self componentsOfDay].quarter;
}

- (NSUInteger)weekdOfYear
{
    return [self componentsOfDay].weekOfYear;
}

//- (NSString *)yearMonthWeek
//{
//    NSString *month1 = [NSString stringWithFormat:@"%d",[self componentsOfDay].month];
//    NSString *month2 = [NSString stringWithFormat:@"0%d",[self componentsOfDay].month];
//    NSString *month = [self componentsOfDay].month >= 10?month1:month2;
//    
//    NSString *day1 = [NSString stringWithFormat:@"%d",[self componentsOfDay].day];
//    NSString *day2 = [NSString stringWithFormat:@"0%d",[self componentsOfDay].day];
//    NSString *day = [self componentsOfDay].day >= 10?day1:day2;
//    
//    return [NSString stringWithFormat:@"%d-%@-%@",[self componentsOfDay].year,month,day];
//}


+ (NSInteger)getDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (fromDate && toDate)
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *compt = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay) fromDate:fromDate toDate:toDate options:0];
        DLog(@"day = %zd", [compt day]);
        return [compt day];
    }
    return 0;
}

@end
