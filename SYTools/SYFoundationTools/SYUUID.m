//
//  SYUUID.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/4/7.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "SYUUID.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString *SYUDIDIdentifier = @"SYUDIDIdentifier";

static NSString *const UUIDService = @"UUIDService";
static NSString *const UUIDAccount = @"UUIDAccount";

@implementation SYUUID

+ (NSString *)UUID
{
    // 从手机设备的keyChain中获取（SSKeychain：https://github.com/samsoffes/sskeychain）
    NSString *result = [self KeychainUUID];
    return result;
}

+ (NSString *)KeychainUUID
{
    NSString *str = [SAMKeychain passwordForService:UUIDService account:UUIDAccount];
    if (str == nil || str.length == 0)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        NSString *uuid = (__bridge NSString *)CFUUIDCreateString (kCFAllocatorDefault,uuidRef);
        [SAMKeychain setPassword:uuid forService:UUIDService account:UUIDAccount];
        return uuid;
    }
    else
    {
        return str;
    }
}

@end
