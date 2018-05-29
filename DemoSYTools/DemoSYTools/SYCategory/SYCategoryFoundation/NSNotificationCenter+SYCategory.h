//
//  NSNotificationCenter+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (SYCategory)

/**
 *  发送通知
 *
 *  @param name 通知名称
 *  @param dict 通知协带参数
 */
void NSNotificationCenterPost(NSString *name, NSDictionary *dict);

/**
 *  接收通知
 *
 *  @param name   通知名称
 *  @param target 通知中执行方法的对象
 *  @param action 通知中响应的方法
 */
void NSNotificationCenterReceive(NSString *name, id target, SEL action);

/**
 *  移除通知
 *
 *  @param name   通知名称
 *  @param target 通知中执行方法的对象
 */
void NSNotificationCenterRemove(NSString *name, id target);

/************************************************************************************************************/

/**
 *  发送通知
 *  add by zhangshaoyu, 2017-04-20
 *  @param name 通知名称
 *  @param dict 通知携带参数
 */
- (void)postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)dict;

/**
 *  接收通知
 *  add by zhangshaoyu, 2017-04-20
 *  @param name   通知名称
 *  @param target 响应对象
 *  @param action 响应方法
 */
- (void)receiveNotificationWithName:(NSString *)name target:(id)target selector:(SEL)action;

/**
 *  接收通知并执行回调
 *  add by zhangshaoyu, 2017-04-20
 *  @param name   通知名称
 *  @param handle 响应回调
 */
- (void)receiveNotificationWithName:(NSString *)name handle:(void (^)(NSNotification *notification))handle;

/**
 *  移除通知
 *  add by zhangshaoyu, 2017-04-20
 *  @param name   通知名称
 *  @param target 响应对象
 */
- (void)removeNotificationWithName:(NSString *)name target:(id)target;


@end
