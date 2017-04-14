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
    NSUserDefaultsSave(@(isFirst), kUserdefaultDemo);
}

/// 示例 获取值
+ (BOOL)GetValueDemo
{
    NSNumber *number = NSUserDefaultsRead(kUserdefaultDemo);
    return number.boolValue;
}

/// 示例 删除值
+ (void)DeleteValueDemo
{
    NSUserDefaultsRemove(kUserdefaultDemo);
}

/************************************************************************/



/************************************************************************/

@end
