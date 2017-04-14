//
//  SYTextView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/4.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//  自定义UITextView（通过属性设置限制输入长度，限制输入字符等）

#import <UIKit/UIKit.h>

@interface SYTextView : UITextView

/// 回调响应
- (void)editingStart:(void (^)(UITextView *textView))startEditing editingChange:(void (^)(UITextView *textView, NSRange range, NSString *text))changeEditing editingEnd:(void (^)(UITextView *textView))endEditing;

/// 占位符提示语
@property (nonatomic, strong) NSString *placeHolderText;

/// 占位符提示语字体大小
@property (nonatomic, strong) UIFont *placeHolderFont;

/// 占位符提示语字体颜色
@property (nonatomic, strong) UIColor *placeHolderColor;

/// 限制位数，即限制输入长度（默认不做限制，0时也不做限制）
@property (nonatomic, assign) NSInteger limitLength;

/// 限制输入字符（默认不做限制）
@property (nonatomic, strong) NSString *limitStr;

/// 回车时是否结束编辑（默认NO，即不结束）
@property (nonatomic, assign) BOOL isEndEditingWhileReturn;

@end
