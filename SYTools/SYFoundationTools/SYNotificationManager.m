//
//  SYNotificationManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-6-12.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "SYNotificationManager.h"

// 定义通知名称
static NSString *const kNotificationDemo = @"NotificationDemo";   // 示例


@implementation SYNotificationManager

/****************************************************************/

/// 示例 发送通知
+ (void)postNotificationDemo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDemo object:nil];
}

/// 示例 接收通知
+ (void)receiveNotificationDemo:(id)delegate sel:(SEL)selector
{
    [self removeNotificationDemo:delegate];
    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:selector name:kNotificationDemo object:nil];
}

/// 示例 移除通知
+ (void)removeNotificationDemo:(id)object
{
    [[NSNotificationCenter defaultCenter] removeObserver:object name:kNotificationDemo object:nil];
}

/****************************************************************/

@end
