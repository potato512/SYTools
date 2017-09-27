//
//  SYCommon_define.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用宏定义

/********************** 头文件 ****************************/

#pragma mark - 导入头文件

// 常用宏定义
#import "SYCommon_font.h"
#import "SYCommon_color.h"
#import "SYCommon_Markwords.h"
#import "SYCommon_time.h"
#import "SYCommon_limit.h"
#import "SYCommon_Image.h"
#import "SYCommon_Device.h"
#import "SYCommon_Symbol.h"
#import "SYCommon_FilePath.h"

/********************** 头文件 ****************************/

#ifndef HKC_Common_define_h
#define HKC_Common_define_h

/********************** 常用宏 ****************************/

#pragma mark - 运行时间统计

/**
 使用示例：
 DelaTimeStart;
 // coding...
 
 DelaTimeEnd(@"end");
 
 使用打印结果：>>>>>>>>>> end: delaTime = 0.004761 <<<<<<<<<<
 
 */
#define DelaTimeStart NSDate *delaTimeStart = [NSDate date]
#define DelaTimeEnd(name) {double delaTime = [[NSDate date] timeIntervalSinceDate:delaTimeStart];NSLog(@">>>>>>>>>> %@: delaTime = %f <<<<<<<<<<", name, delaTime);}


#pragma mark - 强弱引用

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

#pragma mark - 国际化字符串

#define kLocalizedString(key) NSLocalizedString(key, nil)

#pragma mark - tag属性

/// 设置View的tag属性
#define kViewWithTag(object, tag) [object viewWithTag:tag]

#pragma mark - GCD

#define GCDBackComplete(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDMainComplete(block) dispatch_async(dispatch_get_main_queue(), block)

#pragma mark - 常用单例

#pragma mark NSUserDefaults存储
#define kUserDefault [NSUserDefaults standardUserDefaults]
#define kUserDefaultSave(value, key) {if (value && (key && 0 < key.length && [key isKindOfClass:[NSString class]])){[kUserDefault setObject:value forKey:key];[[NSUserDefaults standardUserDefaults] synchronize];}}
#define kUserDefaultRead(key) ((key && 0 < key.length && [key isKindOfClass:[NSString class]]) ? [kUserDefault objectForKey:key] : nil)

#pragma mark NSFileManager文件
#define kFileManager [NSFileManager defaultManager]

#pragma mark NSNotificationCenter通知
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kNotificationCenterReceive(name, target, action) {if ((name && 0 < name.length && [name isKindOfClass:[NSString class]])) {[kNotificationCenter addObserver:target selector:action name:name object:nil];}}
#define kNotificationCenterPost(name, infoDict) [kNotificationCenter postNotificationName:name object:nil userInfo:infoDict]

#pragma mark - 角度弧度转换

/// 由角度获取弧度，有弧度获取角度
#define kDegreesToRadian(radian) (M_PI * (radian) / 180.0)
#define kRadianToDegrees(radian) ((radian * 180.0) / (M_PI))

#pragma mark - 日志打印

/// Dlog
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#pragma mark - 对象转换

/// 字符串导url
#define URLWithString(str)  [NSURL URLWithString:str]

/// number转字符串
#define StringWithNumber(number) ([NSString stringWithFormat:@"%@", number])

/// 整型数值转字符串
#define StringWithIntValue(int) ([NSString stringWithFormat:@"%@", @(int)])

/// 整型数值转字符串
#define StringWithIntegerValue(integer) ([NSString stringWithFormat:@"%@", @(integer)])

/// 单精度数值转字符串
#define StringWithFloadValue(float) ([NSString stringWithFormat:@"%@", @(float)])

/// 双精度数值转字符串
#define StringWithDoubleValue(double) ([NSString stringWithFormat:@"%@", @(double)])

/********************** 常用宏 ****************************/

#endif


