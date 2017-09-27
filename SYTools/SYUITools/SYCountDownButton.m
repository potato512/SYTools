//
//  SYCountDownButton.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/24.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYCountDownButton.h"

static NSTimeInterval const timeSize = 1.0;

@interface SYCountDownButton ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) NSTimeInterval countdownTime;

@end

@implementation SYCountDownButton

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUI];
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

/// 初始化-frame/父视图view/倒计时长time/开始后显示样式startType/响应回调selector
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view time:(NSTimeInterval)timeCountdown startType:(CountdownStartType)type selector:(void (^)(void))selector
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
        
        [self setUI];
        
        if (view)
        {
            [view addSubview:self];
        }
  
        self.timeCountdown = timeCountdown;
        self.countDownStartType = type;
        self.buttonClick = selector;
    }
    
    return self;
}

#pragma mark - 视图

- (void)setUI
{
    self.timeCountdown = 60.0;
    self.titleNormal = @"获取验证码";
    self.titleDisabledStart = @"正在获取...";
    self.titleDisabledFinish = @"秒";
    
    self.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    
    [self addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showBegin
{
    self.enabled = NO;
    self.countdownTime = self.timeCountdown;
    
    if (CountdownStartTypeActivity == _countDownStartType)
    {
        if (!self.activityView.superview)
        {
            [self addSubview:self.activityView];
        }
        [self.activityView startAnimating];
        
        [self setTitle:nil forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateDisabled];
    }
    else if (CountdownStartTypeText == _countDownStartType)
    {
        if (self.activityView.superview)
        {
            [self.activityView removeFromSuperview];
        }
        [self.activityView stopAnimating];
        
        [self setTitle:_titleDisabledStart forState:UIControlStateDisabled];
    }
}

- (void)showSuccess
{
    self.enabled = NO;
    
    if (self.activityView.superview)
    {
        [self.activityView removeFromSuperview];
    }
    [self.activityView stopAnimating];
    
    // 倒计时进行时
    [self startCoundown];
}

- (void)showFail
{
    self.enabled = YES;
    
    if (self.activityView.superview)
    {
        [self.activityView removeFromSuperview];
    }
    [self.activityView stopAnimating];

    // 倒计时结束
    [self stopCountdown];
}

#pragma mark - 响应

- (void)buttonAction
{
    self.countdownType = CountdownTypeBegin;
    
    if (self.buttonClick)
    {
        self.buttonClick();
    }
}

#pragma mark - 倒计时

// 开始
- (void)startCoundown
{
    if (0 > _countdownTime)
    {
        [self showFail];
        return;
    }
    
    NSString *title = [NSString stringWithFormat:@"%.0f%@", _countdownTime, _titleDisabledFinish];
    [self setTitle:title forState:UIControlStateDisabled];
    _countdownTime -= timeSize;
    [self performSelector:@selector(startCoundown) withObject:nil afterDelay:timeSize];
}

// 结束
- (void)stopCountdown
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self setTitle:_titleNormal forState:UIControlStateNormal];
}

#pragma mark - setter

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activityView stopAnimating];
        _activityView.hidesWhenStopped = YES;
        _activityView.color = [UIColor redColor];
    }
    
    _activityView.center = CGPointMake((self.bounds.size.width / 2), (self.bounds.size.height / 2));
    
    return _activityView;
}

- (void)setCountDownStartType:(CountdownStartType)countDownStartType
{
    _countDownStartType = countDownStartType;
}

- (void)setCountdownType:(CountdownType)countdownType
{
    _countdownType = countdownType;
    
    if (CountdownTypeBegin == _countdownType)
    {
        [self showBegin];
    }
    else if (CountdownTypeSuccess == _countdownType)
    {
        [self showSuccess];
    }
    else if (CountdownTypeStop == _countdownType)
    {
        [self showFail];
    }
}

- (void)setTitleNormal:(NSString *)titleNormal
{
    _titleNormal = titleNormal;
    [self setTitle:_titleNormal forState:UIControlStateNormal];
}

- (void)setTitleDisabledStart:(NSString *)titleDisabledStart
{
    _titleDisabledStart = titleDisabledStart;
    [self setTitle:_titleDisabledStart forState:UIControlStateDisabled];
}

- (void)setTitleDisabledFinish:(NSString *)titleDisabledFinish
{
    _titleDisabledFinish = titleDisabledFinish;
    [self setTitle:_titleDisabledFinish forState:UIControlStateDisabled];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLabel.font = _titleFont;
}

- (void)setColorNormal:(UIColor *)colorNormal
{
    _colorNormal = colorNormal;

    [self setTitleColor:_colorNormal forState:UIControlStateNormal];
}

- (void)setColorDisabled:(UIColor *)colorDisabled
{
    _colorDisabled = colorDisabled;

    [self setTitleColor:_colorDisabled forState:UIControlStateHighlighted];
    [self setTitleColor:_colorDisabled forState:UIControlStateDisabled];
}

@end
