//
//  UIImage+SYBytes.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/7.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYBytes)

#pragma mark - 图片转二进制流字符串

/**
 *  图片转二进制流字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流字符串
 */
- (NSString *)imageBytesStringWithQuality:(CGFloat)quality;

/**
 *  二进制流字符串转图片
 *
 *  @param string 二进制流字符串
 *
 *  @return image
 */
+ (UIImage *)imageWithImageBytes:(NSString *)string;

/**
 *  图片转二进制流
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流
 */
- (NSData *)imageDataWithQuality:(CGFloat)quality;

/**
 *  图片转二进制流base64字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流base64字符串
 */
- (NSString *)imageBase64StringWithQuality:(CGFloat)quality;

// base64字符串转图片
+ (UIImage *)imageWithImageBase64:(NSString *)string;

@end
