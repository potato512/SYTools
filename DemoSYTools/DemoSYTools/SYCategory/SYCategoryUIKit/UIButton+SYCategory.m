//
//  UIButton+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIButton+SYCategory.h"
#import <objc/runtime.h>

static NSTimeInterval const timeSize = 1.0;

@interface UIButton ()

@property (nonatomic, strong) NSNumber *buttonCountdownTypeNumber;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) NSNumber *startTypeNumber;
@property (nonatomic, strong) NSNumber *countdownTime;
@property (nonatomic, strong) NSNumber *sourceCountdownTime;

@end

@implementation UIButton (SYCategory)

- (void)dealloc
{
    if (self.buttonCountdownTypeNumber.integerValue == 1)
    {
        [self setButtonCountdownType:SYCountdownTypeStop];
    }
}

#pragma mark - 按钮图标与标题样式

/// 图片与标题显示样式
- (void)buttonStyle:(SYButtonStyle)style offSet:(CGFloat)offset
{
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    // image中心移动的x距离
    CGFloat imageOringinX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    // image中心移动的y距离
    CGFloat imageOriginY = imageHeight / 2 + offset / 2;
    // label中心移动的x距离
    CGFloat labelOriginX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    // label中心移动的y距离
    CGFloat labelOriginY = labelHeight / 2 + offset / 2;
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + offset - tempHeight;
    
    switch (style)
    {
        case SYButtonStyleDefault:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, (-offset / 2), 0.0, (offset / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, (offset / 2), 0.0, (-offset / 2));
            self.contentEdgeInsets = UIEdgeInsetsMake(0.0, (offset / 2), 0.0, (offset / 2));
        }
            break;
        case SYButtonStyleImageRightTextLeftHorizontalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, (labelWidth + offset / 2), 0.0, -(labelWidth + offset / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(imageWidth + offset / 2), 0.0, (imageWidth + offset / 2));
            self.contentEdgeInsets = UIEdgeInsetsMake(0.0, offset / 2, 0.0, offset / 2);
        }
            break;
        case SYButtonStyleCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, imageOringinX, 0.0, -imageOringinX);
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -labelOriginX, 0.0, labelOriginX);
            self.contentEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        }
            break;
        case SYButtonStyleImageUpTextDownVerticalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOriginY, imageOringinX, imageOriginY, -imageOringinX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOriginY, -labelOriginX, -labelOriginY, labelOriginX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOriginY, (-changedWidth / 2), (changedHeight - imageOriginY), (-changedWidth / 2));
        }
            break;
        case SYButtonStyleImageDownTextUpVerticalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOriginY, imageOringinX, -imageOriginY, -imageOringinX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOriginY, -labelOriginX, labelOriginY, labelOriginX);
            self.contentEdgeInsets = UIEdgeInsetsMake((changedHeight - imageOriginY), (-changedWidth / 2), imageOriginY, (-changedWidth / 2));
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 回调方法

- (void)setButtonClick:(ButtonClick)buttonClick
{
    if (buttonClick)
    {
        [self addTarget:self action:@selector(buttonActionClick:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, @selector(buttonClick), buttonClick, OBJC_ASSOCIATION_COPY);
    }
}

- (ButtonClick)buttonClick
{
    ButtonClick buttonClick = objc_getAssociatedObject(self, @selector(buttonClick));
    return buttonClick;
}

- (void)buttonActionClick:(UIButton *)button
{
    if (self.buttonClick)
    {
        if (self.buttonCountdownTypeNumber.integerValue == 1)
        {
            [self setButtonCountdownType:SYCountdownTypeBegin];
        }
        self.buttonClick(button);
    }
}

#pragma mark - 倒计时按钮

#pragma mark setter/getter

- (void)setTitleNormal:(NSString *)titleNormal
{
    if (titleNormal)
    {
        [self setTitle:titleNormal forState:UIControlStateNormal];
        objc_setAssociatedObject(self, @selector(titleNormal), titleNormal, OBJC_ASSOCIATION_RETAIN);
    }
}

- (NSString * )titleNormal
{
    NSString *string = objc_getAssociatedObject(self, @selector(titleNormal));
    return string;
}

- (void)setTitleDisabledStart:(NSString *)titleDisabledStart
{
    if (titleDisabledStart)
    {
        [self setTitle:titleDisabledStart forState:UIControlStateDisabled];
        objc_setAssociatedObject(self, @selector(titleDisabledStart), titleDisabledStart, OBJC_ASSOCIATION_RETAIN);
    }
}

- (NSString *)titleDisabledStart
{
    NSString *string = objc_getAssociatedObject(self, @selector(titleDisabledStart));
    return string;
}

- (void)setTitleDisabledFinish:(NSString *)titleDisabledFinish
{
    if (titleDisabledFinish)
    {
        [self setTitle:titleDisabledFinish forState:UIControlStateDisabled];
        objc_setAssociatedObject(self, @selector(titleDisabledFinish), titleDisabledFinish, OBJC_ASSOCIATION_RETAIN);
    }
}

- (NSString *)titleDisabledFinish
{
    NSString *string = objc_getAssociatedObject(self, @selector(titleDisabledFinish));
    return string;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (titleFont)
    {
        self.titleLabel.font = titleFont;
        objc_setAssociatedObject(self, @selector(titleFont), titleFont, OBJC_ASSOCIATION_RETAIN);
    }
}

- (UIFont *)titleFont
{
    UIFont *font = objc_getAssociatedObject(self, @selector(titleFont));
    return font;
}

- (void)setColorNormal:(UIColor *)colorNormal
{
    if (colorNormal)
    {
        [self setTitleColor:colorNormal forState:UIControlStateNormal];
        objc_setAssociatedObject(self, @selector(colorNormal), colorNormal, OBJC_ASSOCIATION_RETAIN);
    }
}

- (UIColor *)colorNormal
{
    UIColor *color = objc_getAssociatedObject(self, @selector(colorNormal));
    return color;
}

- (void)setColorDisabled:(UIColor *)colorDisabled
{
    if (colorDisabled)
    {
        [self setTitleColor:colorDisabled forState:UIControlStateHighlighted];
        [self setTitleColor:colorDisabled forState:UIControlStateDisabled];
        objc_setAssociatedObject(self, @selector(colorDisabled), colorDisabled, OBJC_ASSOCIATION_RETAIN);
    }
}

- (UIColor *)colorDisabled
{
    UIColor *color = objc_getAssociatedObject(self, @selector(colorDisabled));
    return color;
}

- (void)setButtonCountdownTypeNumber:(NSNumber *)buttonCountdownTypeNumber
{
    objc_setAssociatedObject(self, @selector(buttonCountdownTypeNumber), buttonCountdownTypeNumber, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)buttonCountdownTypeNumber
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(buttonCountdownTypeNumber));
    return number;
}

- (void)setActivityView:(UIActivityIndicatorView *)activityView
{
    objc_setAssociatedObject(self, @selector(activityView), activityView, OBJC_ASSOCIATION_RETAIN);
}

- (UIActivityIndicatorView *)activityView
{
    UIActivityIndicatorView *activityView = objc_getAssociatedObject(self, @selector(activityView));
    return activityView;
}

- (void)setStartTypeNumber:(NSNumber *)startTypeNumber
{
    objc_setAssociatedObject(self, @selector(startTypeNumber), startTypeNumber, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)startTypeNumber
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(startTypeNumber));
    return number;
}

- (void)setCountdownTime:(NSNumber *)countdownTime
{
    objc_setAssociatedObject(self, @selector(countdownTime), countdownTime, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)countdownTime
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(countdownTime));
    return number;
}

- (void)setSourceCountdownTime:(NSNumber *)sourceCountdownTime
{
    objc_setAssociatedObject(self, @selector(sourceCountdownTime), sourceCountdownTime, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)sourceCountdownTime
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(sourceCountdownTime));
    return number;
}

#pragma mark 设置方法

/// 设置当前按钮为倒计时类型的按钮（必须设置先于其他属性设置前设置）
- (void)setButtonCountdownType
{
    [self setButtonCountdownUI];
}

/// 倒计时长（默认60秒）
- (void)setButtonCountdownTime:(NSTimeInterval)time
{
    self.sourceCountdownTime = [NSNumber numberWithDouble:time];
    self.countdownTime = [NSNumber numberWithDouble:time];
}

/// 倒计时开始后显示样式（菊花转，或文字，默认菊花转）
- (void)setButtonCountedownStartType:(SYCountdownStartType)type
{
    self.startTypeNumber = [NSNumber numberWithInteger:type];
}

/// 倒计时按钮状态（开始请求网络，请求成功-倒计时，请求失败-常规/停止。特别说明，若在倒计时进行时，务必在视图释放时置为CountdownTypeStop）
- (void)setButtonCountdownType:(SYCountdownType)type
{
    if (SYCountdownTypeBegin == type)
    {
        [self showBegin];
    }
    else if (SYCountdownTypeSuccess == type)
    {
        [self showSuccess];
    }
    else if (SYCountdownTypeStop == type)
    {
        [self showFail];
    }
}

#pragma mark 视图

- (void)setButtonCountdownUI
{
    if (self.titleNormal == nil)
    {
        self.titleNormal = @"获取验证码";
    }
    if (self.titleDisabledStart == nil)
    {
        self.titleDisabledStart = @"正在获取...";
    }
    if (self.titleDisabledFinish == nil)
    {
        self.titleDisabledFinish = @"秒";
    }
    if (self.countdownTime == nil)
    {
        [self setButtonCountdownTime:60.0];
    }
    
    self.buttonCountdownTypeNumber = @(1);
    
    self.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
}

- (void)showBegin
{
    self.enabled = NO;
    
    SYCountdownStartType startType = self.startTypeNumber.integerValue;
    if (SYCountdownStartTypeActivity == startType)
    {
        if (self.activityView == nil)
        {
            self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            self.activityView.hidesWhenStopped = YES;
            self.activityView.color = [UIColor redColor];
            self.activityView.center = CGPointMake((self.bounds.size.width / 2), (self.bounds.size.height / 2));
            [self addSubview:self.activityView];
            
            [self.activityView stopAnimating];
        }
        [self.activityView startAnimating];
        
        [self setTitle:nil forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateDisabled];
    }
    else if (SYCountdownStartTypeText == startType)
    {
        if (self.activityView.superview)
        {
            [self.activityView removeFromSuperview];
        }
        [self.activityView stopAnimating];
        
        [self setTitle:self.titleDisabledStart forState:UIControlStateDisabled];
    }
}

- (void)showSuccess
{
    self.enabled = NO;
    
    [self.activityView stopAnimating];
    
    // 倒计时进行时
    self.countdownTime = self.sourceCountdownTime;
    [self startCoundown];
}

- (void)showFail
{
    self.enabled = YES;
    
    [self.activityView stopAnimating];
    
    // 倒计时结束
    [self stopCountdown];
}

#pragma mark 倒计时

// 开始
- (void)startCoundown
{
    NSTimeInterval time = self.countdownTime.doubleValue;
    
    if (0.0 > time)
    {
        [self showFail];
        return;
    }
    
    NSString *title = [NSString stringWithFormat:@"%.0f%@", time, self.titleDisabledFinish];
    [self setTitle:title forState:UIControlStateDisabled];
    time -= timeSize;
    self.countdownTime = [NSNumber numberWithDouble:time];
    [self performSelector:@selector(startCoundown) withObject:nil afterDelay:timeSize];
}

// 结束
- (void)stopCountdown
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self setTitle:self.titleNormal forState:UIControlStateNormal];
}


@end
