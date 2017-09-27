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
static NSString *const kNotificationFilterButton = @"NotificationFilterButton";   // 商品筛选按钮
static NSString *const receiveJPushMessage = @"receiveJPushMessage"; // 极光推送通知
static NSString *const kNotificationLoginStatus = @"kNotificationLoginStatus"; // 登录状态通知
static NSString *const kNotificationLoginOutStatus = @"kNotificationLoginOutStatus"; // 登录退出状态通知
static NSString *const kNotificationChangeMessageNumber = @"kNotificationChangeMessageNumber"; // 消息数量改变通知
static NSString *const kNotificationModifyContacts = @"kNotificationModifyContacts"; // 联系人改变通知

static NSString *const kNotificationModifyGoodsDetailAttributed = @"ModifyGoodsDetailAttributed"; // 单品页中商品规格选择改变通知

static NSString *const kNotificationAddCart = @"AddCart"; // 添加到购物车后的通知

static NSString *const kNotificationAddOrder = @"AddOrder"; // 生成订单后的通知

static NSString *const kNotificationChangeHeadImage = @"ChangeHeadImage"; // 修改头像后的通知

@implementation SYNotificationManager

/****************************************************************/

/// 示例 发送通知
+ (void)postNotificationDemo
{
    NSNotificationCenterPost(kNotificationDemo, nil);
}

/// 示例 接收通知
+ (void)receiveNotificationDemo:(id)delegate sel:(SEL)selector
{
    [self removeNotificationDemo:delegate];
    NSNotificationCenterReceive(kNotificationDemo, delegate, selector);
}

/// 示例 移除通知
+ (void)removeNotificationDemo:(id)object
{
    NSNotificationCenterRemove(kNotificationDemo, object);
}

/****************************************************************/

/// 商品筛选按钮 发送通知
+ (void)postNotificationFilterButton:(BOOL)isSelected
{
    NSDictionary *dict = @{@"isSelected":@(isSelected)};
    [[NSNotificationCenter defaultCenter] postNotificationWithName:kNotificationFilterButton userInfo:dict];
}

/// 商品筛选按钮 接收通知
+ (void)receiveNotificationFilterButtonHandle:(void (^)(NSNotification *notification))handle
{
    [self removeNotificationFilterButton];
    [[NSNotificationCenter defaultCenter] receiveNotificationWithName:kNotificationFilterButton handle:handle];
}

/// 商品筛选按钮 移除通知
+ (void)removeNotificationFilterButton
{
    [[NSNotificationCenter defaultCenter] removeNotificationWithName:kNotificationFilterButton target:nil];
}

/****************************************************************/

// 接收极光推送发出的通知
+ (void)postNotificationJPush:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:receiveJPushMessage object:object];
}

// 接收极光推送发出的通知，重新刷新数据
+ (void)receiveNotificationJPush:(id)target sel:(SEL)selector
{
    [self removeNotificationJPush:target];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:receiveJPushMessage object:nil];
}

// 移除通知-接收极光推送发出的通知
+ (void)removeNotificationJPush:(id)target
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:receiveJPushMessage object:nil];
}

/****************************************************************/

// 接收登录成功发出的通知
+ (void)postNotificationLogin:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStatus object:object];
}

// 接收登录成功发出的通知，重新刷新数据
+ (void)receiveNotificationLogin:(id)target sel:(SEL)selector
{
    [self removeNotificationLogin:target];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:kNotificationLoginStatus object:nil];
}

// 移除通知-接收登录成功发出的通知
+ (void)removeNotificationLogin:(id)target
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:kNotificationLoginStatus object:nil];
}

/****************************************************************/

// 接收登录退出成功发出的通知
+ (void)postNotificationLoginOut:(id)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginOutStatus object:object];
}

// 接收登录退出成功发出的通知，重新刷新数据
+ (void)receiveNotificationLoginOut:(id)target sel:(SEL)selector
{
    [self removeNotificationLoginOut:target];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:kNotificationLoginOutStatus object:nil];
}

// 移除通知-接收登录退出成功发出的通知
+ (void)removeNotificationLoginOut:(id)target
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:kNotificationLoginOutStatus object:nil];
}

/****************************************************************/

// 接收消息数量变化发出的通知
+ (void)postNotificationChangeMessageNumber
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeMessageNumber object:nil];
}

// 接收消息数量变化发出的通知，重新刷新数据
+ (void)receiveNotificationChangeMessageNumber:(void (^)())selector
{
    [self removeNotificationChangeMessageNumber];
    [[NSNotificationCenter defaultCenter] receiveNotificationWithName:kNotificationChangeMessageNumber handle:selector];
}

// 移除消息数量变化发出的通知
+ (void)removeNotificationChangeMessageNumber
{
    [[NSNotificationCenter defaultCenter] removeNotificationWithName:kNotificationChangeMessageNumber target:nil];
}

/****************************************************************/

/// 修改联系人发出通知
+ (void)postNotificationModifyContactsWithContactsDict:(NSDictionary *)dict
{
    [[NSNotificationCenter defaultCenter] postNotificationWithName:kNotificationModifyContacts userInfo:dict];
}

/// 接收消息数量变化发出的通知，重新刷新数据
+ (void)receiveNotificationModifyContacts:(void (^)(NSNotification *))handle
{
    [self removeNotificationModifyContacts];
    [[NSNotificationCenter defaultCenter] receiveNotificationWithName:kNotificationModifyContacts handle:handle];
}

/// 移除修改联系人发出的通知
+ (void)removeNotificationModifyContacts
{
   [[NSNotificationCenter defaultCenter] removeNotificationWithName:kNotificationModifyContacts target:nil];
}

/****************************************************************/

/// 单品页中修改商品规格发出通知
+ (void)postNotificationModifyGoodsDetailAttributedWithText:(NSString *)text
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifyGoodsDetailAttributed object:text];
}

/// 单品页中接收修改商品规格变化发出的通知，重新刷新数据
+ (void)receiveNotificationModifyGoodsDetailAttributed:(void (^)(NSNotification *))handle
{
    [self removeNotificationModifyGoodsDetailAttributed];
    [[NSNotificationCenter defaultCenter] receiveNotificationWithName:kNotificationModifyGoodsDetailAttributed handle:handle];
}

/// 单品页中移除修改商品规格发出的通知
+ (void)removeNotificationModifyGoodsDetailAttributed
{
    [[NSNotificationCenter defaultCenter] removeNotificationWithName:kNotificationModifyGoodsDetailAttributed target:nil];
}

/****************************************************************/

/// 发出添加商品到购物车成功后的通知
+ (void)postNotificationAddCart
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAddCart object:nil];
}

/// 接收添加商品到购物车成功后的通知，重新刷新数据
+ (void)receiveNotificationAddCart:(void (^)(NSNotification *))handle
{
    [self removeNotificationAddCart];
    [[NSNotificationCenter defaultCenter] receiveNotificationWithName:kNotificationAddCart handle:handle];
}

/// 删除添加商品到购物车成功后的通知
+ (void)removeNotificationAddCart
{
    [[NSNotificationCenter defaultCenter] removeNotificationWithName:kNotificationAddCart target:nil];
}

/****************************************************************/

/// 发出生成订单成功后的通知
+ (void)postNotificationAddOrder
{
   [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAddOrder object:nil];
}

/// 接收生成订单成功后的通知，重新刷新购物车数据
+ (void)receiveNotificationAddOrder:(void (^)(NSNotification *))handle
{
    [self removeNotificationAddOrder];
    [[NSNotificationCenter defaultCenter] receiveNotificationWithName:kNotificationAddOrder handle:handle];
}

/// 删除生成订单成功后的通知
+ (void)removeNotificationAddOrder
{
   [[NSNotificationCenter defaultCenter] removeNotificationWithName:kNotificationAddOrder target:nil];
}

/****************************************************************/

@end
