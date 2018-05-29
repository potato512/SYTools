//
//  UILabel+SYCategory.m
//  zhangshaoyu
//
//  Created by herman on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UILabel+SYCategory.h"
#import "NSAttributedString+SYCategory.h"
#import "NSObject+SYCategory.h"
#import <objc/runtime.h>

@interface UILabel ()

@property (nonatomic, copy) void (^tapBlock)(UITapGestureRecognizer *);


@end

@implementation UILabel (SYCategory)

/**
 *  修改标签信息（文字大小颜色）
 *
 *  @param string         要修改的文字
 *  @param textColor      要修改的文字颜色
 *  @param textFont       要修改的文字大小
 */
- (void)attributedText:(NSString *)string color:(UIColor *)textColor font:(UIFont *)textFont
{
    [self attributedText:string color:textColor backColor:nil font:textFont space:0.0 rowSpace:0.0];
}

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
- (void)attributedText:(NSString *)string color:(UIColor *)textColor backColor:(UIColor *)backColor font:(UIFont *)textFont space:(CGFloat)characterSpace rowSpace:(CGFloat)rowSpace
{
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:self.text];
    attributed = [attributed attributedText:string color:textColor font:textFont space:characterSpace rowSpace:rowSpace bgColor:backColor];
    self.attributedText = attributed;
}

/**
 *  修改标签信息（删除线）
 *
 *  @param string    要修改的文字
 *  @param color     线条颜色
 *  @param type      线条样式，如下划线单线类型NSUnderlineStyleSingle
 *
 */
- (void)attributedText:(NSString *)string deleteLineColor:(UIColor *)color deleteLineType:(NSUnderlineStyle)type
{
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:self.text];
    attributed = [attributed attributedText:string deleteLineColor:color deleteLineType:type];
    self.attributedText = attributed;
}

/**
 *  修改标签信息（下划线）
 *
 *  @param string    要修改的文字
 *  @param color     线条颜色
 *  @param type      线条样式，如下划线单线类型NSUnderlineStyleSingle
 *
 */
- (void)attributedText:(NSString *)string underLineColor:(UIColor *)color underLineType:(NSUnderlineStyle)type
{
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:self.text];
    attributed = [attributed attributedText:string underLineColor:color underLineType:type];
    self.attributedText = attributed;
}

/**
 *  修改标签信息（斜体）
 *
 *  @param string      要修改的文字
 *  @param textColor   文字颜色
 *  @param textFont    文字大小
 *  @param Obliqueness 倾斜角度
 */
- (void)attributedText:(NSString *)string color:(UIColor *)textColor font:(UIFont *)textFont Obliqueness:(CGFloat)Obliqueness
{
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:self.text];
    attributed = [attributed attributedText:string color:textColor font:textFont Obliqueness:Obliqueness];
    self.attributedText = attributed;
}

/// 设置自适应标签宽高
- (void)labelAutoSize:(SYLabelAutoSizeType)type
{
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize labelsize = [self sizeWithText:self.text font:self.font constrainedSize:size];
    if (SYLabelAutoSizeTypeHorizontal == type)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelsize.width, self.frame.size.height);
    }
    else if (SYLabelAutoSizeTypeAll == type)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelsize.width, labelsize.height);
    }
}

#pragma mark - 链式属性

+ (UILabel *)newUILabel:(void (^)(UILabel *label))complete
{
    UILabel *label = [[UILabel alloc] init];
    complete(label);
    return label;
}

- (UILabel *(^)(UIFont *font))labelFont
{
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

- (UILabel *(^)(UIColor *color))labelColor
{
    return ^(UIColor *color) {
        self.textColor = color;
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment alignment))labelAlignment
{
    return ^(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

- (UILabel *(^)(NSString *text))labelText
{
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(NSInteger number))labelNumberOfLines
{
    return ^(NSInteger number) {
        self.numberOfLines = number;
        return self;
    };
}

#pragma mark NSAttributedString

- (UILabel *(^)(NSString *text, UIColor *color, UIColor *backColor, UIFont *font, CGFloat characterSpace, CGFloat rowSpace))labelAttributedText
{
    return ^(NSString *text, UIColor *color, UIColor *backColor, UIFont *font, CGFloat characterSpace, CGFloat rowSpace) {
        [self attributedText:text color:color backColor:backColor font:font space:characterSpace rowSpace:rowSpace];
        return self;
    };
}

- (UILabel *(^)(NSString *text, UIFont *font))labelAttributedTextFont
{
    return ^(NSString *text, UIFont *font) {
        [self attributedText:text color:nil font:font];
        return self;
    };
}

- (UILabel *(^)(NSString *text, UIColor *color))labelAttributedTextColor
{
    return ^(NSString *text, UIColor *color) {
        [self attributedText:text color:color font:nil];
        return self;
    };
}

- (UILabel *(^)(NSString *text, UIColor *color, NSInteger lineType))labelAttributedTextUnderline
{
    return ^(NSString *text, UIColor *color, NSUnderlineStyle lineType) {
        [self attributedText:text underLineColor:color underLineType:lineType];
        return self;
    };
}

- (UILabel *(^)(NSString *text, UIColor *color, NSUnderlineStyle lineType))labelAttributedTextDeleteline
{
    return ^(NSString *text, UIColor *color, NSInteger lineType) {
        [self attributedText:text deleteLineColor:color deleteLineType:lineType];
        return self;
    };
}

- (UILabel *(^)(NSString *text, UIColor *color, UIFont *font, CGFloat Obliqueness))labelAttributedTextObliqueness
{
    return ^(NSString *text, UIColor *color, UIFont *font, CGFloat Obliqueness) {
        [self attributedText:text color:color font:font Obliqueness:Obliqueness];
        return self;
    };
}

@end
