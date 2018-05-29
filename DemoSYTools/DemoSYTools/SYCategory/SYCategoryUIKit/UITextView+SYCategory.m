//
//  UITextView+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITextView+SYCategory.h"
#import "NSString+SYCategory.h"
#import "NSString+SYRegular.h"
#import <objc/runtime.h>
#import "UILabel+SYCategory.h"

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (SYCategory)

//屏蔽dealloc方法（避免iOS8.x版本闪退）
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


#pragma mark - 输入限制长度（通知方法中使用）

/// 限制UITextView输入的长度（不区分中英文字符）
- (void)limitTextViewLength:(NSUInteger)maxLength
{
    NSString *text = self.text;
    NSInteger length = [text textLength:NO];
    if (length > maxLength)
    {
        self.text = [text substringToIndex:maxLength];
    }
}

/// 限制UITextView输入的长度（区分中英文字符）
- (void)limitTextViewCNLength:(NSUInteger)maxLength
{
    NSInteger lengthTotal = 0;
    NSInteger lengthText = 0;
    
    NSString *text = self.text;
    for (NSUInteger i = 0; i < text.length; i++)
    {
//        unichar textChar = [text characterAtIndex:i];
//        NSInteger lengthChar = (isascii(textChar) ? 1 : 2);
        NSString *subSelf = [text substringWithRange:NSMakeRange(i, 1)];
        NSInteger lengthChar = ([subSelf isENCharacter] ? 1 : 2);
        
        lengthTotal++;
        lengthText += lengthChar;
        if (lengthText > maxLength)
        {
            lengthTotal -= (lengthChar == 2 ? 2 : 1);
            break;
        }
    }
    self.text = [text substringToIndex:lengthTotal];
}

#pragma mark - 属性

#pragma mark 占位符

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *)placeholderLabel
{
    UILabel *label = objc_getAssociatedObject(self, @selector(placeholderLabel));
    return label;
}

#pragma mark 占位符字符串

- (void)setPlaceHolderText:(NSString *)placeHolderText
{
    objc_setAssociatedObject(self, @selector(placeHolderText), placeHolderText, OBJC_ASSOCIATION_RETAIN);
    
    [self performSelector:@selector(refreshPlaceholderText) withObject:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeholderLabelEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (NSString *)placeHolderText
{
    NSString *string = objc_getAssociatedObject(self, @selector(placeHolderText));
    return string;
}

- (void)setPlaceholderLabelUI
{
    if (self.placeholderLabel == nil)
    {
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, (self.frame.size.width - 5.0 * 2), 0.0)];
        [self addSubview:self.placeholderLabel];
        self.placeholderLabel.font = self.font;
        self.placeholderLabel.textColor = [UIColor colorWithWhite:0.3 alpha:0.2];
        self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)refreshPlaceholderText
{
    [self setPlaceholderLabelUI];
    
    self.placeholderLabel.text = self.placeHolderText;
    [self.placeholderLabel labelAutoSize:SYLabelAutoSizeTypeAll];
}

- (void)placeholderLabelEditChanged:(NSNotification *)notification
{
    // 根据输入情况隐藏或显示占位符
    self.placeholderLabel.hidden = (0 >= self.text.length ? NO : YES);
}

#pragma mark 占位符字体

- (void)setPlaceHolderTextFont:(UIFont *)placeHolderTextFont
{
    objc_setAssociatedObject(self, @selector(placeHolderTextFont), placeHolderTextFont, OBJC_ASSOCIATION_RETAIN);
    [self performSelector:@selector(refreshPlaceholderFont) withObject:nil];
}

- (UIFont *)placeHolderTextFont
{
    UIFont *font = objc_getAssociatedObject(self, @selector(placeHolderTextFont));
    return font;
}

- (void)refreshPlaceholderFont
{
    [self setPlaceholderLabelUI];
    
    self.placeholderLabel.font = self.placeHolderTextFont;
}

#pragma mark 占位符字体颜色

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    objc_setAssociatedObject(self, @selector(placeHolderTextColor), placeHolderTextColor, OBJC_ASSOCIATION_RETAIN);
    [self performSelector:@selector(refreshPlaceholderColor) withObject:nil];
}

- (UIColor *)placeHolderTextColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(placeHolderTextColor));
    return color;
}

- (void)refreshPlaceholderColor
{
    [self setPlaceholderLabelUI];
    
    self.placeholderLabel.textColor = self.placeHolderTextColor;
}

#pragma mark 限制输入长度

- (void)setLimitMaxLength:(NSInteger)limitMaxLength
{
    if (0 < limitMaxLength)
    {
        objc_setAssociatedObject(self, @selector(limitMaxLength), @(limitMaxLength), OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewLengthEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSInteger)limitMaxLength
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(limitMaxLength));
    return number.integerValue;
}

- (void)textViewLengthEditChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        NSInteger maxLength = self.limitMaxLength;
        [self limitTextViewLength:maxLength];
    }
}

#pragma mark 限制输入字符

- (void)setLimitText:(NSString *)limitText
{
    if (0 < limitText.length)
    {
        objc_setAssociatedObject(self, @selector(limitText), limitText, OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSString *)limitText
{
    NSString *string = objc_getAssociatedObject(self, @selector(limitText));
    return string;
}

- (void)setAllowedText:(NSString *)allowedText
{
    if (0 < allowedText.length)
    {
        objc_setAssociatedObject(self, @selector(allowedText), allowedText, OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allowedTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSString *)allowedText
{
    NSString *string = objc_getAssociatedObject(self, @selector(allowedText));
    return string;
}

- (void)limitTextChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        [self.text regularWithText:self.limitText limitedHandle:^(NSInteger index) {
            if (0 == index)
            {
                // 首位输入
                NSInteger length = self.text.length;
                if (0 == length)
                {
                    // 首次输入
                    self.text = @"";
                }
                else
                {
                    // 非首次输入
                    self.text = [self.text substringFromIndex:(index + 1)];
                }
            }
            else
            {
                // 非首位输入
                self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:@""];
            }
        }];
    }
}

- (void)allowedTextChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        [self.text regularWithText:self.allowedText allowedHandle:^(NSInteger index) {
            if (0 == index)
            {
                // 首位输入
                NSInteger length = self.text.length;
                if (0 == length)
                {
                    // 首次输入
                    self.text = @"";
                }
                else
                {
                    // 非首次输入
                    self.text = [self.text substringFromIndex:(index + 1)];
                }
            }
            else
            {
                // 非首位输入
                self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:@""];
            }
        }];
        
        // 如果包含有不是指定字符串的字符则递归调用（避免中文多词联想异常）
        if (![self.text isContantWithText:self.allowedText])
        {
            [self allowedTextChanged:notification];
        }
    }
}


#pragma mark - 链式属性

/// 链式编程 代理对象
- (UITextView *(^)(id<UITextViewDelegate> delegate))textViewDelegate
{
    return ^(id<UITextViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

/// 链式编程 占位符
- (UITextView *(^)(NSString *text))textViewPlaceholderText
{
    return ^(NSString *text) {
        self.placeHolderText = text;
        return self;
    };
}

/// 链式编程 占位符字体大小
- (UITextView *(^)(UIFont *font))textViewPlaceholderTextFont
{
    return ^(UIFont *font) {
        self.placeHolderTextFont = font;
        return self;
    };
}

/// 链式编程 占位符字体颜色
- (UITextView *(^)(UIColor *color))textViewPlaceholderTextColor
{
    return ^(UIColor *color) {
        self.placeHolderTextColor = color;
        return self;
    };
}

/// 链式编程 字符
- (UITextView *(^)(NSString *text))textViewText
{
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

/// 链式编程 字符字体大小
- (UITextView *(^)(UIFont *fong))textViewTextFont
{
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

/// 链式编程 字符颜色
- (UITextView *(^)(UIColor *color))textViewTextColor
{
    return ^(UIColor *color) {
        self.textColor = color;
        return self;
    };
}

/// 链式编程 字符对齐方式
- (UITextView *(^)(NSTextAlignment alignment))textViewTextAlignment
{
    return ^(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

/// 链式编程 输入视图
- (UITextView *(^)(UIView *view))textViewInputView
{
    return ^(UIView *view) {
        self.inputView = view;
        return self;
    };
}

/// 链式编程 附加输入视图
- (UITextView *(^)(UIView *view))textViewInputAccessoryView
{
    return ^(UIView *view) {
        self.inputAccessoryView = view;
        return self;
    };
}

/// 链式编程 回车键类型
- (UITextView *(^)(UIReturnKeyType type))textViewReturnKeyType
{
    return ^(UIReturnKeyType type) {
        self.returnKeyType = type;
        return self;
    };
}

/// 链式编程 键盘类型
- (UITextView *(^)(UIKeyboardType type))textViewKeyboardType
{
    return ^(UIKeyboardType type) {
        self.keyboardType = type;
        return self;
    };
}

/// 链式编程 限制输入长度
- (UITextView *(^)(NSInteger length))textViewLimitLength
{
    return ^(NSInteger length) {
        self.limitMaxLength = length;
        return self;
    };
}

/// 链式编程 限制不能输入
- (UITextView *(^)(NSString *text))textViewLimitText
{
    return ^(NSString *text) {
        self.limitText = text;
        return self;
    };
}

/// 链式编程 限制只能输入
- (UITextView *(^)(NSString *text))textViewAllowText
{
    return ^(NSString *text) {
        self.allowedText = text;
        return self;
    };
}

@end
