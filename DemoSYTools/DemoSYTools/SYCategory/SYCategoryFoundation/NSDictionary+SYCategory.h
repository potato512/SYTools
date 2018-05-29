//
//  NSDictionary+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SYCategory)

#pragma mark - 异常判断

/// 是否是字典判断
- (BOOL)isNSDictionary;

/// 非空字典判断
+ (BOOL)isValidNSDictionary:(NSDictionary *)dictionary;

@end
