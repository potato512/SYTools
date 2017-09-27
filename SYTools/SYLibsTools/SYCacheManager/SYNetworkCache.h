//
//  SYNetworkCache.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/29.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//  缓存设置

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 缓存策略
typedef NS_ENUM(NSInteger, RequestCacheType)
{
    /// 无缓存，总是请求最新的数据
    RequestCacheTypeDefault = 0,
    
    /// 无视缓存，总是请求最新的数据
    RequestCacheTypeAlways = 1,
    
    /// 缓存过期时，才请求最新的数据
    RequestCacheTypeWhileOverdue = 2,
    
    /// 不做缓存处理
    RequestCacheTypeNever = 3,
};


/// 缓存时间长短 1 week
static CGFloat const RequestCacheTimeWeek = (60 * 60 * 24 * 7);
/// 缓存时间长短 1 day
static CGFloat const RequestCacheTimeDay = (60 * 60 * 24);
/// 缓存时间长短 1 hour
static CGFloat const RequestCacheTimeHour = (60 * 60);


@interface SYNetworkCache : NSObject


/// 单例
+ (SYNetworkCache *)shareCache;


/// 缓存数据
- (void)saveNetworkCacheData:(NSData *)responseData cachekey:(NSString *)urlKey cacheTime:(NSTimeInterval)expiresInSeconds;
/// 获取指定缓存数据
- (NSData *)getNetworkCacheContentWithCacheKey:(NSString *)urlKey;
/// 清除指定的数据
- (void)deleteNetworkCacheWithKey:(NSString *)urlKey;

/// 计算缓存数据库文件大小
- (NSString *)networkCacheSize;
/// 清除缓存（是否删除表）
- (void)networkCacehClear:(BOOL)dropTable;


@end