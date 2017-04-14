//
//  MD5Secure.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-11-13.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "MD5Secure.h"
#import <CommonCrypto/CommonDigest.h>

static CGFloat FileHashSize = (1024 * 8);

@implementation MD5Secure

/**
 *  md5未加盐加密字符串
 *
 *  @param text        加密源字符串
 *  @param type        区分32位，或16位
 *  @param isUppercase 区分大写，或小写
 *
 *  @return md5加密后字符串
 */
+ (NSString *)MD5SecureWithText:(NSString *)text bitType:(MD5SecureBitType)type uppercase:(BOOL)isUppercase
{
    NSString *result = [self MD5SecureWithText:text salt:nil bitType:type uppercase:isUppercase];
    return result;
}

/**
 *  md5加盐加密字符串
 *
 *  @param text        加密源字符串
 *  @param salt        盐值
 *  @param type        区分32位，或16位
 *  @param isUppercase 区分大写，或小写
 *
 *  @return md5加密后字符串
 */
+ (NSString *)MD5SecureWithText:(NSString *)text salt:(NSString *)salt bitType:(MD5SecureBitType)type uppercase:(BOOL)isUppercase
{
    NSString *textTmp = text;
    if (salt && 0 != salt.length)
    {
        // 加盐
        textTmp = [NSString stringWithFormat:@"%@%@", textTmp, salt];
    }
    
    // 32位加密，默认32位
    const char *resultChar = [textTmp UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(resultChar, strlen(resultChar), digest);
    NSMutableString *textResult = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [textResult appendFormat:@"%02x", digest[i]];
    }
    
    // 16位（提取32位MD5散列的中间16位，即9~25位）
    if (MD5SecureBitType16 == type)
    {
        textResult = (NSMutableString *)[[textResult substringToIndex:24] substringFromIndex:8];
    }
    
    // 大小写（默认小写）
    if (isUppercase)
    {
        textResult = (NSMutableString *)[textResult uppercaseString];
    }
    
    return textResult;
}

/**
 *  MD5Secure文件加密
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)MD5SecureWithFilePath:(NSString *)filePath
{
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)filePath, FileHashSize);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData)
{
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)filePath, kCFURLPOSIXPathStyle, (Boolean)false);
    if (!fileURL)
    {
        goto done;
    }
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, (CFURLRef)fileURL);
    if (!readStream)
    {
        goto done;
    }
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed)
    {
        goto done;
    }
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData)
    {
        chunkSizeForReadingData = FileHashSize;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData)
    {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream, (UInt8 *)buffer, (CFIndex)sizeof(buffer));
        if (readBytesCount == -1)
        {
            break;
        }
        if (readBytesCount == 0)
        {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed)
    {
        goto done;
    }
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i)
    {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault, (const char *)hash, kCFStringEncodingUTF8);
    
done:
    
    if (readStream)
    {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    
    if (fileURL)
    {
        CFRelease(fileURL);
    }
    
    return result;
}


@end
