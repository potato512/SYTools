//
//  UITextField+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITextField+SYCategory.h"
#import "NSString+SYCategory.h"
#import "NSString+SYRegular.h"
#import <objc/runtime.h>

@implementation UITextField (SYCategory)

//屏蔽dealloc方法（避免iOS8.x版本闪退）
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


/// 设置TextField空白间隙，左侧或右侧（默认10个间距）
- (void)viewModeType:(TextFieldViewModeType)type space:(float)space
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, space, CGRectGetHeight(self.bounds))];
    view.backgroundColor = [UIColor clearColor];
    if (TextFieldViewModeTypeLeft == type)
    {
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    else if (TextFieldViewModeTypeRight == type)
    {
        self.rightView = view;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

#pragma mark - 输入限制

/**
 *  手机号输入限制（异常：中文联想字能被输入）
 *
 *  回调方法“- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string”中使用
 *
 *  @param range  当前输入区间
 *  @param string 当前输入字符
 *
 *  @return BOOL
 */
- (BOOL)limitMoblieShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self isFirstResponder])
    {
        NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@"1"];
        NSCharacterSet *middleSet = [NSCharacterSet characterSetWithCharactersInString:@"345678"];
        NSCharacterSet *lastSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
//        NSLog(@"text(length = %ld) %@", tempStr.length, tempStr);
        
        // 手机号输入限制
        if (1 < tempStr.length)
        {
            // 光标移动到首位时，输入只能为1
            NSString *firstStr = [tempStr substringToIndex:1];
            NSRange firstRange = [firstStr rangeOfCharacterFromSet:firstSet];
            if (firstRange.location == NSNotFound)
            {
                return NO;
            }
            
            // 第二位输入为3-9
            NSString *middleStr = [tempStr substringWithRange:NSMakeRange(1, 1)];
            if (middleStr && 0 != middleStr.length)
            {
                NSRange middleRange = [middleStr rangeOfCharacterFromSet:middleSet];
                if (middleRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 第3~11位输入为0~9
            NSString *lastStr = [tempStr substringFromIndex:2];
            if (lastStr && 0 != lastStr.length)
            {
                NSRange lastRange = [lastStr rangeOfCharacterFromSet:lastSet];
                if (lastRange.location == NSNotFound)
                {
                    return NO;
                }
            }
        }
        else if (1 == tempStr.length)
        {
            // 首位只能输入1
            NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            if (firstRange.location == NSNotFound)
            {
                return NO;
            }
        }
        
        // 手机号最多11位
        if (11 < tempStr.length)
        {
            self.text = [tempStr substringToIndex:11];
            return NO;
        }
    }
    
    return YES;
}

/**
 *  数字输入限制（异常：中文联想字能被输入）
 *
 *  回调方法“- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string”中使用
 *
 *  @param range         当前输入区间
 *  @param string        当前输入字符
 *  @param integerLength 整数位数，0时无限制
 *  @param greater       整数首位是否大于0
 *  @param decimal       是否带小数
 *  @param decimalLength 小数位数
 *
 *  @return BOOL
 */
- (BOOL)limitNumberShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string integer:(NSInteger)integerLength greaterThanZero:(BOOL)greater decimalPoint:(BOOL)decimal decimalDigits:(NSInteger)decimalLength
{
    if ([self isFirstResponder])
    {
        NSCharacterSet *withoutZeroNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *withZeroNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        NSString *decimalString = @".";
        NSString *zeroString = @"0";
        
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
//        NSLog(@"text(integerLength=%ld length = %ld) %@", (long)integerLength, tempStr.length, tempStr);
        
        if (1 < tempStr.length)
        {
            NSString *firstString = [tempStr substringWithRange:NSMakeRange(0, 1)];
            if ([zeroString isEqualToString:firstString])
            {
                // 第一个是0时，且第二个非小数点时，自动去掉第一个0
                NSString *secondString = [tempStr substringWithRange:NSMakeRange(1, 1)];
                if ([decimalString isEqualToString:secondString])
                {
                    // 带小数
                    if (decimal)
                    {
                        NSRange decimalRange = [tempStr rangeOfString:decimalString];
                        if (decimalRange.location != NSNotFound)
                        {
                            // 小数点后decimalLength位
                            NSInteger decimal = (decimalRange.location + decimalRange.length + decimalLength + 1);
                            if (decimal <= tempStr.length)
                            {
                                return NO;
                            }
                        }
                    }
                }
                else
                {
                    self.text = [tempStr substringFromIndex:1];
                    return NO;
                }
            }
            else
            {
                // 第一个非0时
                for (int i = 0; i < tempStr.length; i++)
                {
                    NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                    
                    // 只能输入数字和小数点
                    NSRange numberRange = [subString rangeOfCharacterFromSet:(decimal ? limitSet : withZeroNumberSet)];
                    if (numberRange.location == NSNotFound)
                    {
                        return NO;
                        break;
                    }
                    
                    if (decimal)
                    {
                        // 只能有一个小数点
                        NSArray *array = [tempStr componentsSeparatedByString:decimalString];
                        if (3 <= array.count)
                        {
                            return NO;
                            break;
                        }
                    }
                }
                
                // 带小数
                if (decimal)
                {
                    NSRange decimalRange = [tempStr rangeOfString:decimalString];
                    if (decimalRange.location != NSNotFound)
                    {
                        // 小数点后decimalLength位
                        NSInteger decimal = (decimalRange.location + decimalRange.length + decimalLength + 1);
                        if (decimal <= tempStr.length)
                        {
                            return NO;
                        }
                    }
                }
                
                // 整数长度，0时整数输入无限制
                if (integerLength != 0)
                {
                    NSRange decimalRange = [tempStr rangeOfString:decimalString];
                    NSString *subString = tempStr;
                    if (decimalRange.location != NSNotFound)
                    {
                        subString = [tempStr substringToIndex:decimalRange.location];
                    }
                    
                    NSInteger integer = (integerLength + 1);
                    if (integer <= subString.length)
                    {
                        return NO;
                    }
                }
            }
        }
        else if (1 == tempStr.length)
        {
            // 首个输入限制，只能输入1~9，或只有输入0~9
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:(greater ? withoutZeroNumberSet : withZeroNumberSet)];
            if (decimal && !greater)
            {
                // 带小数点时，且首个输入非大于0时，允许首个输入小数点，并默认格式为"0.xxx"
                numberRange = [tempStr rangeOfCharacterFromSet:limitSet];
                if ([decimalString isEqualToString:tempStr])
                {
                    self.text = [NSString stringWithFormat:@"%@%@", zeroString, decimalString];
                    return NO;
                }
            }
            
            if (numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
    }
    return YES;
}

/**
 *  第N位限制不能输入指定字符（异常：中文联想字能被输入）
 *
 *  回调方法“- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string”中使用
 *
 *  @param range  当前输入区间
 *  @param string 当前输入字符
 *  @param limits 限制不能输入的字符
 *  @param index  限制的第N位
 *
 *  @return BOOL
 */
- (BOOL)limitCharacterShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitCharacters:(NSString *)limits limitIndex:(NSInteger)index
{
    if ([self isFirstResponder])
    {
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:limits];
        
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
        
        if (tempStr.length >= index)
        {
            NSInteger beginIndex = index - 1;
            
            NSString *limitChar = [tempStr substringWithRange:NSMakeRange(beginIndex, 1)];
            NSRange range = [limitChar rangeOfCharacterFromSet:limitSet];
            if (range.location != NSNotFound)
            {
                return NO;
            }
        }
    }
    return YES;
}

/**
 *  限制输入长度（异常：中文联想字能被输入）
 *
 *  回调方法“- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string”中使用
 *
 *  @param maxLength 限制最大输入长度
 *  @param range     当前输入区间
 *  @param string    当前输入字符
 *
 *  @return BOOL
 */
- (BOOL)limitLength:(int)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 输入限制
    if ([self isFirstResponder] && self.text.length != 0)
    {
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
//        NSLog(@"text(max=%d length = %ld) %@", maxLength, tempStr.length, tempStr);
        
        // 限制最多输入位数
        if (tempStr.length > maxLength)
        {
            self.text = [tempStr substringToIndex:maxLength];
            return NO;
        }
    }
    
    return YES;
}

/**
 *  限制输入的字符（异常：中文联想字能被输入）
 *
 *  回调方法“- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string”中使用
 *
 *  @param string   当前正在输入的字符
 *  @param limitStr 限制输入指定的字符串
 *  @param canEdit  YES只能输入指定字符，NO只能输入指定字符外的其他字符
 *
 *  @return BOOL
 */
- (BOOL)limitTextField:(NSString *)string limitStr:(NSString *)limitStr edit:(BOOL)canEdit
{
    /*
     /// 限制textField输入的文字
     NSCharacterSet *cs;
     cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
     NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
     BOOL canChange = [string isEqualToString:filtered];
     return canChange;
     */
    
    /*
     /// 限制textField不能输入的字符
     NSCharacterSet *cs;
     cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
     NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
     BOOL canChange = [string isEqualToString:filtered];
     return !canChange;
     */
    
    BOOL isResult = NO;
    
    NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:limitStr];
    if (![string isEqualToString:@""])
    {
        NSRange range = [string rangeOfCharacterFromSet:limitSet];
        if (canEdit)
        {
            if (range.location != NSNotFound)
            {
                isResult = YES;
            }
        }
        else
        {
            if (range.location == NSNotFound)
            {
                isResult = YES;
            }
        }
        
        if (!isResult)
        {
            return NO;
        }
    }
    
    NSString *text = self.text;
    NSInteger length = text.length;
    for (int i = 0; i < length; i++)
    {
        NSString *limitChar = [text substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [limitChar rangeOfCharacterFromSet:limitSet];
        if (canEdit)
        {
            if (range.location != NSNotFound)
            {
                isResult = YES;
            }
            else
            {
                isResult = NO;
                break;
            }
        }
        else
        {
            if (range.location == NSNotFound)
            {
                isResult = YES;
            }
            else
            {
                isResult = NO;
                break;
            }
        }
    }
    
    return isResult;
}

#pragma mark - 输入限制长度（通知方法中使用）

/// 限制UITextField输入的长度（不区分中英文字符）
- (void)limitTextFieldLength:(NSUInteger)maxLength
{
    NSString *text = self.text;
    NSInteger length = [text textLength:NO];
    if (length > maxLength)
    {
        self.text = [text substringToIndex:maxLength];
    }
}

/// 限制UITextField输入的长度（区分中英文字符）
- (void)limitTextFieldCNLength:(NSUInteger)maxLength
{
    NSInteger lengthTotal = 0;
    NSInteger lengthText = 0;
    
    NSString *text = self.text;
    for (NSUInteger i = 0; i < text.length; i++)
    {
//        unichar textChar = [text characterAtIndex:i];
//        NSInteger lengthChar = (isascii(textChar) ? 1 : 2);
        NSString *subText = [text substringWithRange:NSMakeRange(i, 1)];
        NSInteger lengthChar = ([subText isENCharacter] ? 1 : 2);
        
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

- (void)setLimitMaxLength:(NSInteger)limitMaxLength
{
    if (0 < limitMaxLength)
    {
        objc_setAssociatedObject(self, @selector(limitMaxLength), @(limitMaxLength), OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textLengthEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
}

- (NSInteger)limitMaxLength
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(limitMaxLength));
    return number.integerValue;
}

- (void)setLimitText:(NSString *)limitText
{
    if (0 < limitText.length)
    {
        objc_setAssociatedObject(self, @selector(limitText), limitText, OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
}

- (NSString *)limitText
{
    NSString *text = objc_getAssociatedObject(self, @selector(limitText));
    return text;
}

- (void)setAllowedText:(NSString *)allowedText
{
    if (0 < allowedText.length)
    {
        objc_setAssociatedObject(self, @selector(allowedText), allowedText, OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allowedTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
}

- (NSString *)allowedText
{
    NSString *text = objc_getAssociatedObject(self, @selector(allowedText));
    return text;
}

#pragma mark - 通知方法

- (void)textLengthEditChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        NSInteger maxLength = self.limitMaxLength;
        [self limitTextFieldLength:maxLength];
    }
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
- (UITextField *(^)(id<UITextFieldDelegate> delegate))textFiledDelegate
{
    return ^(id<UITextFieldDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

/// 链式编程 占位符
- (UITextField *(^)(NSString *text))textFiledPlaceholder
{
    return ^(NSString *text) {
        self.placeholder = text;
        return self;
    };
}

/// 链式编程 字符
- (UITextField *(^)(NSString *text))textFiledText
{
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

/// 链式编程 字符字体大小
- (UITextField *(^)(UIFont *fong))textFiledTextFont
{
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

/// 链式编程 字符颜色
- (UITextField *(^)(UIColor *color))textFiledTextColor
{
    return ^(UIColor *color) {
        self.textColor = color;
        return self;
    };
}

/// 链式编程 字符对齐方式
- (UITextField *(^)(NSTextAlignment alignment))textFiledTextAlignment
{
    return ^(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

/// 链式编程 输入视图
- (UITextField *(^)(UIView *view))textFiledInputView
{
    return ^(UIView *view) {
        self.inputView = view;
        return self;
    };
}

/// 链式编程 附加输入视图
- (UITextField *(^)(UIView *view))textFiledInputAccessoryView
{
    return ^(UIView *view) {
        self.inputAccessoryView = view;
        return self;
    };
}

/// 链式编程 回车键盘类型
- (UITextField *(^)(UIReturnKeyType type))textFiledReturnKeyType
{
    return ^(UIReturnKeyType type) {
        self.returnKeyType = type;
        return self;
    };
}

/// 链式编程 键盘类型
- (UITextField *(^)(UIKeyboardType type))textFiledKeyboardType
{
    return ^(UIKeyboardType type) {
        self.keyboardType = type;
        return self;
    };
}

/// 链式编程 限制输入长度
- (UITextField *(^)(NSInteger length))textFieldLimitLength
{
    return ^(NSInteger length) {
        self.limitMaxLength = length;
        return self;
    };
}

/// 链式编程 限制不能输入
- (UITextField *(^)(NSString *text))textFieldLimitText
{
    return ^(NSString *text) {
        self.limitText = text;
        return self;
    };
}

/// 链式编程 限制只能输入
- (UITextField *(^)(NSString *text))textFieldAllowText
{
    return ^(NSString *text) {
        self.allowedText = text;
        return self;
    };
}

/// 链式编程 是否安全输入
- (UITextField *(^)(BOOL isSecure))textFiledSecureTextEntry
{
    return ^(BOOL isSecure) {
        self.secureTextEntry = isSecure;
        return self;
    };
}

/// 链式编程 清除按钮
- (UITextField *(^)(UITextFieldViewMode mode))textFiledClearButtonMode
{
    return ^(UITextFieldViewMode mode) {
        self.clearButtonMode = mode;
        return self;
    };
}

/// 链式编程 左视图
- (UITextField *(^)(UIView *view, UITextFieldViewMode mode))textFiledLeftView
{
    return ^(UIView *view, UITextFieldViewMode mode) {
        self.leftView = view;
        self.leftViewMode = mode;
        return self;
    };
}

/// 链式编程 右视图
- (UITextField *(^)(UIView *view, UITextFieldViewMode mode))textFiledRightView
{
    return ^(UIView *view, UITextFieldViewMode mode) {
        self.rightView = view;
        self.rightViewMode = mode;
        return self;
    };
}

@end
