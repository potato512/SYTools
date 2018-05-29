//
//  NSDate+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString const *keyYear = @"year";
static NSString const *keyMonth = @"month";
static NSString const *keyDay = @"day";
static NSString const *keyHour = @"hour";
static NSString const *keyMinute = @"minute";
static NSString const *keySecond = @"second";

/// 获取时间间隔
#define TICK   CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define TOCK   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

/// 时间字符格式
typedef NS_ENUM(NSInteger, SYTimeShowMode)
{
    /// 自适应，即0的不再显示（含秒）
    SYTimeShowModeDefault = 0,
    
    /// 自适应，即0的不再显示（不含秒）
    SYTimeShowModeDefaultWithSecond,
    
    /// 天时分秒
    SYTimeShowModeDayHourMinuteSecond,
    
    /// 天时分
    SYTimeShowModeDayHourMinute,
    
    /// 时分秒
    SYTimeShowModeHourMinuteSecond,
    
    /// 时分
    SYTimeShowModeHourMinute,
};

/// 时间间隔显示（秒、分、时、日、月、年）
typedef NS_ENUM(NSInteger, SYDistanceMode)
{
    /// 时间间隔显示-秒（默认）
    SYDistanceModeSecond = 1,
    
    /// 时间间隔显示-分
    SYDistanceModeMinute = 2,
    
    /// 时间间隔显示-时
    SYDistanceModeHour = 3,
    
    /// 时间间隔显示-日
    SYDistanceModeDay = 4,
    
    /// 时间间隔显示-月
    SYDistanceModeMonth = 5,
    
    /// 时间间隔显示-年
    SYDistanceModeYear = 6
};

@interface NSDate (SYCategory)

/// 获取任意时间，即时间戳NSTimeInterval转NSDate
+ (NSDate *)getDateWithTimeInterval:(NSTimeInterval)time;

/// 获取任意时间秒数，即NSDate转NSTimeInterval
- (NSTimeInterval)getTimeInterval;

/// NSDate根据时间格式Formater显示时间字符串
- (NSString *)getTimeStrWithFormat:(NSString *)format;

/// 根据时间格式Format将时间戳NSTimeInterval转换成时间字符串（秒数转化成yyyy-MM-dd hh:mm:ss格式）
+ (NSString *)getTimeStrWithTimeInterval:(NSTimeInterval)time format:(NSString *)format;

/// 时间字符串根据时间格式Format转换成NSDate（time格式与format必须一致，否则返回nil）
+ (NSDate *)getDateWithFormat:(NSString *)format time:(NSString *)time;

#pragma mark - 时间

#pragma mark 指定时间

/// 获取年份
- (NSInteger)getYearOfDate;

/// 获取月份
- (NSInteger)getMonthOfDate;

/// 获取日期
- (NSInteger)getDayOfDate;

/// 获取小时
- (NSInteger)getHourOfDate;

/// 获取分钟
- (NSInteger)getMinuteOfDate;

/// 获取秒
- (NSInteger)getSecondOfDate;

/// 获取星期
- (NSString *)getWeekOfDate;

#pragma mark 当前时间

/// 获取当前日期 NSDate（直接显示会出现相差8个小时，使用NSDateFormatter时间格式则不会）
+ (NSDate *)getDateOfNower;

/// 获取当前时间戳
+ (NSTimeInterval)getTimeIntervalOfNower;

/// 获取当前时间（指定格式）
+ (NSString *)getTimeOfNower:(NSString *)format;
/// 获取当前时间
+ (NSString *)getTimeOfNower;

/// 获取当前年份
+ (NSInteger)getYearOfNower;

/// 获取当前月份
+ (NSInteger)getMonthOfNower;

/// 获取当前日期
+ (NSInteger)getDayOfNower;

/// 获取当前小时
+ (NSInteger)getHourOfNower;

/// 获取当前分钟
+ (NSInteger)getMinuteOfNower;

/// 获取当前秒
+ (NSInteger)getSecondOfNower;

/// 获取当前星期
+ (NSString *)getWeekOfNower;

#pragma mark - 时间差

/// 根据时间戳NSTimeInterval计算时间间隔数
+ (NSString *)getTimeStrWithTimeInterval:(NSTimeInterval)comparetime;

/// 计算两个日期距离现在多久（）
+ (NSString *)getTimeStrWithBeginTime:(NSString *)beginTime beginTimeFormat:(NSString *)beginFormat endTime:(NSString *)endTime endTimeFormat:(NSString *)endFormat;

/// 计算两个日期距离现在多久（）
+ (NSString *)getTimeStrWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate;

/// 获取某个时间的N天的前天或后天
+ (NSDate *)getDateWithDate:(NSDate *)date day:(NSInteger)day tomorrow:(BOOL)tomorrow;

/// 从现在开始的24小时之后或之前的某个时间NSDate（如明天，后天）
+ (NSDate *)getDateFromNowWithDay:(float)day after:(BOOL)after;

/// 从现在开始的24小时之后或之前的某个时间NSString（如明天，后天）
+ (NSString *)getTimeStrFromNowStrWithDay:(float)day after:(BOOL)after format:(NSString *)format;

/// 获取任意时间两个时间差集（keySecond秒、keyMinute分、keyHour时、keyDay日、keyMonth月、keyYear年）
+ (NSDictionary *)getTimeDistanceWithTimeInterval:(NSTimeInterval)time endTimeInterval:(NSTimeInterval)endTime;
/// 获取任意时间两个时间差集（keySecond秒、keyMinute分、keyHour时、keyDay日、keyMonth月、keyYear年）
+ (NSDictionary *)getTimeDistanceWithTimeInterval:(NSTimeInterval)time;
/// 计算两个时间差-倒计时（keySecond秒、keyMinute分、keyHour时、keyDay日、keyMonth月、keyYear年）
+ (NSDictionary *)getTimeDistanceWithDate:(NSDate *)dateBegin date:(NSDate *)dateEnd;
/// 计算任意两个时间戳之间的间隔（秒、分、时、日、月、年）
+ (NSInteger)getTimeDistanceWithTimeInterval:(NSTimeInterval)time endTimeInterval:(NSTimeInterval)endTime mode:(SYDistanceMode)mode;

/// 计算任意两个日期间的天数
+ (NSInteger)getDayBetweenDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/// 任意两个日期间的秒数
+ (NSInteger)getTimeIntervalBetweenDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/// 时间戳NSTimeInterval计算时间间隔（秒、分、时、日、月、年）
+ (NSInteger)getTimeDistanceWithTimeInterval:(NSTimeInterval)time mode:(SYDistanceMode)mode;

/// 时间戳NSTimeInterval计算时间格式显示
+ (NSString *)getTimeStrWithTimeInterval:(NSTimeInterval)time mode:(SYTimeShowMode)mode;

/// 时间戳NSTimeInterval显示格式字符串
+ (NSString *)getTimestrWithFormatTime:(NSTimeInterval)time;

@end



