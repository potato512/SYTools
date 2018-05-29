//
//  NSMutableString+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (SYCategory)

#pragma mark - 安全验证添加

/// 重置字符串（安全的）
- (NSMutableString *)setStringSafety:(NSString *)string;

/// 添加字符串（安全的）
- (NSMutableString *)appendStringSafety:(NSString *)string;

/// 插入字符串（安全的）
- (NSMutableString *)indsertStringSafety:(NSString *)string atIndex:(NSInteger)index;

/// 替换字符串（安全的）
- (NSMutableString *)replaceStringSafety:(NSString *)currentString withString:(NSString *)replaceString;

#pragma mark - 链式属性

/// 链式编程 重置可变字符串
- (NSMutableString *(^)(NSString *string))resetString;

/// 链式编程 追加字符串
- (NSMutableString *(^)(NSString *string))addString;

/// 链式编程 添加字符串到指定位置
- (NSMutableString *(^)(NSString *string, NSUInteger index))addStringAtIndex;

/// 链式编程 替换指定的字符串
- (NSMutableString *(^)(NSString *currentString, NSString *replaceString))replaceStringForString;

/// 链式编程 替换指定位置的字符串
- (NSMutableString *(^)(NSString *string, NSRange range))replaceStringForRange;

/// 链式编程 删除字符串
- (NSMutableString *(^)(NSString *string))deleteString;

@end
