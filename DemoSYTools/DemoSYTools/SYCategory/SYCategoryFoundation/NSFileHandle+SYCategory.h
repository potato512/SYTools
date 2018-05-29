//
//  NSFileHandle+SYCategory.h
//  zhangshaoyu
//
//  Created by herman on 2017/7/1.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

/*
 读取数据时，读取的是NSData，后再转换成NSString，当出现转换NSString为nil时，是因为NSData为不完全的。
 NNString的中文字符1位对应转换成NSData时是3位。
 所以在指定位置，指定长度时，需要以NSData来计算。
 
 */


#import <Foundation/Foundation.h>

@interface NSFileHandle (SYCategory)

#pragma mark - 写数据

/**
 *  写入内容到指定位置
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *  @param content  内容
 *  @param position 位置
 */
+ (void)writeFileWithFilePath:(NSString *)filePath content:(NSString *)content position:(unsigned long long)position;

/**
 *  写入内容到文件末尾
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *  @param content  内容
 */
+ (void)writeFileBackWithFilePath:(NSString *)filePath content:(NSString *)content;

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
+ (NSString *)readFileWithFilePath:(NSString *)filePath position:(unsigned long long)position length:(NSUInteger)length;

/**
 *  读取文件内容
 *
 *  @param filePath 文件路径（如：xxx/xx/.../xx.txt）
 *
 *  @return NSString
 */
+ (NSString *)readFileWithFilePath:(NSString *)filePath;

#pragma mark - 复制文件

/**
 *  复制文件内容
 *
 *  @param fromPath 复制前原文件路径（如：xxx/xxx/.../xx.txt）
 *  @param toPath   复制后新文件路径（如：xaxa/abxx/../aaa.txt）
 */
+ (void)copyFileWithFilePath:(NSString *)fromPath toPath:(NSString *)toPath;

@end
