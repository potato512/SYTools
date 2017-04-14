//
//  SYTextField.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/3.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//  自定义textfield（通过属性设置限制输入长度，限制输入字符等）

#import <UIKit/UIKit.h>

/// 间距（左侧，或右侧）
typedef NS_ENUM(NSInteger, ViewModeType)
{
    /// 左侧
    ViewModeTypeLeft = 1,
    
    /// 右侧
    ViewModeTypeRight = 2
};

@interface SYTextField : UITextField

/// 回调响应
- (void)editingStart:(void (^)(UITextField *textField))startEditing editingChange:(void (^)(UITextField *textField, NSRange range, NSString *string))changeEditing editingReturn:(void (^)(UITextField *textField))returnEditing editingEnd:(void (^)(UITextField *textField))endEditing;

/// 键盘响应事件
- (void)showKeyboard:(void (^)(CGSize keyboardSize))show hiddenKeyboard:(void (^)(void))hidden;

/// 间距（左侧，或右侧）
@property (nonatomic, assign) ViewModeType viewMode;

/// 限制位数，即限制输入长度（默认不做限制，0时也不做限制）
@property (nonatomic, assign) NSInteger limitLength;

/// 限制输入字符（默认不做限制）
@property (nonatomic, strong) NSString *limitStr;

/// 回车时是否结束编辑（默认NO，即不结束）
@property (nonatomic, assign) BOOL isEndEditingWhileReturn;

@end
