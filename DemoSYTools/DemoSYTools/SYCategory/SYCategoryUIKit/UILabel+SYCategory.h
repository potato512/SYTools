//
//  UILabel+SYCategory.h
//  zhangshaoyu
//
//  Created by herman on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自适应大小类型（宽高，或宽）
typedef NS_ENUM(NSInteger, SYLabelAutoSizeType)
{
    /// 自适应宽
    SYLabelAutoSizeTypeHorizontal = 1,
    
    /// 自适应宽高
    SYLabelAutoSizeTypeAll
};

@interface UILabel (SYCategory)

/**
 *  修改标签信息（文字大小颜色）
 *
 *  @param string         要修改的文字
 *  @param textColor      要修改的文字颜色
 *  @param textFont       要修改的文字大小
 */
- (void)attributedText:(NSString *)string color:(UIColor *)textColor font:(UIFont *)textFont;

/**
 *  修改标签信息（字符间距，行间距，文字大小颜色）
 *
 *  @param string         要修改的文字
 *  @param textColor      要修改的文字颜色
 *  @param backColor      要修改的文字背景颜色
 *  @param textFont       要修改的文字大小
 *  @param characterSpace 字体间距
 *  @param rowSpace       行间距
 */
- (void)attributedText:(NSString *)string color:(UIColor *)textColor backColor:(UIColor *)backColor font:(UIFont *)textFont space:(CGFloat)characterSpace rowSpace:(CGFloat)rowSpace;

/**
 *  修改标签信息（删除线）
 *
 *  @param string    要修改的文字
 *  @param color     线条颜色
 *  @param type      线条样式，如下划线单线类型NSUnderlineStyleSingle
 *
 */
- (void)attributedText:(NSString *)string deleteLineColor:(UIColor *)color deleteLineType:(NSUnderlineStyle)type;

/**
 *  修改标签信息（下划线）
 *
 *  @param string    要修改的文字
 *  @param color     线条颜色
 *  @param type      线条样式，如下划线单线类型NSUnderlineStyleSingle
 *
 */
- (void)attributedText:(NSString *)string underLineColor:(UIColor *)color underLineType:(NSUnderlineStyle)type;

/**
 *  修改标签信息（斜体）
 *
 *  @param string      要修改的文字
 *  @param textColor   文字颜色
 *  @param textFont    文字大小
 *  @param Obliqueness 倾斜角度
 */
- (void)attributedText:(NSString *)string color:(UIColor *)textColor font:(UIFont *)textFont Obliqueness:(CGFloat)Obliqueness;


/// 设置自适应标签宽高
- (void)labelAutoSize:(SYLabelAutoSizeType)type;

// 字体发光

// 字体阴影


#pragma mark - 链式属性

/// 链式编程 实例化
+ (UILabel *)newUILabel:(void (^)(UILabel *label))complete;
/// 链式编程 文本字体大小
- (UILabel *(^)(UIFont *font))labelFont;
/// 链式编程 文本颜色
- (UILabel *(^)(UIColor *color))labelColor;
/// 链式编程 文本对方方式
- (UILabel *(^)(NSTextAlignment alignment))labelAlignment;
/// 链式编程 文本
- (UILabel *(^)(NSString *text))labelText;
/// 链式编程 行数
- (UILabel *(^)(NSInteger number))labelNumberOfLines;

#pragma mark NSAttributedString

/// 链式编程 字符属性（颜色、背景色、大小、间距、行距）
- (UILabel *(^)(NSString *text, UIColor *color, UIColor *backColor, UIFont *font, CGFloat characterSpace, CGFloat rowSpace))labelAttributedText;

/// 链式编程 字符属性（大小）
- (UILabel *(^)(NSString *text, UIFont *font))labelAttributedTextFont;

/// 链式编程 字符属性（颜色）
- (UILabel *(^)(NSString *text, UIColor *color))labelAttributedTextColor;

/// 链式编程 下划线（线条样式 NSUnderlineStyleSingle）
- (UILabel *(^)(NSString *text, UIColor *color, NSUnderlineStyle lineType))labelAttributedTextUnderline;

/// 链式编程 删除线（线条样式 NSUnderlineStyleSingle）
- (UILabel *(^)(NSString *text, UIColor *color, NSUnderlineStyle lineType))labelAttributedTextDeleteline;

/// 链式编程 基线位置
- (UILabel *(^)(NSString *text, UIColor *color, UIFont *font, CGFloat Obliqueness))labelAttributedTextObliqueness;

@end
