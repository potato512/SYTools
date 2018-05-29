//
//  NSNumber+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (SYCategory)

#pragma mark - 字符串转数值

/// string转double
+ (double)doubleWithString:(NSString *)string;

/// string转float
+ (float)floatWithString:(NSString *)string;

/// string转int
+ (int)intWithString:(NSString *)string;

#pragma mark - 位数保留

/// 保留n位小数
+ (double)keepDecimalsDoubleValue:(double)number decimal:(int)decimalNumber;
/// 保留2位小数
+ (double)keepTwoDecimalsDoubleValue:(double)number;

#pragma mark - 随机数

/// 获取一个随机整数，范围在[from,to）
+ (int)randomNumber:(int)from to:(int)to;

#pragma mark - 大小写转换

/// 阿拉伯数字转罗马大写（如：1为一）
- (NSString *)numberConvertedUpperRoman;

/// 阿拉伯数字转中文大写（如：1为壹）
- (NSString *)numberConvertedCNCapital;

@end
