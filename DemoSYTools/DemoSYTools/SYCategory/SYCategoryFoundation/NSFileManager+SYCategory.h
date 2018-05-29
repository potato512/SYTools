//
//  NSFileManager+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSFileManager (SYCategory)

#pragma mark - 系统路径

/**
 *  Home目录路径
 *
 *  @return NSString
 */
+ (NSString *)getHomeDirectoryPath;

/**
 *  document目录路径
 *
 *  @return NSString
 */
+ (NSString *)getDocumentDirectoryPath;

/**
 *  Cache目录路径
 *
 *  @return NSString
 */
+ (NSString *)getCacheDirectoryPath;

/**
 *  Library目录路径
 *
 *  @return NSString
 */
+ (NSString *)getLibraryDirectoryPath;

/**
 *  Tmp目录路径
 *
 *  @return NSString
 */
+ (NSString *)getTmpDirectoryPath;

#pragma mark - 文件路径操作

/**
 *  文件，或文件夹是否存在
 *
 *  @param filepath 文件路径
 *
 *  @return BOOL
 */
+ (BOOL)isFileExists:(NSString *)filepath;

/**
 *  判断一个文件是否是文件还是文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return BOOL
 */
+ (BOOL)isDirectory:(NSString *)filePath;

/**
 *  新建文件路径（未在沙盒）
 *
 *  @param filePath 文件路径（如：xxx/xxx/xx/.../xx）
 *  @param fileName 文件名称（如：xx.txt）
 *
 *  @return NSString
 */
+ (NSString *)createFilePath:(NSString *)filePath fileName:(NSString *)fileName;

/**
 *  新建文件
 *
 *  @param filePath 文件路径
 *  @param fileName 文件名称，如xxx.png，或xxx/xx.png
 *
 *  @return NSString
 */
+ (NSString *)createFileWithFilePath:(NSString *)filePath fileName:(NSString *)fileName;

/**
 *  新建Document文件夹下的文件
 *
 *  @param fileName 文件名称（如：xx.png，download/xx.png）
 *
 *  @return NSString
 */
+ (NSString *)createFileDocumentWithFileName:(NSString *)fileName;

/**
 *  新建Cache文件夹下的文件
 *
 *  @param fileName 文件名称（如：xx.png，download/xx.png）
 *
 *  @return NSString
 */
+ (NSString *)createFileCacheWithFileName:(NSString *)fileName;

/**
 *  新建文件夹
 *
 *  @param filePath 文件路径
 *  @param fileName 目录名称，如xxx，或xxx/xxx
 *
 *  @return NSString
 */
+ (NSString *)createDirectoryWithFilePath:(NSString *)filePath fileName:(NSString *)fileName;

/**
 *  新建Document文件夹下的文件夹
 *
 *  @param fileName 文件夹名称（如：download，download/tmp）
 *
 *  @return NSString
 */
+ (NSString *)createDirectoryDocumentWithFileName:(NSString *)fileName;

/**
 *  新建Cache文件夹下的文件夹
 *
 *  @param fileName 文件夹名称（如：download，download/tmp）
 *
 *  @return NSString
 */
+ (NSString *)createDirectoryCacheWithFileName:(NSString *)fileName;

/**
 *  删除指定文件路径的文件，或文件夹
 *
 *  @param filePath 文件路径，或文件夹路径
 *
 *  @return BOOL
 */
+ (BOOL)deleteFileWithFilePath:(NSString *)filePath;

/**
 *  文件复制
 *
 *  @param fromPath 目标文件路径（如：xxx/xxx/.../xx.png）
 *  @param toPath   复制后文件路径（如：xxx/xxx/.../xx.png）
 *
 *  @return BOOL
 */
+ (BOOL)copyFileWithFilePath:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 *  文件移动
 *
 *  @param fromPath 移动前位置（如：xxx/xxx/.../xx.png）
 *  @param toPath   移动后位置（如：xxx/xxx/.../111/xx.png）
 *
 *  @return BOOL
 */

+ (BOOL)moveFileWithFilePath:(NSString *)fromPath toPath:(NSString *)toPath;

/**
 *  文件重新名
 *
 *  @param filePath 文件路径（如：xxx/xxx/.../xx.png）
 *  @param newName  文件新名称（如：xx11.png）
 *
 *  @return BOOL
 */
+ (BOOL)renameFileWithFilePath:(NSString *)filePath newName:(NSString *)newName;

#pragma mark - 文件数据

/**
 *  文件数据写入
 *
 *  @param filePath 文件路径（如：xxx/xxx/.../png.txt）
 *  @param data     文件数据（如：NSArray、NSDictionary、NSData、NSString）
 *
 *  @return BOOL
 */
+ (BOOL)writeFileWithFilePath:(NSString *)filePath data:(id)data;

/**
 *  指定文件路径的二进制数据
 *
 *  @param filePath 文件路径
 *
 *  @return NSData
 */
+ (NSData *)readFileWithFilePath:(NSString *)filePath;

#pragma mark - 文件信息

/**
 *  文件信息字典
 *
 *  @param filePath 文件路径
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)getFileAttributesWithFilePath:(NSString *)filePath;

#pragma mark 文件名称/文件类型

/**
 *  文件名称（如：hello.png）
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileNameWithFilePath:(NSString *)filePath;

/**
 *  文件类型（如：.png）
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileTypeWithFilePath:(NSString *)filePath;

/**
 *  文件类型（如：png）
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileTypeExtensionWithFilePath:(NSString *)filePath;

#pragma mark 文件夹下的所有/部分文件/文件夹

/**
 *  指定文件路径的所有层级子文件夹下的所有文件，及文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getSubFilesAllWithFilePath:(NSString *)filePath;

/**
 *  指定文件路径的当前层级文件夹下的文件，及文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getSubFilesSomeWithFilePath:(NSString *)filePath;

/**
 *  指定文件路径的当前层级的文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getDirectorysWithFilePath:(NSString *)filePath;

/**
 *  指定文件路径的所有层级的文件，子文件
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getFilesWithFilePath:(NSString *)filePath;

/**
 *  指定文件路径的文件，及文件夹
 *
 *  @param filePath    文件路径
 *  @param isDirectory 文件，或文件夹
 *  @param isAll       所有层级，或当前层级
 *
 *  @return NSArray
 */
+ (NSArray *)getSubFilesWithFilePath:(NSString *)filePath isDirectory:(BOOL)isDirectory isAll:(BOOL)isAll;

#pragma mark 文件大小

/**
 *  文件大小类型转换：数值型转字符型
 *
 *  1MB = 1024KB 1KB = 1024B
 *
 *  @param fileSize 文件大小
 *
 *  @return NSString
 */
+ (NSString *)fileSizeConversion:(CGFloat)fileSize;

/**
 *  单个文件的大小 CGFloat
 *
 *  @param filePath 文件路径
 *
 *  @return CGFloat
 */
+ (CGFloat)getFileSizeWithFilePath:(NSString *)filePath;

/**
 *  单个文件的大小 NSString
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileSizeTextWithFilePath:(NSString *)filePath;

/**
 *  文件夹的大小 CGFloat
 *
 *  @param directory 指定目录
 *
 *  @return CGFloat
 */
+ (CGFloat)getFileSizeTotalWithDirectory:(NSString *)directory;

/**
 *  文件夹的大小 NSString
 *
 *  @param directory 指定目录
 *
 *  @return NSString
 */
+ (NSString *)getFileSizeTotalTextWithDirectory:(NSString *)directory;

#pragma mark - 磁盘信息

/**
 *  磁盘空间总大小
 *
 *  @return CGFloat
 */
+ (CGFloat)getSizeDiskSpace;

/**
 *  磁盘空间总大小 NSString
 *
 *  @return NSString
 */
+ (NSString *)getSizeTextDiskSpace;

/**
 *  磁盘空间可用大小
 *
 *  @return CGFloat
 */
+ (CGFloat)getSizeFreeDiskSpace;

/**
 *  磁盘空间可用大小 NSString
 *
 *  @return NSString
 */
+ (NSString *)getSizeFreeTextDiskSpace;

#pragma mark - 临时文件

/**
 *  以时间（yyyyMMddHHmmssSSS）命名的临时文件名
 *
 *  @param NSString 文件类型（如.png、.txt等）
 *
 *  @return NSString
 */
+ (NSString *)newCacheFileNameWithType:(NSString *)type;

/**
 *  缓存目录下的临时文件路径
 *
 *  @param fileName 文件名称
 *
 *  @return NSString
 */
+ (NSString *)newCacheFilePathWithFileName:(NSString *)fileName;

/**
 *  保存临时图片文件
 *
 *  @param image    图片
 *  @param filePath 文件路径
 *
 *  @return BOOL
 */
+ (BOOL)saveCacheFileImage:(UIImage *)image filePath:(NSString *)filePath;

/**
 *  删除临时文件
 *
 *  @param fileDict 文件字典集合（key-文件名称、value-文件路径）
 */
+ (void)deleteCacheFile:(NSDictionary *)fileDict;

#pragma mark - 链式属性

/// 链式编程 home路径
+ (NSString *(^)())homePath;

/// 链式编程 document路径
+ (NSString *(^)())documentPath;

/// 链式编程 cache路径
+ (NSString *(^)())cachePath;

/// 链式编程 library路径
+ (NSString *(^)())libraryPath;

/// 链式编程 tmp路径
+ (NSString *(^)())tmpPath;

@end
