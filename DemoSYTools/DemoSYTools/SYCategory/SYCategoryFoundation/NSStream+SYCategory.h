//
//  NSStream+SYCategory.h
//  zhangshaoyu
//
//  Created by herman on 2017/7/2.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStream (SYCategory)

/**
 *  读取文件内容
 *
 *  @param filePath 文件路径
 *  @param length   读取长度
 *
 *  @return NSString
 */
+ (NSString *)readFileStreamWithFilePath:(NSString *)filePath length:(NSInteger)length;

@end
