//
//  NSUserDefaults+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSUserDefaults+SYCategory.h"

@implementation NSUserDefaults (SYCategory)

/// 保存信息
void NSUserDefaultsSave(id object, NSString *key)
{
    if (object && (key && [key isKindOfClass:[NSString class]] && 0 < key.length))
    {
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/// 读取保存的信息
id NSUserDefaultsRead(NSString *key)
{
    id object = nil;
    
    if (key && [key isKindOfClass:[NSString class]] && 0 < key.length)
    {
        object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    
    return object;
}

/// 删除保存的信息
void NSUserDefaultsRemove(NSString *key)
{
    if (key && [key isKindOfClass:[NSString class]] && 0 < key.length)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
