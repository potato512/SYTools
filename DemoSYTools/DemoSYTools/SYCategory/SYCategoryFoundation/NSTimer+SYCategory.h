//
//  NSTimer+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TimerBlock)(NSTimer *timer);

@interface NSTimer (SYCategory)

/// 开启定时器
- (void)timerStart;

/// 关闭定时器
- (void)timerStop;

/// 永久停止定时器
- (void)timerKill;

/**
 *  实例化NSTimer（注意处理强引用：只能在使用的视图控制器中的处理，且不能在dealloc中处理）
 *
 *  @param time   时间间隔
 *  @param target 执行方法的对象
 *  @param action 执行的方法
 *  @param object 传递参数对象
 *  @param repeat 是否重复
 *
 *  @return NSTimer
 */
NSTimer *NSTimerInitialize(NSTimeInterval time, id target, SEL action, id object, BOOL repeat);

/// 实例化NSTimer（注意处理强引用 & 回调响应：可以在任意对象中处理）
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)time userInfo:(id)userInfo repeats:(BOOL)isRepeat handle:(TimerBlock)handle;

/// 倒计时
+ (void)timerGCDWithTimeInterval:(NSTimeInterval)time maxTimerInterval:(NSInteger)maxTime afterTime:(NSTimeInterval)afterTime handle:(void (^)(NSInteger remainTime))handle;

@end
