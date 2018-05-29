//
//  NSMutableString+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSMutableString+SYCategory.h"

@implementation NSMutableString (SYCategory)

#pragma mark - 安全验证添加

- (NSMutableString *)setStringSafety:(NSString *)string
{
    if (string)
    {
        [self setString:string];
    }
    return self;
}

- (NSMutableString *)appendStringSafety:(NSString *)string
{
    if (string)
    {
        [self appendString:string];
    }
    return self;
}

- (NSMutableString *)indsertStringSafety:(NSString *)string atIndex:(NSInteger)index
{
    if (string && (0 <= index || self.length - 1 >= index))
    {
        [self insertString:string atIndex:index];
    }
    return self;
}

- (NSMutableString *)replaceStringSafety:(NSString *)currentString withString:(NSString *)replaceString
{
    if (currentString && replaceString)
    {
        NSString *tmp = [NSString stringWithString:self];
        tmp = [tmp stringByReplacingOccurrencesOfString:currentString withString:replaceString];
        [self setString:tmp];
    }
    return self;
}

#pragma mark - 链式属性

/// 链式编程 重置可变字符串
- (NSMutableString *(^)(NSString *string))resetString
{
    return ^(NSString *string) {
        if (string)
        {
            [self setString:string];
        }
        return self;
    };
}

/// 链式编程 追加字符串
- (NSMutableString *(^)(NSString *string))addString
{
    return ^(NSString *string) {
        if (string)
        {
            [self appendString:string];
        }
        return self;
    };
}

/// 链式编程 添加字符串到指定位置
- (NSMutableString *(^)(NSString *string, NSUInteger index))addStringAtIndex
{
    return ^(NSString *string, NSUInteger index) {
        if (string && (0 <= index || self.length - 1 >= index))
        {
            [self insertString:string atIndex:index];
        }
        return self;
    };
}

/// 链式编程 替换指定的字符串
- (NSMutableString *(^)(NSString *currentString, NSString *replaceString))replaceStringForString
{
    return ^(NSString *currentString, NSString *replaceString) {
        if (currentString && replaceString)
        {
            NSString *tmp = [NSString stringWithString:self];
            tmp = [tmp stringByReplacingOccurrencesOfString:currentString withString:replaceString];
            [self setString:tmp];
        }
        return self;
    };
}

/// 链式编程 替换指定位置的字符串
- (NSMutableString *(^)(NSString *string, NSRange range))replaceStringForRange
{
    return ^(NSString *string, NSRange range) {
        if (string)
        {
            [self replaceCharactersInRange:range withString:string];
        }
        
        return self;
    };
}

/// 链式编程 删除字符串
- (NSMutableString *(^)(NSString *string))deleteString
{
    return ^(NSString *string) {
        if (string)
        {
            NSRange range = [self rangeOfString:string];
            if (range.location != NSNotFound)
            {
                [self deleteCharactersInRange:range];
            }
        }
        return self;
    };
}

@end
