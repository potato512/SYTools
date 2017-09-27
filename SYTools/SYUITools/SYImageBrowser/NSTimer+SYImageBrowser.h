//
//  NSTimer+SYImageBrowser.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/5/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 回调代码块
typedef void (^TimerBlock)(NSTimer *timer);

@interface NSTimer (SYImageBrowser)

/// 带回调的实例化方法
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)time userInfo:(id)userInfo repeats:(BOOL)isRepeat handle:(TimerBlock)handle;

/// 停止
- (void)timerStop;

/// 开始
- (void)timerStart;

/// 释放
- (void)timerKill;

@end
