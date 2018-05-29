//
//  NSFileManager+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSFileManager+SYCategory.h"

#include <sys/stat.h>
#include <dirent.h>


#define FileManager [NSFileManager defaultManager]


@implementation NSFileManager (SYCategory)

#pragma mark - 系统路径

/**
 *  Home目录路径
 *
 *  @return NSString
 */
+ (NSString *)getHomeDirectoryPath
{
    return NSHomeDirectory();
}

/**
 *  document目录路径
 *
 *  @return NSString
 */
+ (NSString *)getDocumentDirectoryPath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}

/**
 *  Cache目录路径
 *
 *  @return NSString
 */
+ (NSString *)getCacheDirectoryPath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}

/**
 *  Library目录路径
 *
 *  @return NSString
 */
+ (NSString *)getLibraryDirectoryPath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}

/**
 *  Tmp目录路径
 *
 *  @return NSString
 */
+ (NSString *)getTmpDirectoryPath
{
    return NSTemporaryDirectory();
}

#pragma mark - 文件路径操作

/**
 *  文件，或文件夹是否存在
 *
 *  @param filepath 文件路径
 *
 *  @return BOOL
 */
+ (BOOL)isFileExists:(NSString *)filepath
{
    return [FileManager fileExistsAtPath:filepath];
}

/**
 *  判断一个文件是否是文件还是文件夹
 *
 *  @param filePath 文件路径（如：xxx/xxx/xx/.../xx，或xx/xx/../xx.txt）
 *
 *  @return BOOL
 */
+ (BOOL)isDirectory:(NSString *)filePath
{
    // 方法1
//    BOOL isDirectory = NO;
//    [FileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
//    return isDirectory;
    
    // 方法2
    NSNumber *isDirectory;
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    [fileUrl getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
    return isDirectory.boolValue;
}

/**
 *  新建文件路径（未在沙盒）
 *
 *  @param filePath 文件路径（如：xxx/xxx/xx/.../xx）
 *  @param fileName 文件名称（如：xx.txt）
 *
 *  @return NSString
 */
+ (NSString *)createFilePath:(NSString *)filePath fileName:(NSString *)fileName
{
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    return path;
}

/**
 *  新建文件
 *
 *  @param filePath 文件路径
 *  @param fileName 文件名称，如xxx.png，或xxx/xx.png
 *
 *  @return NSString
 */
+ (NSString *)createFileWithFilePath:(NSString *)filePath fileName:(NSString *)fileName
{
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    if (![self isFileExists:path])
    {
        if (![FileManager createFileAtPath:path contents:nil attributes:nil])
        {
            return nil;
        }
    }
    return path;
}

/**
 *  新建Document文件夹下的文件
 *
 *  @param fileName 文件名称（如：xx.png，download/xx.png）
 *
 *  @return NSString
 */
+ (NSString *)createFileDocumentWithFileName:(NSString *)fileName
{
    return [self createFileWithFilePath:[self getDocumentDirectoryPath] fileName:fileName];
}

/**
 *  新建Cache文件夹下的文件
 *
 *  @param fileName 文件名称（如：xx.png，download/xx.png）
 *
 *  @return NSString
 */
+ (NSString *)createFileCacheWithFileName:(NSString *)fileName
{
    return [self createFileWithFilePath:[self getCacheDirectoryPath] fileName:fileName];
}

/**
 *  新建文件夹
 *
 *  @param filePath 文件路径
 *  @param fileName 目录名称，如xxx，或xxx/xxx
 *
 *  @return NSString
 */
+ (NSString *)createDirectoryWithFilePath:(NSString *)filePath fileName:(NSString *)fileName
{
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    if (![self isFileExists:path])
    {
        NSError *error;
        if (![FileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"create dir error: %@", error.debugDescription);
            return nil;
        }
    }
    return path;
}

/**
 *  新建Document文件夹下的文件夹
 *
 *  @param fileName 文件夹名称（如：download，download/tmp）
 *
 *  @return NSString
 */
+ (NSString *)createDirectoryDocumentWithFileName:(NSString *)fileName
{
    return [self createDirectoryWithFilePath:[self getDocumentDirectoryPath] fileName:fileName];
}

/**
 *  新建Cache文件夹下的文件夹
 *
 *  @param fileName 文件夹名称（如：download，download/tmp）
 *
 *  @return NSString
 */
+ (NSString *)createDirectoryCacheWithFileName:(NSString *)fileName
{
    return [self createDirectoryWithFilePath:[self getCacheDirectoryPath] fileName:fileName];
}

/**
 *  删除指定文件路径的文件，或文件夹
 *
 *  @param filePath 文件路径，或文件夹路径
 *
 *  @return BOOL
 */
+ (BOOL)deleteFileWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        return [FileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

/**
 *  文件复制
 *
 *  @param fromPath 目标文件路径（如：xxx/xxx/.../xx.png）
 *  @param toPath   复制后文件路径（如：xxx/xxx/.../xx.png）
 *
 *  @return BOOL
 */
+ (BOOL)copyFileWithFilePath:(NSString *)fromPath toPath:(NSString *)toPath
{
    if ([self isFileExists:fromPath])
    {
        return [FileManager copyItemAtPath:fromPath toPath:toPath error:nil];
    }
    return NO;
}

/**
 *  文件移动
 *
 *  @param fromPath 移动前位置（如：xxx/xxx/.../xx.png）
 *  @param toPath   移动后位置（如：xxx/xxx/.../111/xx.png）
 *
 *  @return BOOL
 */

+ (BOOL)moveFileWithFilePath:(NSString *)fromPath toPath:(NSString *)toPath
{
    if ([self isFileExists:fromPath])
    {
        return [FileManager moveItemAtPath:fromPath toPath:toPath error:nil];
    }
    return NO;
}

/**
 *  文件重新名
 *
 *  @param filePath 文件路径（如：xxx/xxx/.../xx.png）
 *  @param newName  文件新名称（如：xx11.png）
 *
 *  @return BOOL
 */
+ (BOOL)renameFileWithFilePath:(NSString *)filePath newName:(NSString *)newName
{
    // 相当于移动文件，只是在相同目录下移动，所以实现了重命名
    NSString *newPath = [[filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:newName];
    return [self moveFileWithFilePath:filePath toPath:newPath];
}

#pragma mark - 文件数据

/**
 *  文件数据写入
 *
 *  @param filePath 文件路径（如：xxx/xxx/.../png.txt）
 *  @param data     文件数据（如：NSArray、NSDictionary、NSData、NSString）
 *
 *  @return BOOL
 */
+ (BOOL)writeFileWithFilePath:(NSString *)filePath data:(id)data
{
    if (![self isFileExists:filePath])
    {
        filePath = [self createFileWithFilePath:filePath fileName:nil];
    }
    
    if ([data isKindOfClass:[NSArray class]] | [data isKindOfClass:[NSDictionary class]] | [data isKindOfClass:[NSString class]] | [data isKindOfClass:[NSData class]])
    {
        return [data writeToFile:filePath atomically:YES];
    }
    
    return NO;
}

/**
 *  指定文件路径的二进制数据
 *
 *  @param filePath 文件路径
 *
 *  @return NSData
 */
+ (NSData *)readFileWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        return [FileManager contentsAtPath:filePath];
    }
    return nil;
}

#pragma mark - 文件信息

/**
 *  文件信息字典
 *
 *  @param filePath 文件路径
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)getFileAttributesWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        return [FileManager attributesOfItemAtPath:filePath error:nil];
    }
    return nil;
}

#pragma mark 文件名称/文件类型

/**
 *  文件名称（如：hello.png）
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileNameWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        // 方法1
        NSRange range = [filePath rangeOfString:@"/" options:NSBackwardsSearch];
        if (range.location != NSNotFound)
        {
            NSString *text = [filePath substringFromIndex:(range.location + range.length)];
            return text;
        }
        
        return nil;
        
        // 方法2
//        NSString *fileName;
//        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
//        [fileUrl getResourceValue:&fileName forKey:NSURLNameKey error:nil];
//        return fileName;
    }
    
    return nil;
}

/**
 *  文件类型（如：.png）
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileTypeWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        NSRange range = [filePath rangeOfString:@"." options:NSBackwardsSearch];
        if (range.location != NSNotFound)
        {
            NSString *text = [filePath substringFromIndex:(range.location)];
            return text;
        }
        
        return nil;
    }
    
    return nil;
}

/**
 *  文件类型（如：png）
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileTypeExtensionWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        NSString *text = filePath.pathExtension;
        return text;
    }
    
    return nil;
}

#pragma mark 文件夹下的所有/部分文件/文件夹

/**
 *  指定文件路径的所有层级子文件夹下的所有文件，及文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getSubFilesAllWithFilePath:(NSString *)filePath
{
    NSArray *files = [FileManager subpathsAtPath:filePath];
    return files;
}

/**
 *  指定文件路径的当前层级文件夹下的文件，及文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getSubFilesSomeWithFilePath:(NSString *)filePath
{
    NSArray *files = [FileManager contentsOfDirectoryAtPath:filePath error:nil];
    return files;
}

/**
 *  指定文件路径的当前层级的文件夹
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getDirectorysWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        // NSURL *urlDirectory = [[NSBundle mainBundle] bundleURL];
        NSURL *urlDirectory = [NSURL fileURLWithPath:filePath];
        NSArray *array = [FileManager contentsOfDirectoryAtURL:urlDirectory
                                       includingPropertiesForKeys:@[]
                                                          options:NSDirectoryEnumerationSkipsHiddenFiles
                                                            error:nil];
        
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:array.count];
        for (NSURL *fileUrl in array)
        {
            [results addObject:fileUrl.path];
        }
        return results;
    }
    return nil;
}

/**
 *  指定文件路径的所有层级的文件，子文件
 *
 *  @param filePath 文件路径
 *
 *  @return NSArray
 */
+ (NSArray *)getFilesWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        // NSURL *urlFile = [[NSBundle mainBundle] bundleURL];
        NSURL *urlFile = [NSURL fileURLWithPath:filePath];
        NSDirectoryEnumerator *enumerator = [FileManager enumeratorAtURL:urlFile
                                              includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
                                                                 options:NSDirectoryEnumerationSkipsHiddenFiles
                                                            errorHandler:^BOOL(NSURL *url, NSError *error){
                                                                if (error)
                                                                {
                                                                    return NO;
                                                                }
                                                                
                                                                return YES;
                                                            }];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSURL *fileURL in enumerator)
        {
            NSString *filename;
            [fileURL getResourceValue:&filename forKey:NSURLNameKey error:nil];
            
            NSNumber *isDirectory;
            [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
            
            // Skip directories with '_' prefix, for example
            if ([filename hasPrefix:@"_"] && [isDirectory boolValue])
            {
                [enumerator skipDescendants];
                continue;
            }
            
            if (!isDirectory.boolValue)
            {
                // 转成文件路径
                [array addObject:fileURL.path];
            }
        }
        return array;
    }
    return nil;
}

/**
 *  指定文件路径的文件，及文件夹
 *
 *  @param filePath    文件路径
 *  @param isDirectory 文件，或文件夹
 *  @param isAll       所有层级，或当前层级
 *
 *  @return NSArray
 */
+ (NSArray *)getSubFilesWithFilePath:(NSString *)filePath isDirectory:(BOOL)isDirectory isAll:(BOOL)isAll
{
    NSMutableArray *directions = [NSMutableArray array];
    
    // 默认所有层级目录下的文件，及文件夹
    NSArray *files = [self getSubFilesAllWithFilePath:filePath];
    if (!isAll)
    {
        // 当前层级目录下的文件，及文件夹
        files = [self getSubFilesSomeWithFilePath:filePath];
    }
    
    for (id object in files)
    {
        NSString *objectPath = [filePath stringByAppendingPathComponent:object];
        BOOL isDir = [self isDirectory:objectPath];
        if (isDirectory)
        {
            // 文件夹
            if (isDir)
            {
                [directions addObject:object];
            }
        }
        else
        {
            // 文件
            if (!isDir)
            {
                [directions addObject:object];
            }
        }
    }
    
    return directions;
}

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
+ (NSString *)fileSizeConversion:(CGFloat)fileSize
{
    NSString *message = @"0.00B";
    
    // 1MB = 1024KB 1KB = 1024B
    CGFloat size = fileSize;
    if (size > (1024 * 1024))
    {
        size = size / (1024 * 1024);
        message = [NSString stringWithFormat:@"%.2fM", size];
    }
    else if (size > 1024)
    {
        size = size / 1024;
        message = [NSString stringWithFormat:@"%.2fKB", size];
    }
    else if (size > 0.0)
    {
        message = [NSString stringWithFormat:@"%.2fB", size];
    }
    
    return message;
}

/**
 *  单个文件的大小 CGFloat
 *
 *  @param filePath 文件路径
 *
 *  @return CGFloat
 */
+ (CGFloat)getFileSizeWithFilePath:(NSString *)filePath
{
    if ([self isFileExists:filePath])
    {
        return [[self getFileAttributesWithFilePath:filePath] fileSize];
    }
    return 0.0;
}

/**
 *  单个文件的大小 NSString
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)getFileSizeTextWithFilePath:(NSString *)filePath
{
    // 1MB = 1024KB 1KB = 1024B
    CGFloat size = [self getFileSizeWithFilePath:filePath];
    return [self fileSizeConversion:size];
}

/**
 *  文件夹的大小 CGFloat
 *
 *  @param directory 指定目录
 *
 *  @return CGFloat
 */
+ (CGFloat)getFileSizeTotalWithDirectory:(NSString *)directory
{
    __block CGFloat size = 0.0;
    if ([self isFileExists:directory])
    {
        // 方法1
        NSArray *array = [self getSubFilesAllWithFilePath:directory];
        
        // 方法2
//        NSDirectoryEnumerator *dirEnum = [FileManager enumeratorAtPath:directory];
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        NSString *path = nil;
//        while (path = [dirEnum nextObject])
//        {
//            [array addObject:path];
//        }
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *filePath = [directory stringByAppendingPathComponent:obj];
            if ([self isDirectory:filePath])
            {
                [self getFileSizeTotalWithDirectory:filePath];
            }
            size += [self getFileSizeWithFilePath:filePath];
        }];
        
        // 方法3
        const char *folderPath = [directory cStringUsingEncoding:NSUTF8StringEncoding];
        size = [self folderSizeWithFolderPath:folderPath];
    }
    
    return size;
}

/**
 *  文件夹的大小 NSString
 *
 *  @param directory 指定目录
 *
 *  @return NSString
 */
+ (NSString *)getFileSizeTotalTextWithDirectory:(NSString *)directory
{
    CGFloat size = [self getFileSizeTotalWithDirectory:directory];
    return [self fileSizeConversion:size];
}

/**
 *  文件夹大小-C语言写法
 *
 *  注意添加头文件 #include <sys/stat.h> #include <dirent.h>
 *
 *  @param folderPath 目录
 *
 *  @return long long
 */
+ (long long)folderSizeWithFolderPath:(const char *)folderPath
{
    long long folderSize = 0;
    DIR *dir = opendir(folderPath);
    if (dir == NULL)
    {
        return 0;
    }
    struct dirent *child;
    while ((child = readdir(dir)) != NULL)
    {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        ))
        {
            continue;
        }
        
        int folderPathLength = (int)strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/')
        {
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR)
        {
            // directory
            folderSize += [self folderSizeWithFolderPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if (lstat(childPath, &st) == 0)
            {
                folderSize += st.st_size;
            }
        }
        else if (child->d_type == DT_REG || child->d_type == DT_LNK)
        {
            // file or link
            struct stat st;
            if (lstat(childPath, &st) == 0)
            {
                folderSize += st.st_size;
            }
        }
    }
    return folderSize;
}

#pragma mark - 磁盘信息

/**
 *  磁盘空间总大小 CGFloat
 *
 *  @return CGFloat
 */
+ (CGFloat)getSizeDiskSpace
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dict = [FileManager attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error)
    {
        size = 0.0;
    }
    else
    {
        NSNumber *sizeNumber = [dict objectForKey:NSFileSystemSize];
        size = sizeNumber.floatValue;
    }
    
    return size;
}

/**
 *  磁盘空间总大小 NSString
 *
 *  @return NSString
 */
+ (NSString *)getSizeTextDiskSpace
{
    CGFloat size = [self getSizeDiskSpace];
    return [self fileSizeConversion:size];
}

/**
 *  磁盘空间可用大小 CGFloat
 *
 *  @return CGFloat
 */
+ (CGFloat)getSizeFreeDiskSpace
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dict = [FileManager attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error)
    {
        size = 0.0;
    }
    else
    {
        NSNumber *sizeNumber = [dict objectForKey:NSFileSystemFreeSize];
        size = sizeNumber.floatValue;
    }
    
    return size;
}

/**
 *  磁盘空间可用大小 NSString
 *
 *  @return NSString
 */
+ (NSString *)getSizeFreeTextDiskSpace
{
    CGFloat size = [self getSizeFreeDiskSpace];
    return [self fileSizeConversion:size];
}

#pragma mark - 临时文件

/**
 *  以时间（yyyyMMddHHmmssSSS）命名的临时文件名
 *
 *  @param NSString 文件类型（如.png、.txt等）
 *
 *  @return NSString
 */
+ (NSString *)newCacheFileNameWithType:(NSString *)type
{
    NSDate *date = [NSDate date];
    NSString *format = @"yyyyMMddHHmmssSSS";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    NSString *fileName = [formatter stringFromDate:date];
    fileName = [NSString stringWithFormat:@"%@%@", fileName, type];
    
    return fileName;
}

/**
 *  缓存目录下的临时文件路径
 *
 *  @param fileName 文件名称
 *
 *  @return NSString
 */
+ (NSString *)newCacheFilePathWithFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [cachesDirectory stringByAppendingPathComponent:fileName];
    return fullPathToFile;
}

/**
 *  保存临时图片文件
 *
 *  @param image    图片
 *  @param filePath 文件路径
 *
 *  @return BOOL
 */
+ (BOOL)saveCacheFileImage:(UIImage *)image filePath:(NSString *)filePath
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    BOOL isResult = [imageData writeToFile:filePath atomically:NO];
    return isResult;
}

/**
 *  删除临时文件
 *
 *  @param fileDict 文件字典集合（key-文件名称、value-文件路径）
 */
+ (void)deleteCacheFile:(NSDictionary *)fileDict
{
    if (fileDict)
    {
        [fileDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if([[NSFileManager defaultManager]fileExistsAtPath:obj])
            {
                [[NSFileManager defaultManager] removeItemAtPath:obj error:nil];
            }
        }];
    }
}


#pragma mark - 链式属性

/// 链式编程 home路径
+ (NSString *(^)())homePath
{
    return ^() {
        return NSHomeDirectory();
    };
}

/// 链式编程 document路径
+ (NSString *(^)())documentPath
{
    return ^() {
        NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [Paths objectAtIndex:0];
        return path;
    };
}

/// 链式编程 cache路径
+ (NSString *(^)())cachePath
{
    return ^() {
        NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [Paths objectAtIndex:0];
        return path;
    };
}

/// 链式编程 library路径
+ (NSString *(^)())libraryPath
{
    return ^() {
        NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [Paths objectAtIndex:0];
        return path;
    };
}

/// 链式编程 tmp路径
+ (NSString *(^)())tmpPath
{
    return ^() {
        return NSTemporaryDirectory();
    };
}





@end
