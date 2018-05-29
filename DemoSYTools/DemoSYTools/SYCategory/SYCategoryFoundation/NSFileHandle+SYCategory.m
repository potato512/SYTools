//
//  NSFileHandle+SYCategory.m
//  zhangshaoyu
//
//  Created by herman on 2017/7/1.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSFileHandle+SYCategory.h"

@implementation NSFileHandle (SYCategory)

#pragma mark - 写数据

/**
 *  写入内容到指定位置
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *  @param content  内容
 *  @param position 位置
 */
+ (void)writeFileWithFilePath:(NSString *)filePath content:(NSString *)content position:(unsigned long long)position
{
    NSFileHandle *fielHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    // 将节点跳到文件指定位置
    [fielHandle seekToFileOffset:position];
    // 写入内容
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 追加写入数据
    [fielHandle writeData:data];
    [fielHandle closeFile];
}

/**
 *  写入内容到文件末尾
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *  @param content  内容
 */
+ (void)writeFileBackWithFilePath:(NSString *)filePath content:(NSString *)content
{
    NSFileHandle *fielHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    // 将节点跳到文件末尾
    [fielHandle seekToEndOfFile];
    // 写入内容
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 追加写入数据
    [fielHandle writeData:data];
    [fielHandle closeFile];
}

#pragma mark - 读数据

/**
 *  读取文件指定位置后指定长度的内容
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *  @param position 指定位置
 *  @param length   指定长度
 *
 *  @return NSString
 */
+ (NSString *)readFileWithFilePath:(NSString *)filePath position:(unsigned long long)position length:(NSUInteger)length
{
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    // 偏移量文件
    [fileHandle seekToFileOffset:position];
    NSData *data = [fileHandle readDataOfLength:length];
    [fileHandle closeFile];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return text;
}

/**
 *  读取文件内容
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *
 *  @return NSString
 */
+ (NSString *)readFileWithFilePath:(NSString *)filePath
{
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData *data = [fileHandle readDataToEndOfFile];
    [fileHandle closeFile];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return text;
}

#pragma mark - 复制文件

/**
 *  复制文件内容
 *
 *  @param fromPath 复制前原文件路径（如：xxx/xxx/.../xx.txt）
 *  @param toPath   复制后新文件路径（如：xaxa/abxx/../aaa.txt）
 */
+ (void)copyFileWithFilePath:(NSString *)fromPath toPath:(NSString *)toPath
{
    // 输入文件
    NSFileHandle *infile = [NSFileHandle fileHandleForReadingAtPath:fromPath];
    // 读取的缓冲数据 读取数据
    NSData *buffer = [infile readDataToEndOfFile];
    [infile closeFile];
    
    // 输出文件
    NSFileHandle *outfile = [NSFileHandle fileHandleForWritingAtPath:toPath];
    // 将输出文件的长度设为0
    [outfile truncateFileAtOffset:0];
    // 写入输入
    [outfile writeData:buffer];
    [outfile closeFile];
}

@end
