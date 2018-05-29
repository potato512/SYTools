//
//  NSMutableArray+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSMutableArray+SYCategory.h"

@implementation NSMutableArray (SYCategory)

#pragma mark - 安全验证添加

- (NSMutableArray *)addObjectSafety:(id)object
{
    if (object)
    {
        [self addObject:object];
    }
    return self;
}

- (NSMutableArray *)insertObjectSafety:(id)object atIndex:(NSInteger)index
{
    if (object && (0 <= index || self.count - 1 >= index))
    {
        [self insertObject:object atIndex:index];
    }
    return self;
}

- (NSMutableArray *)replaceObjectSafety:(id)object atIndex:(NSInteger)index
{
    if (object && (0 <= index || self.count - 1 >= index))
    {
        [self replaceObjectAtIndex:index withObject:object];
    }
    return self;
}

- (NSMutableArray *)addObjectsFromArraySafety:(NSArray *)array
{
    if (array && 0 < array.count)
    {
        [self addObjectsFromArray:array];
    }
    return self;
}

#pragma mark - 链式属性

/// 链式编程 追加元素
- (NSMutableArray *(^)(id object))addObject
{
    return ^(id object) {
        if (object)
        {
            [self addObject:object];
        }
        return self;
    };
}

/// 链式编程 添加元素到指定位置
- (NSMutableArray *(^)(id object, NSInteger index))addObjectAtIndex
{
    return ^(id object, NSInteger index) {
        if (object && (0 <= index || self.count - 1 >= index))
        {
            [self insertObject:object atIndex:index];
        }
        return self;
    };
}

/// 链式编程 替换指定位置的元素
- (NSMutableArray *(^)(id object, NSInteger index))setOjbectAtIndex
{
    return ^(id object, NSInteger index) {
        if (object && (0 <= index || self.count - 1 >= index))
        {
            [self setObject:object atIndexedSubscript:index];
        }
        return self;
    };
}

/// 链式编程 追加数组
- (NSMutableArray *(^)(NSArray *array))addArray
{
    return ^(NSArray *array) {
        if (array && 0 < array.count)
        {
            [self addObjectsFromArray:array];
        }
        return self;
    };
}

/// 链式编程 替换指定位置的元素
- (NSMutableArray *(^)(id object, NSInteger index))replaceObjectAtIndex
{
    return ^(id object, NSInteger index) {
        if (object && (0 <= index || self.count - 1 >= index))
        {
            [self replaceObjectAtIndex:index withObject:object];
        }
        return self;
    };
}

/// 链式编程 删除第一个元素
- (NSMutableArray *(^)())removeTheFirstObject
{
    return ^() {
        id object = self.firstObject;
        [self removeObject:object];
        return self;
    };
}

/// 链式编程 删除最后一个元素
- (NSMutableArray *(^)())removeTheLastOjbect
{
    return ^() {
        [self removeLastObject];
        return self;
    };
}

/// 链式编程 删除指定元素
- (NSMutableArray *(^)(id object))removeObject
{
    return ^(id object) {
        if (object && [self containsObject:object])
        {
            [self removeObject:object];
        }
        return self;
    };
}

/// 链式编程 删除指定位置的元素
- (NSMutableArray *(^)(NSInteger index))removeObjectAtIndex
{
    return ^(NSInteger index) {
        if (0 <= index || self.count - 1 >= index)
        {
            [self removeObjectAtIndex:index];
        }
        return self;
    };
}

/// 链式编程 删除所有元素
- (NSMutableArray *(^)())removeAllObject
{
    return ^() {
        [self removeAllObjects];
        return self;
    };
}

@end
