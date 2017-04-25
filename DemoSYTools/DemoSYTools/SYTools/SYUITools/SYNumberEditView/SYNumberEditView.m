//
//  SYNumberEditView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/4/25.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "SYNumberEditView.h"

#define borderCornerMin 0.0
#define borderCornerMax (self.frame.size.height / 2)
#define borderWidthMin 0.5
#define borderWidthMax 2.0

static NSString *const limitNumberText = @"0123456789";

@interface SYNumberEditView () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *buttonReduce;
@property (nonatomic, strong) UIButton *buttonAddMore;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIView *lineLeft;
@property (nonatomic, strong) UIView *lineRight;

@end

@implementation SYNumberEditView

@synthesize number = _number;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initializeInfo];
        
        [self setUI];
        [self resetUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initializeInfo];
        [self setUI];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    NSLog(@"%@~被释放了", self);
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [self resetUI];
}

#pragma mark - 视图

- (void)initializeInfo
{
    _textFont = [UIFont systemFontOfSize:12.0];
    _textColor = [UIColor blackColor];
    
    _borderShow = NO;
    _borderCornerRadius = borderCornerMin;
    _borderColor = [UIColor blackColor];
    _borderWidth = borderWidthMin;
}

- (void)setUI
{
    [self addSubview:self.buttonReduce];
    [self addSubview:self.textField];
    [self addSubview:self.buttonAddMore];
    [self.buttonReduce addSubview:self.lineLeft];
    [self.buttonAddMore addSubview:self.lineRight];
    
    // 初始化
    self.lineLeft.hidden = !_borderShow;
    self.lineRight.hidden = !_borderShow;
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEdictChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)resetUI
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    width = (width < height * 3) ? (height * 3) : width;
    
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    
    CGFloat sizeButton = self.frame.size.height;
    self.buttonReduce.frame = CGRectMake(0.0, 0.0, sizeButton, sizeButton);
    self.buttonAddMore.frame = CGRectMake((self.frame.size.width - sizeButton), 0.0, sizeButton, sizeButton);
    self.textField.frame = CGRectMake(sizeButton, 0.0, (self.frame.size.width - sizeButton * 2), sizeButton);
    self.lineLeft.frame = CGRectMake((self.buttonReduce.frame.size.width - _borderWidth), 0.0, _borderWidth, sizeButton);
    self.lineRight.frame = CGRectMake(0.0, 0.0, _borderWidth, sizeButton);
}

#pragma mark - 响应

- (void)buttonReduceClick
{
    if ([self.textField isFirstResponder])
    {
        [self.textField resignFirstResponder];
    }
    
    NSString *numberText = self.textField.text;
    NSInteger number = numberText.integerValue;
    if (number > 0)
    {
        number--;
        numberText = [NSString stringWithFormat:@"%@", @(number)];
    }
    else
    {
        numberText = @"0";
    }
    self.textField.text = numberText;
    
    if (self.numberEdit)
    {
        self.numberEdit(number);
    }
}

- (void)buttonAddMoreClick
{
    if ([self.textField isFirstResponder])
    {
        [self.textField resignFirstResponder];
    }
    
    NSString *numberText = self.textField.text;
    NSInteger number = numberText.integerValue;
    number++;
    if (number >= self.numberMax && 0 < self.numberMax)
    {
        number = self.numberMax;
    }
    numberText = [NSString stringWithFormat:@"%@", @(number)];
    self.textField.text = numberText;
    
    if (self.numberEdit)
    {
        self.numberEdit(number);
    }
}

#pragma mark - UITextFieldDelegate

- (void)textEdictChange:(NSNotification *)notification
{
    NSString *numberText = self.textField.text;
    // 限制输入数字
    for (int i = 0; i < numberText.length; i++)
    {
        NSString *subText = [numberText substringWithRange:NSMakeRange(i, 1)];
        // 首个输入不能为0
        if (0 == i && subText.integerValue == 0)
        {
            numberText = [numberText stringByReplacingOccurrencesOfString:subText withString:@""];
        }
        
        NSRange range = [limitNumberText rangeOfString:subText];
        if (range.location == NSNotFound)
        {
            numberText = [numberText stringByReplacingOccurrencesOfString:subText withString:@""];
        }
    }
    
    // 限制最大值
    NSInteger number = numberText.integerValue;
    if (number >= self.numberMax && 0 < self.numberMax)
    {
        number = self.numberMax;
    }
    numberText = [NSString stringWithFormat:@"%@", @(number)];
    self.textField.text = numberText;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder])
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - getter

- (UIButton *)buttonReduce
{
    if (_buttonReduce == nil)
    {
        _buttonReduce = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonReduce.backgroundColor = [UIColor clearColor];
        [_buttonReduce setTitle:@"-" forState:UIControlStateNormal];
        [_buttonReduce setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonReduce setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        _buttonReduce.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_buttonReduce addTarget:self action:@selector(buttonReduceClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonReduce;
}

- (UIButton *)buttonAddMore
{
    if (_buttonAddMore == nil)
    {
        _buttonAddMore = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonAddMore.backgroundColor = [UIColor clearColor];
        [_buttonAddMore setTitle:@"+" forState:UIControlStateNormal];
        [_buttonAddMore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buttonAddMore setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        _buttonAddMore.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_buttonAddMore addTarget:self action:@selector(buttonAddMoreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonAddMore;
}

- (UITextField *)textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = _textFont;
        _textField.textColor = _textColor;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIView *)lineLeft
{
    if (_lineLeft == nil)
    {
        _lineLeft = [[UIView alloc] init];
        _lineLeft.backgroundColor = _borderColor;
    }
    return _lineLeft;
}

- (UIView *)lineRight
{
    if (_lineRight == nil)
    {
        _lineRight = [[UIView alloc] init];
        _lineRight.backgroundColor = _borderColor;
    }
    return _lineRight;
}

#pragma mark - setter

- (void)setReduceImageNormal:(UIImage *)reduceImageNormal
{
    _reduceImageNormal = reduceImageNormal;
    if (_reduceImageNormal)
    {
        [self.buttonReduce setTitle:nil forState:UIControlStateNormal];
        [self.buttonReduce setImage:_reduceImageNormal forState:UIControlStateNormal];
    }
}

- (void)setReduceImageHighlight:(UIImage *)reduceImageHighlight
{
    _reduceImageHighlight = reduceImageHighlight;
    if (_reduceImageHighlight)
    {
        [self.buttonReduce setTitle:nil forState:UIControlStateHighlighted];
        [self.buttonReduce setImage:_reduceImageHighlight forState:UIControlStateHighlighted];
    }
}

- (void)setAddImageNormal:(UIImage *)addImageNormal
{
    _addImageNormal = addImageNormal;
    if (_addImageNormal)
    {
        [self.buttonAddMore setTitle:nil forState:UIControlStateNormal];
        [self.buttonAddMore setImage:_addImageNormal forState:UIControlStateNormal];
    }
}

- (void)setAddImageHighlight:(UIImage *)addImageHighlight
{
    _addImageHighlight = addImageHighlight;
    if (_addImageHighlight)
    {
        [self.buttonAddMore setTitle:nil forState:UIControlStateHighlighted];
        [self.buttonAddMore setImage:_addImageHighlight forState:UIControlStateHighlighted];
    }
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    if (_textFont)
    {
        self.textField.font = _textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (_textColor)
    {
        self.textField.textColor = _textColor;
    }
}

- (void)setNumber:(NSInteger)number
{
    _number = number;
    NSString *numberText = [NSString stringWithFormat:@"%@", @(_number)];
    if (0 >= number)
    {
        numberText = @"0";
    }
    self.textField.text = numberText;
}

- (NSInteger)number
{
    return self.textField.text.integerValue;
}

- (void)setBorderShow:(BOOL)borderShow
{
    _borderShow = borderShow;
    if (_borderShow)
    {
        self.layer.borderColor = _borderColor.CGColor;
        self.layer.borderWidth = _borderWidth;
        self.layer.cornerRadius = _borderCornerRadius;
        self.layer.masksToBounds = YES;
        
        self.lineLeft.hidden = NO;
        self.lineLeft.backgroundColor = _borderColor;
        CGRect rectLeft = self.lineLeft.frame;
        rectLeft.origin.x = (self.buttonReduce.frame.size.width - _borderWidth);
        rectLeft.size.width = _borderWidth;
        self.lineLeft.frame = rectLeft;
        
        self.lineRight.hidden = NO;
        self.lineRight.backgroundColor = _borderColor;
        CGRect rectRight = self.lineRight.frame;
        rectRight.size.width = _borderWidth;
        self.lineRight.frame = rectRight;
    }
    else
    {
        self.layer.borderColor = nil;
        self.layer.borderWidth = 0.0;
        self.layer.cornerRadius = 0.0;
        self.layer.masksToBounds = YES;
        
        self.lineLeft.hidden = YES;
        self.lineRight.hidden = YES;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    if (_borderShow)
    {
        self.layer.borderColor = _borderColor.CGColor;
        
        self.lineLeft.backgroundColor = _borderColor;
        self.lineRight.backgroundColor = _borderColor;
    }
}

- (void)setBorderCornerRadius:(CGFloat)borderCornerRadius
{
    _borderCornerRadius = borderCornerRadius;
    if (_borderShow)
    {
        _borderCornerRadius = (borderCornerMin > _borderCornerRadius ? borderCornerMin : (borderCornerMax < _borderCornerRadius ? borderCornerMax : _borderCornerRadius));
        self.layer.cornerRadius = _borderCornerRadius;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    if (_borderShow)
    {
        _borderWidth = (borderWidthMin > _borderWidth ? borderWidthMin : (borderWidthMax < _borderWidth ? borderWidthMax : _borderWidth));
        self.layer.borderWidth = _borderWidth;
        
        CGRect rectLeft = self.lineLeft.frame;
        rectLeft.origin.x = (self.buttonReduce.frame.size.width - _borderWidth);
        rectLeft.size.width = _borderWidth;
        self.lineLeft.frame = rectLeft;
        
        self.lineRight.backgroundColor = _borderColor;
        CGRect rectRight = self.lineRight.frame;
        rectRight.size.width = _borderWidth;
        self.lineRight.frame = rectRight;
    }
}

@end
