//
//  NSDictionary+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSDictionary+SYCategory.h"

@implementation NSDictionary (SYCategory)

#pragma mark - 异常判断

/// 是否是字典判断
- (BOOL)isNSDictionary
{
    if ([self isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    
    return NO;
}

/// 非空字典判断
+ (BOOL)isValidNSDictionary:(NSDictionary *)dictionary
{
    if ([dictionary isNSDictionary] && 0 < dictionary.count && dictionary != nil)
    {
        return YES;
    }
    
    return NO;
}

@end
