//
//  SYUserDefaultManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-7-17.
//  功能描述：使用NSUserDefault进入基本数据存储操作
//

#import <Foundation/Foundation.h>

@interface SYUserDefaultManager : NSObject

/************************************************************************/

/// 示例 保存值
+ (void)SaveValueDemo:(BOOL)isFirst;

/// 示例 获取值
+ (BOOL)GetValueDemo;

/// 示例 删除值
+ (void)DeleteValueDemo;

/************************************************************************/

/// 用户头像 保存值
+ (void)SaveValueUserHeader:(NSString *)headerImage;

/// 用户头像 获取值
+ (void)GetValueUserHeader:(void (^)(UIImage *image))handle;

/// 用户头像 删除值
+ (void)DeleteValueUserHeader;

/************************************************************************/

/// 保存极光推送消息数量
+ (void)SaveJPushMessageNumber:(NSNumber *)number;

/// 获取极光推送消息数量
+ (NSNumber *)GetJPushMessageNumber;

/************************************************************************/

/// 保存极光推送消息启动APP
+ (void)SaveRemoteNotification:(NSDictionary *)dict;

/// 获取极光推送消息启动APP
+ (NSDictionary *)GetRemoteNotification;

/// 移除极光推送消息启动APP
+ (void)RemoveRemoteNotification;

/************************************************************************/

/// 保存组件中的图片头地址
+ (void)SaveModuleImageUrl:(NSString *)url;

/// 获取组件中的图片头地址
+ (NSString *)GetModuleImageUrl;

/// 移除组件中的图片头地址
+ (void)RemoveModuleImageUrl;

/************************************************************************/

@end
