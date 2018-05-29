//
//  UIColor+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SYCategory)


/**
 *  将十六进制颜色转换为 UIColor 对象
 *
 *  @param color 十六进制颜色（如@"#ffffff"，或@"0Xffffff"/@"0xffffff"/@"OXffffff"/@"Oxffffff"/@"oXffffff"/@"oxffffff"）
 *
 *  @return UIColor 对象
 */
+ (UIColor *)colorWithHexadecimalString:(NSString *)color;

/// 设置随机颜色
+ (UIColor *)colorRandom;

/// 设置颜色（RGB：0.0~255.0） 示例：UIColorRGB(100, 100, 100)
+ (UIColor *)colorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
+ (UIColor *)colorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
