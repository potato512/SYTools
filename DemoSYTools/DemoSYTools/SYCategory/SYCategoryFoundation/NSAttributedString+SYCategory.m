//
//  NSAttributedString+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSAttributedString+SYCategory.h"

@implementation NSAttributedString (SYCategory)

/**
 *  修改NSAttributedString信息（文字大小颜色）
 *
 *  @param text    需要修改的text
 *  @param aFont   字体大小
 *  @param aColor  字体颜色
 */
- (NSAttributedString *)attributedText:(NSString *)text font:(UIFont *)aFont color:(UIColor *)aColor
{
    return [self attributedText:text font:aFont color:aColor bgColor:nil];
}

/**
 *  修改NSAttributedString信息（文字大小颜色、字体背景颜色）
 *
 *  @param text    需要修改的text
 *  @param font    字体大小
 *  @param color   字体颜色
 *  @param bgColor 字体背景颜色
 */
- (NSAttributedString *)attributedText:(NSString *)text font:(UIFont *)font color:(UIColor *)color bgColor:(UIColor *)bgColor
{
    return [self attributedText:text color:color font:font space:0.0 rowSpace:0.0 bgColor:bgColor];
}

/**
 *  修改NSAttributedString信息（字符间距，行间距，文字大小颜色、字体背景颜色）
 *
 *  @param text           要修改的文字
 *  @param textColor      要修改的文字颜色
 *  @param textFont       要修改的文字大小
 *  @param characterSpace 字体间距
 *  @param rowSpace       行间距
 *  @param bgColor        字体背景颜色
 */
- (NSAttributedString *)attributedText:(NSString *)text color:(UIColor *)textColor font:(UIFont *)textFont space:(CGFloat)characterSpace rowSpace:(CGFloat)rowSpace bgColor:(UIColor *)bgColor
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    if (text == nil || 0 >= text.length)
    {
        return attributed;
    }
    
    NSString *textTmp = attributed.string;
    // 设置某写字体的颜色 NSForegroundColorAttributeName
    NSRange range = [textTmp rangeOfString:text];
    if (range.location != NSNotFound)
    {
        // 颜色
        if (textColor)
        {
            [attributed addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        }
        // 字体
        if (textFont)
        {
            [attributed addAttribute:NSFontAttributeName value:textFont range:range];
        }
        // 字符间距
        if (0.0 < characterSpace)
        {
            // 设置每个字体之间的间距 NSKernAttributeName 这个对象所对应的值是一个NSNumber对象(包含小数),作用是修改默认字体之间的距离调整,值为0的话表示字距调整是禁用的
            [attributed addAttribute:NSKernAttributeName value:@(characterSpace) range:range];
        }
        // 行间距
        if (0.0 < rowSpace)
        {
            // 设置每行之间的间距 NSParagraphStyleAttributeName 设置段落的样式
            NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc] init];
            [par setLineSpacing:rowSpace];
            [attributed addAttribute:NSParagraphStyleAttributeName value:par range:range];
        }
        // 字体背景颜色
        if (bgColor)
        {
            [attributed addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
        }
    }
    
    return attributed;
}

/// 设置字体为斜体
- (NSAttributedString *)attributedText:(NSString *)text color:(UIColor *)textColor font:(UIFont *)textFont Obliqueness:(CGFloat)Obliqueness
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    if (text == nil || 0 >= text.length)
    {
        return attributed;
    }
    
    NSString *textTmp = attributed.string;
    // 字体设置范围
    NSRange range = [textTmp rangeOfString:text];
    if (range.location != NSNotFound)
    {
        // 设置字体颜色
        if (textColor)
        {
            [attributed addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        }
        
        // 字体大小
        if (textFont)
        {
            [attributed addAttribute:NSFontAttributeName value:textFont range:range];
        }
        
        //
        NSNumber *number = (0.0 >= Obliqueness ? @(0.5) : @(Obliqueness));
        [attributed addAttribute:NSObliquenessAttributeName value:number range:range];
        
    }
    
    return attributed;
}


/// 设置字体的删除线 NSUnderlineStyleSingle
- (NSAttributedString *)attributedText:(NSString *)text deleteLineColor:(UIColor *)color deleteLineType:(NSUnderlineStyle)type
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    if (text == nil || 0 >= text.length)
    {
        return attributed;
    }
    
    NSString *textTmp = attributed.string;
    // 字体设置范围
    NSRange range = [textTmp rangeOfString:text];
    if (range.location != NSNotFound)
    {
        [attributed addAttribute:NSBaselineOffsetAttributeName value:@(0) range:range];
        [attributed addAttribute:NSStrikethroughStyleAttributeName value:@(type) range:range];
        if (color)
        {
            [attributed addAttribute:NSStrikethroughColorAttributeName value:color range:range];
        }
    }
    
    return attributed;
}

/// 设置字体的下划线 NSUnderlineStyleSingle
- (NSAttributedString *)attributedText:(NSString *)text underLineColor:(UIColor *)color underLineType:(NSUnderlineStyle)type
{
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    if (text == nil || 0 >= text.length)
    {
        return attributed;
    }
    
    NSString *textTmp = attributed.string;
    // 字体设置范围
    NSRange range = [textTmp rangeOfString:text];
    if (range.location != NSNotFound)
    {
        [attributed addAttribute:NSBaselineOffsetAttributeName value:@(0) range:range];
        [attributed addAttribute:NSUnderlineStyleAttributeName value:@(type) range:range];
        if (color)
        {
            [attributed addAttribute:NSUnderlineColorAttributeName value:color range:range];
        }
    }
    
    return attributed;
}

/// html源码转NSAttributedString
- (NSAttributedString *)attributedHtml:(NSString *)html
{
    if (html && 0 < html.length)
    {
        NSData *dataHtml = [html dataUsingEncoding:NSUnicodeStringEncoding];
        NSAttributedString *attributed = [[NSAttributedString alloc] initWithData:dataHtml options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        return attributed;
    }
    return nil;
}

@end
