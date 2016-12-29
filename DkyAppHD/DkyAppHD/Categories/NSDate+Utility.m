//
//  NSDate+Utility.m
//  DycApp
//
//  Created by HaKim on 15/12/9.
//  Copyright © 2015年 haKim. All rights reserved.
//

#import "NSDate+Utility.h"
#import "NSDate+Calendar.h"

#define kDay                (24 * 60 * 60)

#define kZeroOClock         @"00:00:00"
#define kBeforeZeroOclock   @"23:59:59"

static NSTimeInterval beginDateInt = 0;
static NSTimeInterval endDateInt = 0;

@implementation NSDate (Utility)

+ (NSString*)stringSince1970
{
    //1441960136703 ,1442217598356
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSInteger timei  =  (NSInteger)time * 1000;
    NSString * timeStr = [NSString stringWithFormat:@"%@",@(timei)];
    return timeStr;
}

+ (NSString*)convertTimeFromTimeInterval:(NSTimeInterval)timeInterval convertType:(NSDateConvertType)type
{
    NSDate *convertTime = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSString *formateTime = nil;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    switch (type) {
        case NSDateConvertType_One:
            [dateformatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Two:
            [dateformatter setDateFormat:@"yyyy年MM月dd日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Three:
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Four:
        {
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            NSString *weekDay = [convertTime weekday];
            formateTime = [NSString stringWithFormat:@"%@ (%@)",formateTime,weekDay];
        }
            break;
        case NSDateConvertType_Five:
            [dateformatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Six:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Seven:
            [dateformatter setDateFormat:@"yyyy年MM月"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Eight:
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Thirteen:
        [dateformatter setDateFormat:@"yyyyMMdd"];
        formateTime = [dateformatter stringFromDate:convertTime];
        break;
        
        default:
            break;
    }
    return formateTime;
}

+ (NSString*)convertTimeFromTimeString:(NSString*)timeString convertType:(NSDateConvertType)type{
    NSString *formateTime = nil;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *convertTime = [dateformatter dateFromString:timeString];
    
    switch (type) {
        case NSDateConvertType_One:
            [dateformatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Two:
            [dateformatter setDateFormat:@"yyyy年MM月dd日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Three:
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Four:
        {
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            NSString *weekDay = [convertTime weekday];
            formateTime = [NSString stringWithFormat:@"%@ (%@)",formateTime,weekDay];
        }
            break;
        case NSDateConvertType_Five:
            [dateformatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Six:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Seven:
            [dateformatter setDateFormat:@"yyyy年MM月"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Eight:
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Nine:
            [dateformatter setDateFormat:@"yyyy年M月d日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Eleven:
            [dateformatter setDateFormat:@"M月d日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        default:
            break;
    }
    return formateTime;
}

+ (NSString*)convertTimeFromDate:(NSDate*)date convertType:(NSDateConvertType)type{
    NSString *formateTime = nil;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    NSDate *convertTime = date;
    
    switch (type) {
        case NSDateConvertType_One:
            [dateformatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Two:
            [dateformatter setDateFormat:@"yyyy年MM月dd日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Three:
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Four:
        {
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            NSString *weekDay = [convertTime weekday];
            formateTime = [NSString stringWithFormat:@"%@ (%@)",formateTime,weekDay];
        }
            break;
        case NSDateConvertType_Five:
            [dateformatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Six:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Seven:
            [dateformatter setDateFormat:@"yyyy年MM月"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Eight:
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Nine:
            [dateformatter setDateFormat:@"yyyy年M月d日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Twelve:
            [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;

        default:
            break;
    }
    return formateTime;
}

+ (NSString*)convertTimeFromDateString:(NSString*)timeString convertType:(NSDateConvertType)type{
    NSString *formateTime = nil;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *convertTime = [dateformatter dateFromString:timeString];
    
    switch (type) {
        case NSDateConvertType_One:
            [dateformatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Two:
            [dateformatter setDateFormat:@"yyyy年MM月dd日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Three:
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Four:
        {
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            NSString *weekDay = [convertTime weekday];
            formateTime = [NSString stringWithFormat:@"%@ (%@)",formateTime,weekDay];
        }
            break;
        case NSDateConvertType_Five:
            [dateformatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Six:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Seven:
            [dateformatter setDateFormat:@"yyyy年MM月"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Eight:
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        case NSDateConvertType_Nine:
            [dateformatter setDateFormat:@"yyyy年M月d日"];
            formateTime = [dateformatter stringFromDate:convertTime];
            break;
        default:
            break;
    }
    return formateTime;
}

+ (NSInteger)getRemainDaysToDate:(NSString*)timeString{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateformatter dateFromString:timeString];
    
    NSDate *currentDate = [NSDate date];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:currentDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

+(NSString*)stringTimeWithType:(NSDateConvertType)type{
    NSDate *currentDate = [NSDate date];
    
    NSString *formateTime = nil;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    switch (type) {
        case NSDateConvertType_One:
            [dateformatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Two:
            [dateformatter setDateFormat:@"yyyy年MM月dd日"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Three:
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Four:
        {
            [dateformatter setDateFormat:@"MM-dd"];
            formateTime = [dateformatter stringFromDate:currentDate];
            NSString *weekDay = [currentDate weekday];
            formateTime = [NSString stringWithFormat:@"%@ (%@)",formateTime,weekDay];
        }
            break;
        case NSDateConvertType_Five:
            [dateformatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Six:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Seven:
            [dateformatter setDateFormat:@"yyyy年MM月"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Eight:
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateConvertType_Nine:
            [dateformatter setDateFormat:@"yyyy年M月d日"];
            formateTime = [dateformatter stringFromDate:currentDate];
            break;
        default:
            break;
    }
    return formateTime;
}

+ (NSString*)currentDayStringType:(NSDateCurrentDayType)type
{
    NSDate *currentDate = [NSDate date];
    NSString *currentDay = nil;
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    switch (type) {
        case NSDateCurrentDayType_One:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            currentDay = [dateformatter stringFromDate:currentDate];
            break;
        case NSDateCurrentDayType_Two:
            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            currentDay = [dateformatter stringFromDate:currentDate];
            break;
        default:
            break;
    }
    return currentDay;
}

+ (BOOL)isLaterThanSomeTime:(NSString*)someTimeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *currentDate = [NSDate date];
    NSString *dayTime = [formatter stringFromDate:currentDate];
    someTimeStr = [someTimeStr stringByAppendingString:@":00"];
    dayTime = [NSString stringWithFormat:@"%@ %@",dayTime, someTimeStr];
    [formatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSDate *someTimeOClock = [formatter dateFromString:dayTime];
    NSComparisonResult result = [someTimeOClock compare:currentDate];
    if(result == NSOrderedDescending)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (NSString*)getDayAfterDays:(NSInteger)day
{
    NSDate *date = [NSDate date];
    
    NSDate *someDay = [NSDate dateWithTimeInterval:day * kDay sinceDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *resultDay = [formatter stringFromDate:someDay];
    NSString *weekDay = [someDay weekday];
    resultDay = [NSString stringWithFormat:@"%@ (%@)",resultDay,weekDay];
    return resultDay;
}

+ (NSString*)weekDayStr:(NSDate *)someDay
{
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSYearCalendarUnit |
//    NSMonthCalendarUnit |
//    NSDayCalendarUnit |
//    NSWeekdayCalendarUnit |
//    NSHourCalendarUnit |
//    NSMinuteCalendarUnit |
//    NSSecondCalendarUnit;
//    comps = [gregorian components:unitFlags fromDate:someDay];
//    NSDate *_date = [gregorian dateFromComponents:comps];
//    
//    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
//    NSInteger week = [weekdayComponents weekday];
// 
//    return weekDayStr;
    return nil;
}

+ (void)setSomeMonthWithTimeInterval:(NSTimeInterval)timeInterval
{
    timeInterval = timeInterval / 1000;
    NSDate *newDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    beginString = [NSString stringWithFormat:@"%@ %@",beginString,kZeroOClock];
    endString = [NSString stringWithFormat:@"%@ %@",endString, kBeforeZeroOclock];
    
    [myDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    beginDate = [myDateFormatter dateFromString:beginString];
    endDate = [myDateFormatter dateFromString:endString];
    
    beginDateInt = [beginDate timeIntervalSince1970];
    endDateInt = [endDate timeIntervalSince1970];
}

+ (BOOL)isInSomeMonth:(NSTimeInterval)timeInterval
{
    timeInterval = timeInterval / 1000;
    if(timeInterval >= beginDateInt && timeInterval <= endDateInt)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)dateByAddingDays:(NSInteger)days convertType:(NSDateConvertType)type
{
    NSDate *date = [NSDate date];
    NSDate *newDate = [NSDate dateWithTimeInterval:days * kDay sinceDate:date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    NSString *formateTime = nil;
    
    switch (type) {
        case NSDateConvertType_Six:
            [dateformatter setDateFormat:@"yyyy-MM-dd"];
            formateTime = [dateformatter stringFromDate:newDate];
            break;
        default:
            break;
    }
    
    return formateTime;
}

- (NSTimeInterval) timeByAddingDays:(NSInteger)days
{
    NSDate *newDate = [NSDate dateWithTimeInterval:days * kDay sinceDate:self];
    NSTimeInterval someTime = [newDate timeIntervalSince1970];
    return someTime;
}

- (BOOL)isExpired:(NSString *)someTime{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *sometime = [dateformatter dateFromString:someTime];
    
    NSDate *currentDate = [NSDate date];
    
    BOOL result = [currentDate compare:sometime] == NSOrderedDescending;
    return result;
}




@end
