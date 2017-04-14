//
//  MD5Secure.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-11-13.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/// MD5Secure加密位数（32位、16位）
typedef NS_ENUM(NSInteger, MD5SecureBitType)
{
    /// MD5Secure加密位数 32位
    MD5SecureBitType32 = 0,
    
    /// MD5Secure加密位数 16位
    MD5SecureBitType16 = 1,
};

@interface MD5Secure : NSObject

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
+ (NSString *)MD5SecureWithText:(NSString *)text salt:(NSString *)salt bitType:(MD5SecureBitType)type uppercase:(BOOL)isUppercase;


/**
 *  md5加密字符串
 *
 *  @param text        加密源字符串
 *  @param type        区分32位，或16位
 *  @param isUppercase 区分大写，或小写
 *
 *  @return md5加密后字符串
 */
+ (NSString *)MD5SecureWithText:(NSString *)text bitType:(MD5SecureBitType)type uppercase:(BOOL)isUppercase;


/**
 *  MD5Secure文件加密
 *
 *  @param filePath 文件路径
 *
 *  @return NSString
 */
+ (NSString *)MD5SecureWithFilePath:(NSString *)filePath;

@end
