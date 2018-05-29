//
//  NSAttributedString+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (SYCategory)

/**
 *  修改NSAttributedString信息（文字大小颜色）
 *
 *  @param text    需要修改的text
 *  @param aFont   字体大小
 *  @param aColor  字体颜色
 */
- (NSAttributedString *)attributedText:(NSString *)text font:(UIFont *)aFont color:(UIColor *)aColor;

/**
 *  修改NSAttributedString信息（文字大小颜色、字体背景颜色）
 *
 *  @param text    需要修改的text
 *  @param font    字体大小
 *  @param color   字体颜色
 *  @param bgColor 字体背景颜色
 */
- (NSAttributedString *)attributedText:(NSString *)text font:(UIFont *)font color:(UIColor *)color bgColor:(UIColor *)bgColor;

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
- (NSAttributedString *)attributedText:(NSString *)text color:(UIColor *)textColor font:(UIFont *)textFont space:(CGFloat)characterSpace rowSpace:(CGFloat)rowSpace bgColor:(UIColor *)bgColor;

/// 设置字体为斜体
- (NSAttributedString *)attributedText:(NSString *)text color:(UIColor *)textColor font:(UIFont *)textFont Obliqueness:(CGFloat)Obliqueness;

/// 设置字体的删除线 NSUnderlineStyleSingle
- (NSAttributedString *)attributedText:(NSString *)text deleteLineColor:(UIColor *)color deleteLineType:(NSUnderlineStyle)type;

/// 设置字体的下划线 NSUnderlineStyleSingle
- (NSAttributedString *)attributedText:(NSString *)text underLineColor:(UIColor *)color underLineType:(NSUnderlineStyle)type;

/// html源码转NSAttributedString
- (NSAttributedString *)attributedHtml:(NSString *)html;

@end

/*
 使用coretext改变字体属性
 步骤1 导入框架CoreText.framework
 
 步骤2 导入头文件 #import <CoreText/CoreText.h>
 
 步骤3 将NSString转变成NSMutableAttributedString，根据要设置的字符串属性进行设置
 // 区域
 NSString *oldString = [attString string];
 NSRange range = [oldString rangeOfString:aString];
 // 颜色
 [attString addAttribute:NSForegroundColorAttributeName value:aColor range:range];
 // 字体
 [attString addAttribute:NSFontAttributeName value:aFont range:range];
 
 */




