//
//  NSString+SYUUID.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/2/7.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "NSString+SYUUID.h"

// https://github.com/soffes/SAMKeychain
#import <SAMKeychain/SAMKeychain.h>

static NSString *const UUIDService = @"UUIDService";
static NSString *const UUIDAccount = @"UUIDAccount";

@implementation NSString (SYUUID)

+ (NSString *)UUID
{
    // 每次都不一样
//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    CFStringRef string = CFUUIDCreateString(NULL, uuid);
//    CFRelease(uuid);
//    return (__bridge_transfer NSString *)string;
    
    // 保存在keychain，保证每次都一样
    NSString *uuidText = [SAMKeychain passwordForService:UUIDService account:UUIDAccount];
    if (uuidText == nil || uuidText.length == 0)
    {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        uuidText = (__bridge_transfer NSString *)string;
        BOOL rs = [SAMKeychain setPassword:uuidText forService:UUIDService account:UUIDAccount];
        assert(rs != NO);
    }
    return uuidText;
}

@end
