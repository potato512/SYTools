//
//  UITextView+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SYCategory)

#pragma mark - 输入限制长度（在通知方法中使用）

/// 限制UITextView输入的长度（不区分中英文字符）
- (void)limitTextViewLength:(NSUInteger)maxLength;

/// 限制UITextView输入的长度（区分中英文字符）
- (void)limitTextViewCNLength:(NSUInteger)maxLength;

#pragma mark - 属性

/// 占位符提示语（默认无。如有字符输入限制则先设置限制字符）
@property (nonatomic, strong) NSString *placeHolderText;
/// 占位符提示语字体大小（默认与textview的系统字体大小一致）
@property (nonatomic, strong) UIFont *placeHolderTextFont;
/// 占位符提示语字体颜色（默认灰色）
@property (nonatomic, strong) UIColor *placeHolderTextColor;

/// 字符输入字数限制
@property (nonatomic, assign) NSInteger limitMaxLength;

/// 限制不能输入指定字符（不需要结合通知使用）
@property (nonatomic, strong) NSString *limitText;
/// 限制只能输入指定字符（不需要结合通知使用）
@property (nonatomic, strong) NSString *allowedText;


#pragma mark - 链式属性

/// 链式编程 代理对象
- (UITextView *(^)(id<UITextViewDelegate> delegate))textViewDelegate;

/// 链式编程 占位符
- (UITextView *(^)(NSString *text))textViewPlaceholderText;

/// 链式编程 占位符字体大小
- (UITextView *(^)(UIFont *font))textViewPlaceholderTextFont;

/// 链式编程 占位符字体颜色
- (UITextView *(^)(UIColor *color))textViewPlaceholderTextColor;

/// 链式编程 字符
- (UITextView *(^)(NSString *text))textViewText;

/// 链式编程 字符字体大小
- (UITextView *(^)(UIFont *fong))textViewTextFont;

/// 链式编程 字符颜色
- (UITextView *(^)(UIColor *color))textViewTextColor;

/// 链式编程 字符对齐方式
- (UITextView *(^)(NSTextAlignment alignment))textViewTextAlignment;

/// 链式编程 输入视图
- (UITextView *(^)(UIView *view))textViewInputView;

/// 链式编程 附加输入视图
- (UITextView *(^)(UIView *view))textViewInputAccessoryView;

/// 链式编程 回车键类型
- (UITextView *(^)(UIReturnKeyType type))textViewReturnKeyType;

/// 链式编程 键盘类型
- (UITextView *(^)(UIKeyboardType type))textViewKeyboardType;

/// 链式编程 限制输入长度
- (UITextView *(^)(NSInteger length))textViewLimitLength;

/// 链式编程 限制不能输入
- (UITextView *(^)(NSString *text))textViewLimitText;

/// 链式编程 限制只能输入
- (UITextView *(^)(NSString *text))textViewAllowText;

@end

/*
 使用说明
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
 
 - (void)textViewEditChanged:(NSNotification *)notification
 {
     if ([self.textField isFirstResponder])
     {
         [self.textField limitTextFieldLength:10];
     }
 }
 
 */



