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

/// 商品筛选按钮 发送通知
+ (void)postNotificationFilterButton:(BOOL)isSelected;

/// 商品筛选按钮 接收通知
+ (void)receiveNotificationFilterButtonHandle:(void (^)(NSNotification *notification))handle;

/// 商品筛选按钮 移除通知
+ (void)removeNotificationFilterButton;

/****************************************************************/

/// 接收极光推送发出的通知
+ (void)postNotificationJPush:(id)object;

/// 接收极光推送发出的通知，重新刷新数据
+ (void)receiveNotificationJPush:(id)target sel:(SEL)selector;

/// 移除通知-接收极光推送发出的通知
+ (void)removeNotificationJPush:(id)target;

/****************************************************************/

// 接收登录成功发出的通知
+ (void)postNotificationLogin:(id)object;

// 接收登录成功发出的通知，重新刷新数据
+ (void)receiveNotificationLogin:(id)target sel:(SEL)selector;

// 移除通知-接收登录成功发出的通知
+ (void)removeNotificationLogin:(id)target;

/****************************************************************/

// 接收登录退出成功发出的通知
+ (void)postNotificationLoginOut:(id)object;

// 接收登录退出成功发出的通知，重新刷新数据
+ (void)receiveNotificationLoginOut:(id)target sel:(SEL)selector;

// 移除通知-接收登录退出成功发出的通知
+ (void)removeNotificationLoginOut:(id)target;

/****************************************************************/

/// 接收消息数量变化发出的通知
+ (void)postNotificationChangeMessageNumber;

/// 接收消息数量变化发出的通知，重新刷新数据
+ (void)receiveNotificationChangeMessageNumber:(void (^)())selector;

/// 移除消息数量变化发出的通知
+ (void)removeNotificationChangeMessageNumber;

/****************************************************************/

/// 修改联系人发出通知
+ (void)postNotificationModifyContactsWithContactsDict:(NSDictionary *)dict;

/// 接收消息数量变化发出的通知，重新刷新数据
+ (void)receiveNotificationModifyContacts:(void (^)(NSNotification *notification))handle;

/// 移除修改联系人发出的通知
+ (void)removeNotificationModifyContacts;

/****************************************************************/

/// 单品页中修改商品规格发出通知
+ (void)postNotificationModifyGoodsDetailAttributedWithText:(NSString *)text;

/// 单品页中接收修改商品规格变化发出的通知，重新刷新数据
+ (void)receiveNotificationModifyGoodsDetailAttributed:(void (^)(NSNotification *))handle;

/// 单品页中移除修改商品规格发出的通知
+ (void)removeNotificationModifyGoodsDetailAttributed;

/****************************************************************/

/// 发出添加商品到购物车成功后的通知
+ (void)postNotificationAddCart;

/// 接收添加商品到购物车成功后的通知，重新刷新数据
+ (void)receiveNotificationAddCart:(void (^)(NSNotification *))handle;

/// 删除添加商品到购物车成功后的通知
+ (void)removeNotificationAddCart;

/****************************************************************/

/// 发出生成订单成功后的通知
+ (void)postNotificationAddOrder;

/// 接收生成订单成功后的通知，重新刷新购物车数据
+ (void)receiveNotificationAddOrder:(void (^)(NSNotification *))handle;

/// 删除生成订单成功后的通知
+ (void)removeNotificationAddOrder;

/****************************************************************/

@end
