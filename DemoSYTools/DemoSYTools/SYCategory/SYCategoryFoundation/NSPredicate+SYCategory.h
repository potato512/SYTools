//
//  NSPredicate+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/3/2.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//  NSPredicate类是用来定义逻辑条件约束的获取或内存中的过滤搜索

#import <Foundation/Foundation.h>

@interface NSPredicate (SYCategory)

#pragma mark - 数值比较运算

/// 数值比较
+ (BOOL)predicateNumber:(NSNumber *)number filter:(NSString *)filter;

#pragma mark - 字符过滤

/// 使用MATCH过滤字符
+ (BOOL)predicateText:(NSString *)text filter:(NSString *)filter;

/// 邮箱验证
+ (BOOL)predicateEmail:(NSString *)email;

/// 数字验证
+ (BOOL)predicateNumber:(NSString *)number;

/// 不区分大小写字母验证
+ (BOOL)predicateLetter:(NSString *)letter;

/// 手机号码验证
+ (BOOL)predicatePhoneNum:(NSString *)phoneNum;

/// 移动手机号码验证
+ (BOOL)predicatePhoneNumMobile:(NSString *)phoneNumMobile;

/// 联通手机号码验证
+ (BOOL)predicatePhoneNumUnicom:(NSString *)phoneNumUnicom;

/// 电信手机号码验证
+ (BOOL)predicatePhoneNumTelecom:(NSString *)phoneNumTelecom;

/// 固定号码验证
+ (BOOL)predicateTelNum:(NSString *)telNum;

#pragma mark - 数据过滤

/// 数组过滤
+ (NSArray *)predicateArray:(NSArray *)array filter:(NSString *)filter;


@end
