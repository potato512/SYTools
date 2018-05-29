//
//  NSString+SYNetwork.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/2/7.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYNetwork)

/**
 *  获取设备 ip 地址
 *
 *  @return ip 地址字符串
 */
+ (NSString *)IPAddress;

// wifi信息
+ (NSDictionary *)WiFiInfo;

// wifi名称
+ (NSString *)WiFiName;

@end
