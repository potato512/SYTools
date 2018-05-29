//
//  NSString+SYNetwork.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/2/7.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//  网络相关的，如IP地址，网络名称

#import "NSString+SYNetwork.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation NSString (SYNetwork)

/**
 *  获取设备 ip 地址
 *
 *  @return ip 地址字符串
 */
+ (NSString *)IPAddress
{
    NSString *address = nil;
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (0 == success)
    {
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET)
            {
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    return address;
}

// wifi信息
+ (NSDictionary *)WiFiInfo
{
    NSArray *ifs = (id)CFBridgingRelease(CNCopySupportedInterfaces());
    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs)
    {
        info = (id)CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)ifnam));
        if (info && [info count])
        {
            break;
        }
    }
    return info;
}

// wifi名称
+ (NSString *)WiFiName
{
    NSDictionary *dict = [self WiFiInfo];
    NSString *wifiName = [dict objectForKey:@"SSID"];
    return wifiName;
}

@end
