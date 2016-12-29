//
//  NSDate+Utility.h
//  DycApp
//
//  Created by HaKim on 15/12/9.
//  Copyright © 2015年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NSDateConvertType)
{
    NSDateConvertType_Unset,
    NSDateConvertType_One, // 2015年12月9日 18:30:30
    NSDateConvertType_Two, // 2015年12月9日
    NSDateConvertType_Three, // 12-24
    NSDateConvertType_Four, // 12-24 (星期五)
    NSDateConvertType_Five, // 2016.12.12 23:59:59
    NSDateConvertType_Six, // 2016-01-01
    NSDateConvertType_Seven,  // 2016年1月
    NSDateConvertType_Eight,  // 01-20 08:22
    NSDateConvertType_Nine, // 2016年3月8日
    NSDateConvertType_Ten,  // 2016-03-29 18:18:18
    NSDateConvertType_Eleven, // 6月22日
    NSDateConvertType_Twelve, // 20160712101010
    NSDateConvertType_Thirteen, // 20160913

};

typedef NS_ENUM(NSInteger, NSDateCurrentDayType)
{
    NSDateCurrentDayType_Unset = 0,
    NSDateCurrentDayType_One, // 2016-01-25
    NSDateCurrentDayType_Two, // 2016-03-29 18:18:18
};

@interface NSDate (Utility)

/**
 *  返回紫1970以后的秒数
 *
 *  @return 秒数
 */
+ (NSString*)stringSince1970;

/**
 *  时间戳 转换为特定格式(1,2,3,4,5,6,7,8,13)的时间
 *
 *  @param time 例如 : 1449654683000
 *  @param type 1.2015年12月9日 18：30：30
 *
 *  @return 1.2015年12月9日 18：30：30
 */
+ (NSString*)convertTimeFromTimeInterval:(NSTimeInterval)timeInterval convertType:(NSDateConvertType)type;

/**
 *  从一种时间格式转换成另一种格式
 *
 *  @param timeString 2016-01-06 14:41:07
 *  @param type       type description
 *
 *  @return return value description 例如 2016年01月06日
 */
+ (NSString*)convertTimeFromTimeString:(NSString*)timeString convertType:(NSDateConvertType)type;

/**
 *  从一种时间格式转换成另一种格式
 *
 *  @param date date
 *  @param type type description
 *
 *  @return return value description
 */
+ (NSString*)convertTimeFromDate:(NSDate*)date convertType:(NSDateConvertType)type;

/**
 *  从今天到指定日期间隔的天数
 *
 *  @param timeString timeString description
 *
 *  @return return value description
 */
+ (NSInteger)getRemainDaysToDate:(NSString*)timeString;

/**
 *  从一种时间格式转换成另一种格式
 *
 *  @param timeString 2016-01-06
 *  @param type       type description
 *
 *  @return return value description
 */
+ (NSString*)convertTimeFromDateString:(NSString*)timeString convertType:(NSDateConvertType)type;
/**
 *  得到当前时间的字符串
 *
 *  @param type type description
 *
 *  @return return value description
 */
+(NSString*)stringTimeWithType:(NSDateConvertType)type;

/**
 *  获取现在的日期
 *
 *  @param type type description
 *
 *  @return return value description
 */
+ (NSString*)currentDayStringType:(NSDateCurrentDayType)type;

/**
 *  晚于某一刻时间
 *
 *  @param someTimeStr @“22:00”
 *
 *  @return return value description
 */
+ (BOOL)isLaterThanSomeTime:(NSString*)someTimeStr;

/**
 *  获取今天之后的某几天
 *
 *  @param day 1，获取明天的日期，以此类推
 *
 *  @return 12-22 (星期几)
 */
+ (NSString*)getDayAfterDays:(NSInteger)day;

/**
 *  根据时间戳设置某个时间的月的范围，用来某天判断是否在这个月的范围内
 *
 *  @param timeInterval timeInterval description
 */
+ (void)setSomeMonthWithTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  判断
 *
 *  @param timeInterval timeInterval description
 *
 *  @return yes,在某个月份的范围内
 */
+ (BOOL)isInSomeMonth:(NSTimeInterval)timeInterval;

/**
 *  返回距离当前时间的天数的日期
 *
 *  @param days days description
 *  @param type type description
 *
 *  @return return value description
 */
+ (NSString *)dateByAddingDays:(NSInteger)days convertType:(NSDateConvertType)type;

/**
 *  返回距离当前时间的时间戳
 *
 *  @param days days description
 *
 *  @return return value description
 */
- (NSTimeInterval)timeByAddingDays:(NSInteger)days;

/**
 *  判断某个时间是否过期
 *
 *  @param someTime 2016-03-16 00:00:00
 *
 *  @return return value description
 */
- (BOOL)isExpired:(NSString *)someTime;
@end
