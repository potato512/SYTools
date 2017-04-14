//
//  SYNotificationManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-6-12.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：用于信息广播统一管理类

#import <Foundation/Foundation.h>

@interface SYNotificationManager : NSObject

/****************************************************************/

/// 示例 发送通知
+ (void)postNotificationDemo;

/// 示例 接收通知
+ (void)receiveNotificationDemo:(id)delegate sel:(SEL)selector;

/// 示例 移除通知
+ (void)removeNotificationDemo:(id)object;

/****************************************************************/


/****************************************************************/

@end
