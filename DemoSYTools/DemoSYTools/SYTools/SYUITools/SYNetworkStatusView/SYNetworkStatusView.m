//
//  SYNetworkStatusView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYNetworkStatusView.h"

#define widthMainScreen  [UIScreen mainScreen].bounds.size.width
#define heightMainScreen [UIScreen mainScreen].bounds.size.height
#define viewWindow       [[UIApplication sharedApplication].delegate window]

static CGFloat const originXY     = 10.0;
#define sizeImage    SYAutoSizeGetHeight(130.0)
#define heightlabel  SYAutoSizeGetHeight(40.0)
#define widthButton  SYAutoSizeGetWidth(80.0)
#define heightButton SYAutoSizeGetHeight(35.0)

#define originY                    ((CGRectGetHeight(self.bounds) - 44 - sizeImage) / 2)
//#define originyWithMessage         ((CGRectGetHeight(self.bounds) - (44 + sizeImage + heightlabel + originXY)) / 2)
//#define originyWithButton          ((CGRectGetHeight(self.bounds) - (44 + sizeImage + heightButton + originXY)) / 2)
//#define originYWithMessageAndButon ((CGRectGetHeight(self.bounds) - (44 + sizeImage + heightlabel + originXY * 2 + heightButton)) / 2)
#define originyWithMessage         (((CGRectGetHeight(self.bounds) - (44 + sizeImage + heightlabel + originXY)) / 2) - ((NetworkStatusShowTypeTop == self.showType) ? (heightlabel + originXY) : 0.0))
#define originyWithButton          (((CGRectGetHeight(self.bounds) - (44 + sizeImage + heightButton + originXY)) / 2) - ((NetworkStatusShowTypeTop == self.showType) ? (heightButton + originXY) : 0.0))
#define originYWithMessageAndButon (((CGRectGetHeight(self.bounds) - (44 + sizeImage + heightlabel + originXY * 2 + heightButton)) / 2) - ((NetworkStatusShowTypeTop == self.showType) ? (heightlabel + originXY) : 0.0))

static NSString *const defaultButtonTitle = @"重新加载";
static NSString *const defaultFailueTitle = @"没有网络";
static NSString *const defaultTitle       = @"查不到相关数据";

#define defaultImageEmpty        kImageWithName(@"status_Empty")
#define defaultImageNetworkError kImageWithName(@"status_ErrorNetwork")

@interface SYNetworkStatusView ()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) BOOL isActivity;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *activityImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *messagelabel;
@property (nonatomic, strong) UIButton *reStartButton;

@property (nonatomic, assign) BOOL isAnimationImage;

@end

@implementation SYNetworkStatusView

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self)
    {
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self setUI:view];
    }
    
    return self;
}

- (void)setUI:(UIView *)view
{
    if (!self.superView && view)
    {
        self.superView = view;
        
        self.frame = view.bounds;
        [view addSubview:self];
        
        self.backgroundColor = view.backgroundColor;
        
        [self setUIWithRealFrame];
    }
}

- (void)setViewFrame:(CGRect)rect
{
    self.frame = rect;
    
    [self setUIWithRealFrame];
}

- (void)setUIWithRealFrame
{
    self.activityImageView.center = CGPointMake((CGRectGetWidth(self.bounds) / 2), CGRectGetHeight(self.bounds) / 2);
    [self addSubview:self.activityImageView];
    self.activityImageView.hidden = YES;
    self.activityView.center = CGPointMake((CGRectGetWidth(self.bounds) / 2), (CGRectGetHeight(self.bounds) / 2));
    [self addSubview:self.activityView];
    self.activityView.hidden = YES;

    
    self.iconImageView.frame = CGRectMake(((CGRectGetWidth(self.bounds) - sizeImage) / 2), originYWithMessageAndButon, sizeImage, sizeImage);
    [self addSubview:self.iconImageView];
    self.iconImageView.hidden = YES;
    
    UIView *currentView = self.iconImageView;
    
    self.messagelabel.frame = CGRectMake(originXY, (currentView.frame.origin.y + currentView.frame.size.height + originXY), (CGRectGetWidth(self.bounds) - originXY * 2), heightlabel);
    [self addSubview:self.messagelabel];
    self.messagelabel.hidden = YES;
    
    currentView = self.messagelabel;
    
    self.reStartButton.frame = CGRectMake(((CGRectGetWidth(self.bounds) - widthButton) / 2), (currentView.frame.origin.y + currentView.frame.size.height + originXY), widthButton, heightButton);
    [self addSubview:self.reStartButton];
    self.reStartButton.hidden = YES;
}

- (void)resetUI
{
    if (!self.superview)
    {
        [self.superView addSubview:self];
    }
    [self.superView bringSubviewToFront:self];
    
    if (self.isAnimationImage)
    {
        if ([self.activityImageView isAnimating])
        {
            [self.activityImageView stopAnimating];
        }
        self.activityImageView.hidden = YES;
    }
    else
    {
        if ([self.activityView isAnimating])
        {
            [self.activityView stopAnimating];
        }
        self.activityView.hidden = YES;
    }
    
    self.iconImageView.hidden = YES;
    self.messagelabel.hidden = YES;
    self.reStartButton.hidden = YES;
}

- (void)setStatusUI:(NSString *)message image:(UIImage *)image
{
    [self resetUI];
    
    self.message = message;
    self.image = image;
    
    self.iconImageView.image = image;
    self.messagelabel.text = message;
    
    self.iconImageView.hidden = NO;
    CGRect rectImage = self.iconImageView.frame;
    rectImage.origin.y = originyWithMessage;

    self.messagelabel.hidden = NO;
    CGRect rectlabel = self.messagelabel.frame;
    rectlabel.origin.y = (originyWithMessage + CGRectGetHeight(self.iconImageView.bounds) + originXY);

    if (!message || 0 == message.length)
    {
        rectImage.origin.y = originY;

        rectlabel.origin.y = (originyWithMessage + CGRectGetHeight(self.iconImageView.bounds) + originXY);
        rectlabel.size.height = 0.0;
        self.messagelabel.hidden = YES;
    }
    
    self.iconImageView.frame = rectImage;
    
    self.messagelabel.frame = rectlabel;
}

- (void)statusloadedFinish
{
    if (self.isActivity)
    {
        if (self.isAnimationImage)
        {
            if ([self.activityImageView isAnimating])
            {
                [self.activityImageView stopAnimating];
            }
        }
        else
        {
            if ([self.activityView isAnimating])
            {
                [self.activityView stopAnimating];
            }
        }
    }
    
    if (self.superview)
    {
        [self removeFromSuperview];
    }
}

#pragma mark - 网络状态

// 开始（菊花转）
- (void)statusloadStart
{
    [self resetUI];
    
    self.isActivity = YES;
    
    if (self.isAnimationImage)
    {
        [self.activityImageView startAnimating];
        self.activityImageView.hidden = NO;
    }
    else
    {
        self.activityView.color = [UIColor redColor];
        [self.activityView startAnimating];
        self.activityView.hidden = NO;
    }
}

// 开始（自定义）
- (void)statusloadStartCustom:(NSString *)message image:(UIImage *)image
{
    self.message = message;
    self.image = image;
    
    [self setStatusUI:message image:image];
}

// 结束，加载成功
- (void)statusloadSueccess
{
    [self statusloadedFinish];
}

// 结束，加载成功，无数据
- (void)statusloadSuccessWithoutData:(NSString *)message image:(UIImage *)image
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *defaultMessage = (message ? message : defaultTitle);
    UIImage *defaultImage = (image ? image : defaultImageEmpty);
    [self setStatusUI:defaultMessage image:defaultImage];
}

// 结束，加载成功无数据（重新加载）
- (void)statusloadSuccessAndRestart:(NSString *)message image:(UIImage *)image
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.message = message;
    self.image = image;
    
    [self statusloadSuccessAndRestart:message image:image title:nil];
}

// 结束，加载成功无数据（非重新加载，自定义）
- (void)statusloadSuccessAndRestart:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *defaultMessage = (message ? message : defaultTitle);
    UIImage *defaultImage = (image ? image : defaultImageEmpty);
    [self statusloadFinish:defaultMessage image:defaultImage title:buttonTitle restart:NO];
}

// 结束，加载成功无数据（是否重新加载，自定义）
- (void)statusloadSuccessAndRestart:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle reStart:(BOOL)isRestart
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *defaultMessage = (message ? message : defaultTitle);
    UIImage *defaultImage = (image ? image : defaultImageEmpty);
    [self statusloadFinish:defaultMessage image:defaultImage title:buttonTitle restart:isRestart];
}

// 结束，加载失败
- (void)statusloadFailue:(NSString *)message image:(UIImage *)image
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSString *defaultMessage = (message ? message : defaultFailueTitle);
    UIImage *defaultImage = (image ? image : defaultImageNetworkError);
    [self setStatusUI:defaultMessage image:defaultImage];
}

// 结束，加载失败（重新加载）
- (void)statusloadFailueAndRestart:(NSString *)message image:(UIImage *)image
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self statusloadFailueAndRestart:message image:image title:nil];
}

// 结束，加载失败（重新加载，自定义）
- (void)statusloadFailueAndRestart:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle
{
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UIImage *defaultImage = (image ? image : defaultImageNetworkError);
    NSString *defaultMessage = (message ? message : defaultFailueTitle);
    [self statusloadFinish:defaultMessage image:defaultImage title:buttonTitle restart:YES];
}

// 结束，成功或失败（重新加载。自定义信息，图标，标题）
- (void)statusloadFinish:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle restart:(BOOL)isRestart
{
    [self resetUI];
    
    UIImage *defaultImage = (image ? image : defaultImageNetworkError);
    NSString *defaultMessage = (message ? message : defaultFailueTitle);
    NSString *defaultTitle = (buttonTitle ? buttonTitle : defaultButtonTitle);
    
    self.message = defaultMessage;
    self.image = defaultImage;
    
    self.iconImageView.hidden = NO;
    self.iconImageView.image = defaultImage;
    CGRect rectImage = self.iconImageView.frame;
    rectImage.origin.y = originYWithMessageAndButon;
    
    self.messagelabel.hidden = NO;
    NSRange rangeEnter = [defaultMessage rangeOfString:@"\n"];
    if (rangeEnter.location != NSNotFound)
    {
        NSString *lastMessage = [defaultMessage substringFromIndex:rangeEnter.location + rangeEnter.length];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:defaultMessage];
        [attributedString attributedText:lastMessage font:kFontSize10 color:kColorLightBlack];
        self.messagelabel.attributedText = attributedString;
    }
    else
    {
        self.messagelabel.text = defaultMessage;
    }
    CGRect rectlabel = self.messagelabel.frame;
    rectlabel.origin.y = (originYWithMessageAndButon + CGRectGetHeight(self.iconImageView.bounds) + originXY);
    
    if (!defaultMessage || 0 == defaultMessage.length)
    {
        rectImage.origin.y = originyWithButton;
        
        rectlabel.origin.y = (originyWithButton + CGRectGetHeight(self.iconImageView.bounds) + originXY);
        rectlabel.size.height = 0.0;
        self.messagelabel.hidden = YES;
    }
    
    self.iconImageView.frame = rectImage;
    
    self.messagelabel.frame = rectlabel;

    self.reStartButton.hidden = NO;
    CGRect rectButton = self.reStartButton.frame;
    rectButton.origin.y = (self.messagelabel.frame.origin.y + CGRectGetHeight(self.messagelabel.bounds) + originXY);
    self.reStartButton.frame = rectButton;
    [self.reStartButton setTitle:defaultTitle forState:UIControlStateNormal];
    if (isRestart)
    {
        [self.reStartButton addTarget:self action:@selector(buttonRestart:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self.reStartButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 响应

- (void)buttonRestart:(UIButton *)button
{
    if (self.isActivity)
    {
        [self statusloadStart];
    }
    else
    {
        [self statusloadStartCustom:self.message image:self.image];
    }
    
    if (self.buttonClick)
    {
        self.buttonClick();
    }
}

- (void)buttonAction:(UIButton *)button
{
    if (self.buttonClick)
    {
        self.buttonClick();
    }
}

#pragma mark - setter/getter

#pragma mark setter

- (void)setAnimationImages:(NSArray *)animationImages
{
    _animationImages = animationImages;
    
    if (_animationImages && 0 != _animationImages.count)
    {
        _activityImageView.animationImages = _animationImages;
        self.isAnimationImage = YES;
    }
}

#pragma mark getter

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.backgroundColor = [UIColor clearColor];
        
        _activityView.hidesWhenStopped = YES;
    }
    
    return _activityView;
}

- (UIImageView *)activityImageView
{
    if (!_activityImageView)
    {
        _activityImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, sizeImage, sizeImage)];
        _activityImageView.backgroundColor = [UIColor clearColor];
        
        _activityImageView.animationDuration = 0.5;
        _activityImageView.animationRepeatCount = 0;
        [_activityImageView stopAnimating];
    }
    
    return _activityImageView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _iconImageView;
}

- (UILabel *)messagelabel
{
    if (!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.backgroundColor = [UIColor clearColor];
        _messagelabel.numberOfLines = 0;
        _messagelabel.textColor = UIColorHex(0x323232);
        _messagelabel.font = kFontSize15;
        _messagelabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _messagelabel;
}

- (UIButton *)reStartButton
{
    if (!_reStartButton)
    {
        _reStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reStartButton.backgroundColor = kColorClear;
     
        [_reStartButton layerWithRadius:5.0 borderColor:nil borderWidth:0.0];
        
        [_reStartButton setTitle:defaultButtonTitle forState:UIControlStateNormal];
        [_reStartButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        _reStartButton.titleLabel.font = kFontSize13;
        [_reStartButton setBackgroundImage:kImageWithColor(kColorRed) forState:UIControlStateNormal];
        [_reStartButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
    
    return _reStartButton;
}

@end
