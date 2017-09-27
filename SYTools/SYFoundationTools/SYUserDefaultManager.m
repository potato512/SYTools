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
static NSString *const kUserdefaultUserHeader = @"UserdefaultUserHeader"; // 保存登录成功的用户头像
static NSString *const keyReceiveJPushMessage = @"keyReceiveJPushMessage";
static NSString *const keyRemoteNotification = @"keyRemoteNotification";
static NSString *const keyModuleImageUrl = @"keyModuleImageUrl";

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

/// 用户头像 保存值
+ (void)SaveValueUserHeader:(NSString *)headerImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:headerImage];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSUserDefaultsSave(data, kUserdefaultUserHeader);
    });
}

/// 用户头像 获取值
+ (void)GetValueUserHeader:(void (^)(UIImage *image))handle
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = NSUserDefaultsRead(kUserdefaultUserHeader);
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handle)
            {
                handle(image);
            }
        });
    });
}

/// 用户头像 删除值
+ (void)DeleteValueUserHeader
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUserDefaultsRemove(kUserdefaultUserHeader);
    });
}

/************************************************************************/

/// 保存极光推送消息数量
+ (void)SaveJPushMessageNumber:(NSNumber *)number
{
    NSUserDefaultsSave(number, keyReceiveJPushMessage);
}

/// 获取极光推送消息数量
+ (NSNumber *)GetJPushMessageNumber
{
    NSNumber *number = NSUserDefaultsRead(keyReceiveJPushMessage);
    return number;
}

/************************************************************************/

/// 保存极光推送消息启动APP
+ (void)SaveRemoteNotification:(NSDictionary *)dict
{
    NSUserDefaultsSave(dict, keyRemoteNotification);
}

/// 获取极光推送消息启动APP
+ (NSDictionary *)GetRemoteNotification
{
    NSDictionary *dict = NSUserDefaultsRead(keyRemoteNotification);
    return dict;
}

/// 移除极光推送消息启动APP
+ (void)RemoveRemoteNotification
{
    NSUserDefaultsRemove(keyRemoteNotification);
}

/************************************************************************/

/// 保存组件中的图片头地址
+ (void)SaveModuleImageUrl:(NSString *)url
{
    NSUserDefaultsSave(url, keyModuleImageUrl);
}

/// 获取组件中的图片头地址
+ (NSString *)GetModuleImageUrl
{
    NSString *url = NSUserDefaultsRead(keyModuleImageUrl);
    if (url.length == 0)
    {
        url = @"http://error/";
    }
    return url;
}

/// 移除组件中的图片头地址
+ (void)RemoveModuleImageUrl
{
    NSUserDefaultsRemove(keyModuleImageUrl);
}

/************************************************************************/

@end
