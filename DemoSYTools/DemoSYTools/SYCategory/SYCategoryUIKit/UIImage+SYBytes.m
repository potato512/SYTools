//
//  UIImage+SYBytes.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/7.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImage+SYBytes.h"

@implementation UIImage (SYBytes)

#pragma mark - 图片转二进制流字符串

/**
 *  图片转二进制流字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流字符串
 */
- (NSString *)imageBytesStringWithQuality:(CGFloat)quality
{
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
    NSStringEncoding imageEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSString *imageBytesStr = [[NSString alloc] initWithData:imageData encoding:imageEncoding];
    
    return imageBytesStr;
}

/**
 *  二进制流字符串转图片
 *
 *  @param string 二进制流字符串
 *
 *  @return image
 */
+ (UIImage *)imageWithImageBytes:(NSString *)string
{
    NSStringEncoding imageEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSData *data = [string dataUsingEncoding:imageEncoding];
    UIImage *image = [[UIImage alloc] initWithData:data];
    return image;
}

/**
 *  图片转二进制流
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流
 */
- (NSData *)imageDataWithQuality:(CGFloat)quality
{
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
    
    return imageData;
}

/**
 *  图片转二进制流base64字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流base64字符串
 */
- (NSString *)imageBase64StringWithQuality:(CGFloat)quality
{
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
    NSString *imageBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return imageBase64;
}

// base64字符串转图片
+ (UIImage *)imageWithImageBase64:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
