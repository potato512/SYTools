//
//  UIColor+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIColor+SYCategory.h"

@implementation UIColor (SYCategory)

/**
 *  将十六进制颜色转换为 UIColor 对象
 *
 *  @param color 十六进制颜色（如@"#ffffff"，或@"0Xffffff"/@"0xffffff"/@"OXffffff"/@"Oxffffff"/@"oXffffff"/@"oxffffff"）
 *
 *  @return UIColor 对象
 */
+ (UIColor *)colorWithHexadecimalString:(NSString *)color
{
    NSString *colorString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (6 > colorString.length)
    {
        return [UIColor clearColor];
    }
    
    if ([colorString hasPrefix:@"0X"] | [colorString hasPrefix:@"0x"] | [colorString hasPrefix:@"OX"] | [colorString hasPrefix:@"Ox"] | [colorString hasPrefix:@"oX"] | [colorString hasPrefix:@"ox"])
    {
        colorString = [colorString substringFromIndex:2];
    }
    if ([colorString hasPrefix:@"#"])
    {
        colorString = [colorString substringFromIndex:1];
    }
    if (6 != colorString.length)
    {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *redString = [colorString substringWithRange:range];
    range.location = 2;
    NSString *greenString = [colorString substringWithRange:range];
    range.location = 4;
    NSString *blueString = [colorString substringWithRange:range];
    
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    UIColor *result = [UIColor colorWithRed:((float)(red) / 255.0) green:((float)(green) / 255.0) blue:((float)(blue) / 255.0) alpha:1.0];
    return result;
}

/// 设置随机颜色
+ (UIColor *)colorRandom
{
    return [UIColor colorWithRed:(arc4random_uniform(256) / 255.0) green:(arc4random_uniform(256) / 255.0) blue:(arc4random_uniform(256) / 255.0) alpha:1.0];
}

/// 设置颜色（RGB：0.0~255.0） 示例：UIColorRGB(100, 100, 100)
+ (UIColor *)colorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorRed:red green:green blue:blue alpha:1.0];
}

/// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
+ (UIColor *)colorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:alpha];
}

@end
