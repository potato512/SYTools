//
//  NSArray+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSArray+SYCategory.h"
#import <UIKit/UIKit.h>
#import "NSString+SYCategory.h"

static NSNumber *Ascending; // 是否升序

@implementation NSArray (SYCategory)

/**
 *  字符串数组按照元素首字母进行排序分组
 *
 *  @return 按首字母排序后的数组字典
 */
- (NSDictionary *)dictionaryOrderByCharacter
{
    if (0 == self.count)
    {
        return nil;
    }
    
    for (id obj in self)
    {
        if (![obj isKindOfClass:[NSString class]])
        {
            return nil;
        }
    }
    
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionIndexTitles.count];
    // 创建27个分组数组
    for (int i = 0; i < indexedCollation.sectionIndexTitles.count; i++)
    {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    
    // 按字母顺序进行分组
    NSInteger lastIndex = -1;
    for (int i = 0; i < self.count; i++)
    {
        NSInteger index = [indexedCollation sectionForObject:self[i] collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:self[i]];
        
        lastIndex = index;
    }
    
    // 去掉空数组
    for (int i = 0; i < objects.count; i++)
    {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0)
        {
            [objects removeObject:obj];
        }
    }
    
    // 获取索引字母
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    for (NSMutableArray *obj in objects)
    {
        NSString *str = obj[0];
        NSString *key = [str firstCharacter];
        [keys addObject:key];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:objects forKey:keys];
    
    return dic;
}

#pragma mark - 异常判断

/// 是否是数组判断
- (BOOL)isArray
{
    if ([self isKindOfClass:[NSArray class]])
    {
        return YES;
    }
    
    return NO;
}

/// 非空数组判断
+ (BOOL)isValidArray:(NSArray *)array
{
    if ([array isArray] && 0 < array.count && array != nil)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 数组比较排序

// 利用数组的sortedArrayUsingComparator调用 NSComparator ，obj1和obj2指的数组中的对象
NSComparator ComparatorNumberArraySelector = ^(id obj1, id obj2){
    
    BOOL isAscending = Ascending.boolValue;
    
    if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]])
    {
        // 默认string类型
        NSString *value1 = (NSString *)obj1;
        NSString *value2 = (NSString *)obj2;
        
        NSComparisonResult compareResult = [value1 compare:value2];
        
        if (NSOrderedDescending == compareResult)
        {
            return (isAscending ? (NSComparisonResult)NSOrderedAscending : (NSComparisonResult)NSOrderedDescending);
        }
        else if (NSOrderedAscending == compareResult)
        {
            return (isAscending ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending);
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }
    else if ([obj1 isKindOfClass:[NSIndexPath class]] && [obj2 isKindOfClass:[NSIndexPath class]])
    {
        NSInteger value1 = ((NSIndexPath *)obj1).section;
        NSInteger value2 = ((NSIndexPath *)obj2).section;
        
        if (value1 > value2)
        {
            return (isAscending ? NSOrderedAscending : NSOrderedDescending);
        }
        else if (value1 < value2)
        {
            return (isAscending ? NSOrderedDescending : NSOrderedAscending);
        }
        else
        {
            return NSOrderedSame;
        }
    }
    
    // 默认number类型
    NSInteger value1 = [obj1 integerValue];
    NSInteger value2 = [obj2 integerValue];
    
    if (value1 > value2)
    {
        return (isAscending ? (NSComparisonResult)NSOrderedAscending : (NSComparisonResult)NSOrderedDescending);
    }
    else if (value1 < value2)
    {
        return (isAscending ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending);
    }
    else
    {
        return (NSComparisonResult)NSOrderedSame;
    }
};

/// 数组排序（isAscending=NO 降序；isAscending=YES 升序）
- (NSArray *)sortNumberArrayUsingSelector:(BOOL)isAscending
{
    Ascending = @(isAscending);
    NSArray *array = [self sortedArrayUsingComparator:ComparatorNumberArraySelector];
    return array;
}

/// 数组排序（isAscending=NO 降序；isAscending=YES 升序）
- (NSArray *)sortArrayUsingComparator:(BOOL)isAscending
{
    NSArray *array = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]])
        {
            // 默认string类型
            NSString *value1 = (NSString *)obj1;
            NSString *value2 = (NSString *)obj2;
            
            NSComparisonResult compareResult = [value1 compare:value2];
            
            if (NSOrderedDescending == compareResult)
            {
                return (isAscending ? (NSComparisonResult)NSOrderedAscending : (NSComparisonResult)NSOrderedDescending);
            }
            else if (NSOrderedAscending == compareResult)
            {
                return (isAscending ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending);
            }
            else
            {
                return (NSComparisonResult)NSOrderedSame;
            }
        }
        else if ([obj1 isKindOfClass:[NSIndexPath class]] && [obj2 isKindOfClass:[NSIndexPath class]])
        {
            NSInteger value1 = ((NSIndexPath *)obj1).section;
            NSInteger value2 = ((NSIndexPath *)obj2).section;
            
            if (value1 > value2)
            {
                return (isAscending ? NSOrderedAscending : NSOrderedDescending);
            }
            else if (value1 < value2)
            {
                return (isAscending ? NSOrderedDescending : NSOrderedAscending);
            }
            else
            {
                return NSOrderedSame;
            }
        }
        
        // 默认number类型
        NSInteger value1 = [obj1 integerValue];
        NSInteger value2 = [obj2 integerValue];
        
        if (value1 > value2)
        {
            return (isAscending ? (NSComparisonResult)NSOrderedAscending : (NSComparisonResult)NSOrderedDescending);
        }
        else if (value1 < value2)
        {
            return (isAscending ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending);
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    return array;
}

// 利用sortedArrayUsingFunction 调用 对应方法customSort，这个方法中的obj1和obj2分别是指数组中的对象。
NSInteger comparatorNumberArrayFunction(id obj1, id obj2, void* context){
    
    BOOL isAscending = Ascending.boolValue;
    
    if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]])
    {
        // 默认string类型
        NSString *value1 = (NSString *)obj1;
        NSString *value2 = (NSString *)obj2;
        
        NSComparisonResult compareResult = [value1 compare:value2];
        
        if (NSOrderedDescending == compareResult)
        {
            return (isAscending ? (NSComparisonResult)NSOrderedAscending : (NSComparisonResult)NSOrderedDescending);
        }
        else if (NSOrderedAscending == compareResult)
        {
            return (isAscending ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending);
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }
    else if ([obj1 isKindOfClass:[NSIndexPath class]] && [obj2 isKindOfClass:[NSIndexPath class]])
    {
        NSInteger value1 = ((NSIndexPath *)obj1).section;
        NSInteger value2 = ((NSIndexPath *)obj2).section;
        
        if (value1 > value2)
        {
            return (isAscending ? NSOrderedAscending : NSOrderedDescending);
        }
        else if (value1 < value2)
        {
            return (isAscending ? NSOrderedDescending : NSOrderedAscending);
        }
        else
        {
            return NSOrderedSame;
        }
    }
    
    // 默认number类型
    NSInteger value1 = [obj1 integerValue];
    NSInteger value2 = [obj2 integerValue];
    
    if (value1 > value2)
    {
        return (isAscending ? (NSComparisonResult)NSOrderedAscending : (NSComparisonResult)NSOrderedDescending);
    }
    else if (value1 < value2)
    {
        return (isAscending ? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending);
    }
    else
    {
        return (NSComparisonResult)NSOrderedSame;
    }
}

/// 数组排序（isAscending=NO 降序；isAscending=YES 升序）
- (NSArray *)sortArrayUsingFunction:(BOOL)isAscending
{
    Ascending = @(isAscending);
    NSArray *array = [self sortedArrayUsingFunction:comparatorNumberArrayFunction context:nil];
    return array;
}

// 利用sortUsingDescriptors调用NSSortDescriptor
// 其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便 数组中有字典的排序
/// 数组排序（数组元素也可以是字典。isAscending=NO 降序；isAscending=YES 升序）
- (void)sortArrayWithCondition:(NSString *)condition ascending:(BOOL)isAscending
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:condition ascending:isAscending];
    NSArray *sortDescriptorArray = [NSArray arrayWithObject:sortDescriptor];
    NSMutableArray *array = (NSMutableArray *)self;
    [array sortUsingDescriptors:sortDescriptorArray];
}

#pragma mark - 数组取值，或重组

/**
 *  字符串数组转换成大写字符串数组
 *
 *  @return 大写字符串数组
 */
- (NSArray *)uppercaseArray
{
    if ([NSArray isValidArray:self])
    {
        NSArray *result = [self valueForKeyPath:@"uppercaseString"];
        return result;
    }
    
    return nil;
}

/**
 *  字符串数组转换成每个字符串长度的数组
 *
 *  @return 每个字符串长度数组
 */
- (NSArray *)lengthArray
{
    if ([NSArray isValidArray:self])
    {
        NSArray *result = [self valueForKeyPath:@"length"];
        return result;
    }
    
    return nil;
}

/**
 *  NSNumber数组中快速计算数组求和NSNumber
 *
 *  @return NSNumber数组中快速计算数组求和NSNumber
 */
- (NSNumber *)sumObjectInArray
{
    if ([NSArray isValidArray:self])
    {
        // @"@sum.floatValue" @"@sum.self"
        NSNumber *result = [self valueForKeyPath:@"@sum.floatValue"];
        return result;
    }
    
    return nil;
}

/**
 *  NSNumber数组中快速计算数组平均数Number
 *
 *  @return NSNumber数组中快速计算数组平均数Number
 */
- (NSNumber *)averageObjectInArray
{
    if ([NSArray isValidArray:self])
    {
        // @"@avg.floatValue" @"@avg.self"
        NSNumber *result = [self valueForKeyPath:@"@avg.floatValue"];
        return result;
    }
    
    return nil;
}

/**
 *  NSNumber数组中获取最大值NSNumber
 *
 *  @return NSNumber数组中获取最大值NSNumber
 */
- (NSNumber *)maxObjectInArray
{
    if ([NSArray isValidArray:self])
    {
        // @"@max.floatValue" @"@max.self"
        NSNumber *result = [self valueForKeyPath:@"@max.floatValue"];
        return result;
    }
    
    return nil;
}

/**
 *  NSNumber数组中获取最小值NSNumber
 *
 *  @return 获取最小值NSNumber
 */
- (NSNumber *)minObjectInArray
{
    if ([NSArray isValidArray:self])
    {
        // @"@min.floatValue" @"@min.self"
        NSNumber *result = [self valueForKeyPath:@"@min.floatValue"];
        return result;
    }
    
    return nil;
}

/**
 *  字符串数组剔除重复数据后的数组
 *
 *  @return 剔除重复数据后的数组
 */
- (NSArray *)distinctArray
{
    if ([NSArray isValidArray:self])
    {
        NSArray *result = [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
        return result;
    }
    
    return nil;
}

@end
