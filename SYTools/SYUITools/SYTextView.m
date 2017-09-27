//
//  SYTextView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/4.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYTextView.h"

#define originX 8.0
#define originY 6.0

@interface SYTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderlabel;

@property (nonatomic, copy) void (^startBlock)(UITextView *textView);
@property (nonatomic, copy) void (^changeRankBlock)(UITextView *textView, NSRange range, NSString *text);
@property (nonatomic, copy) void (^endBlock)(UITextView *textView);

@property (nonatomic, assign) BOOL isLimitLength;
@property (nonatomic, assign) BOOL isShowPlaceHolder;

@end

@implementation SYTextView

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
        [self setUI];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建视图

- (void)setUI
{
    self.delegate = self;
    
    self.placeHolderlabel = InsertLabel(self, CGRectMake(originX, originY, (self.width - originX * 2), 0.0), NSTextAlignmentLeft, nil, nil, nil, NO);
    self.placeHolderlabel.numberOfLines = 0;
    self.placeHolderlabel.hidden = YES;
}

- (void)resetPlaceholderlabel
{
    CGFloat height = [self heightWithText:self.placeHolderlabel.text font:self.placeHolderlabel.font constrainedToWidth:self.placeHolderlabel.width];
    
    CGRect rect = self.placeHolderlabel.frame;
    rect.size.height = height;
    self.placeHolderlabel.frame = rect;
}

#pragma mark - 信息处理

/// 限制输入的字符
+ (BOOL)limitTextView:(UITextView *)textView string:(NSString *)string limitStr:(NSString *)limitStr
{
    if (![string isEqualToString:@""])
    {
        NSRange range = [limitStr rangeOfString:string];
        if (range.location == NSNotFound)
        {
            return  NO;
        }
    }
    
    NSString *text = textView.text;
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
+ (void)limitTextView:(UITextView *)textView Length:(NSUInteger)kMaxLength
{
    NSString *toBeString = textView.text;
    NSInteger length = toBeString.length;
    if (length > kMaxLength)
    {
        textView.text = [toBeString substringToIndex:kMaxLength];
    }
}

#pragma mark - methord

- (void)editingStart:(void (^)(UITextView *textView))startEditing editingChange:(void (^)(UITextView *textView, NSRange range, NSString *text))changeEditing editingEnd:(void (^)(UITextView *textView))endEditing
{
    self.startBlock = startEditing;
    self.changeRankBlock = changeEditing;
    self.endBlock = endEditing;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.startBlock && [self isFirstResponder])
    {
        self.startBlock(textView);
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.endBlock && [self isFirstResponder])
    {
        self.endBlock(textView);
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self isFirstResponder])
    {
        if (self.isEndEditingWhileReturn && [text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
        }
        
        if (self.limitStr && 0 < self.limitStr.length)
        {
            BOOL isResult = [[self class] limitTextView:self string:text limitStr:_limitStr];
            if (isResult)
            {
                if (self.changeRankBlock)
                {
                    self.changeRankBlock(textView, range, text);
                }
            }
            return isResult;
        }
        else
        {
            if (self.changeRankBlock)
            {
                self.changeRankBlock(textView, range, text);
            }
        }
    }
    
    return YES;
}

- (void)textViewEditChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        if (self.isShowPlaceHolder)
        {
            NSString *string = self.text;
            self.placeHolderlabel.hidden = ([NSString isNullNSString:string] ? NO : YES);
        }
        
        if (self.isLimitLength)
        {
            [[self class] limitTextView:self Length:_limitLength];
        }
    }
}

#pragma mark - setter

- (void)setPlaceHolderText:(NSString *)placeHolderText
{
    _placeHolderText = placeHolderText;
    if (![NSString isNullNSString:_placeHolderText])
    {
        self.isShowPlaceHolder = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        self.placeHolderlabel.text = _placeHolderText;
        self.placeHolderlabel.hidden = NO;
        
        [self resetPlaceholderlabel];
    }
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    _placeHolderFont = placeHolderFont;
    if (_placeHolderFont)
    {
        self.placeHolderlabel.font = _placeHolderFont;
        
        [self resetPlaceholderlabel];
    }
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeHolderlabel.textColor = _placeHolderColor;
}

- (void)setLimitLength:(NSInteger)limitLength
{
    _limitLength = limitLength;
    
    if (0 < _limitLength)
    {
        self.isLimitLength = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (void)setLimitStr:(NSString *)limitStr
{
    _limitStr = limitStr;
}

@end
