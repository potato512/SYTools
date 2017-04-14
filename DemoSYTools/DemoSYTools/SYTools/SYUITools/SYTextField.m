//
//  SYTextField.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/3.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYTextField.h"

@interface SYTextField () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *view;

@property (nonatomic, copy) void (^editingStart)(UITextField *textField);
@property (nonatomic, copy) void (^editingChange)(UITextField *textField, NSRange range, NSString *string);
@property (nonatomic, copy) void (^editingReturn)(UITextField *textField);
@property (nonatomic, copy) void (^editingEnd)(UITextField *textField);

@property (nonatomic, copy) void (^showKeyboard)(CGSize size);
@property (nonatomic, copy) void (^hiddenKeyboard)(void);

@end

@implementation SYTextField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - 信息处理

/// 限制输入的字符
+ (BOOL)limitTextField:(UITextField *)textField string:(NSString *)string limitStr:(NSString *)limitStr
{
    if (![string isEqualToString:@""])
    {
        NSRange range = [limitStr rangeOfString:string];
        if (range.location == NSNotFound)
        {
            return  NO;
        }
    }
    
    NSString *text = textField.text;
    NSInteger length = text.length;
    for (int i = 0; i < length; i++)
    {
        NSString *subText = [text substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [limitStr rangeOfString:subText];
        if (range.location == NSNotFound)
        {
            break;
            return  NO;
        }
    }
    return YES;
}

/// 限制输入的字符长度
+ (void)limitTextField:(UITextField *)textField Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    NSInteger length = toBeString.length;
    if (length > kMaxLength)
    {
        textField.text = [toBeString substringToIndex:kMaxLength];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.editingStart && [self isFirstResponder])
    {
        self.editingStart(textField);
    }
    
    if (self.showKeyboard && self.isFirstResponder)
    {
        NSNotificationCenterReceive(UIKeyboardWillShowNotification, self, @selector(showKeyboard:));
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.editingEnd && [self isFirstResponder])
    {
        self.editingEnd(textField);
    }
    
    if (self.hiddenKeyboard && self.isFirstResponder)
    {
        NSNotificationCenterReceive(UIKeyboardDidHideNotification, self, @selector(hiddenKeyboard:));
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self isFirstResponder])
    {
        if (self.limitStr && 0 < self.limitStr.length)
        {
            BOOL isResult = [[self class] limitTextField:self string:string limitStr:_limitStr];
            if (isResult)
            {
                if (self.editingChange)
                {
                    self.editingChange(textField, range, string);
                }
            }
            return isResult;
        }
        else
        {
            if (self.editingChange)
            {
                self.editingChange(textField, range, string);
            }
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self isFirstResponder])
    {
        if (self.isEndEditingWhileReturn)
        {
            [textField resignFirstResponder];
        }
        
        if (self.editingReturn)
        {
            self.editingReturn(textField);
        }
    }
    
    return YES;
}

#pragma mark - 回调响应

- (void)editingStart:(void (^)(UITextField *textField))startEditing editingChange:(void (^)(UITextField *textField, NSRange range, NSString *string))changeEditing editingReturn:(void (^)(UITextField *textField))returnEditing editingEnd:(void (^)(UITextField *textField))endEditing
{
    self.editingStart = startEditing;
    self.editingChange = changeEditing;
    self.editingReturn = returnEditing;
    self.editingEnd = endEditing;
}

- (void)textFiledEditChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        [[self class] limitTextField:self Length:_limitLength];
    }
}

- (void)showKeyboard:(void (^)(CGSize keyboardSize))show hiddenKeyboard:(void (^)(void))hidden
{
    self.showKeyboard = [show copy];
    self.hiddenKeyboard = [hidden copy];
}

- (void)showKeyboard:(NSNotification *)notification
{
    if (self.showKeyboard)
    {
        NSDictionary *dict = [notification userInfo];
        CGSize size = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        self.showKeyboard(size);
    }
}

- (void)hiddenKeyboard:(NSNotification *)notification
{
    if (self.hiddenKeyboard)
    {
        self.hiddenKeyboard();
    }
}

#pragma mark - setter

- (void)setViewMode:(ViewModeType)viewMode
{
    _viewMode = viewMode;
 
    if (ViewModeTypeLeft == _viewMode)
    {
        self.leftView = self.view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    else if (ViewModeTypeRight == _viewMode)
    {
        self.rightView = self.view;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

- (void)setLimitLength:(NSInteger)limitLength
{
    _limitLength = limitLength;
    
    if (0 < _limitLength)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
}

- (void)setLimitStr:(NSString *)limitStr
{
    _limitStr = limitStr;
}

#pragma mark - getter

- (UIView *)view
{
    if (!_view)
    {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 0.0)];
        _view.backgroundColor = [UIColor redColor];
    }
    
    return _view;
}

@end
