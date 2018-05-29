//
//  NSMutableDictionary+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSMutableDictionary+SYCategory.h"

@implementation NSMutableDictionary (SYCategory)

#pragma mark - 安全验证添加

- (NSMutableDictionary *)setObjectSafety:(id)object forKey:(NSString *)key
{
    if (object && key)
    {
        [self setObject:object forKey:key];
    }
    return self;
}

- (NSMutableDictionary *)setValueSafety:(id)object forKey:(NSString *)key
{
    if (object && key)
    {
        [self setValue:object forKey:key];
    }
    return self;
}

#pragma mark - 链式属性

/// 链式编程 添加，或重置元素（key不存在时新增，存在时修改）
- (NSMutableDictionary *(^)(id object, NSString *key))addObject
{
    return ^(id object, NSString *key) {
        if (object && key)
        {
            [self setObject:object forKey:key];
        }
        return self;
    };
}

/// 链式编程 删除指定元素
- (NSMutableDictionary *(^)(NSString *key))removeOjbectForKey
{
    return ^(NSString *key) {
        if (key)
        {
            [self removeObjectForKey:key];
        }
        return self;
    };
}

/// 链式编程 删除所有元素
- (NSMutableDictionary *(^)())removeAllObject
{
    return ^() {
        [self removeAllObjects];
        return self;
    };
}

@end
