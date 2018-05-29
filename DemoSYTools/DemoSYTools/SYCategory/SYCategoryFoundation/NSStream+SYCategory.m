//
//  NSStream+SYCategory.m
//  zhangshaoyu
//
//  Created by herman on 2017/7/2.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSStream+SYCategory.h"
#import "NSFileManager+SYCategory.h"

@implementation NSStream (SYCategory)

/**
 *  读取文件内容
 *
 *  @param filePath 文件路径
 *  @param length   读取长度
 *
 *  @return NSString
 */
+ (NSString *)readFileStreamWithFilePath:(NSString *)filePath length:(NSInteger)length
{
    if ([NSFileManager isFileExists:filePath])
    {
        // 通过流打开一个文件
        NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:filePath];
        [inputStream open];
        
        NSInteger bufferLength = length;
        uint8_t bufferRead[bufferLength];
        
        // 是否已经到结尾标识
        BOOL isEnd = NO;
        while (!isEnd)
        {
            NSInteger bytesRead = [inputStream read:bufferRead maxLength:bufferLength];
            if (bytesRead == 0)
            {
                // 文件读取到最后
                isEnd = YES;
            }
            else if (bytesRead == -1)
            {
                // 文件读取错误
                isEnd = YES;
            }
            else
            {
                NSString *text = [[NSString alloc] initWithBytesNoCopy:bufferRead length:bytesRead encoding:NSUTF8StringEncoding freeWhenDone: NO];
                return text;
            }
        }
        [inputStream close];
    }
    return nil;
}

@end
