//
//  SYUserDefaultManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-7-17.
//
//

#import "SYUserDefaultManager.h"

// 存取键名称
static NSString *const kUserdefaultDemo = @"UserdefaultDemo"; // 示例

@implementation SYUserDefaultManager

/************************************************************************/

/// 示例 保存值
+ (void)SaveValueDemo:(BOOL)isFirst
{
    [[NSUserDefaults standardUserDefaults] setObject:@(isFirst) forKey:kUserdefaultDemo];
}

/// 示例 获取值
+ (BOOL)GetValueDemo
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kUserdefaultDemo];
    return number.boolValue;
}

/// 示例 删除值
+ (void)DeleteValueDemo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserdefaultDemo];
}

/************************************************************************/

@end
