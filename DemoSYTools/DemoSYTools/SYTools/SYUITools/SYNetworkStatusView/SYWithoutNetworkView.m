//
//  SYWithoutNetworkView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYWithoutNetworkView.h"

#define widthMainScreen  [UIScreen mainScreen].bounds.size.width
#define heightMainScreen [UIScreen mainScreen].bounds.size.height

static CGFloat const cornerRadius = 5.0;
static CGFloat const originXY = 10.0;
static CGFloat const heightStatusView = 44.0;
static NSTimeInterval const dutationTime = 0.3;
static NSTimeInterval const delayTime = 3.0;
static CGFloat const originYStatus = 64.0;

@interface SYWithoutNetworkView ()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) BOOL isWindow;
@property (nonatomic, assign) PositionMode positionMode;
@property (nonatomic, assign) BOOL animation;

@property (nonatomic, strong) UILabel *messagelabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SYWithoutNetworkView

+ (instancetype)shareManager
{
    static SYWithoutNetworkView *statusView = nil;
    static dispatch_once_t predicate;
    
    if (statusView == nil)
    {
        dispatch_once(&predicate, ^{
            statusView = [[self alloc] init];
        });
    }
    
    return statusView;
}

- (void)setSelf:(UIView *)view
{
    self.hidden = YES;
    
    self.frame = CGRectMake(originXY, 0.0, (widthMainScreen - originXY * 2), heightStatusView);
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapRecognizer];
    
    if (!self.superView)
    {
        self.superView = (view ? view : [[UIApplication sharedApplication].delegate window]);
        [self.superView addSubview:self];
    }
    
    self.isWindow = (view ? NO : YES);
}

- (void)resetUI:(CGFloat)width image:(UIImage *)image
{
    if (PositionTop != self.positionMode)
    {
        CGRect rectlabel = self.messagelabel.frame;
        rectlabel.size.width = width;
        self.messagelabel.frame = rectlabel;
        
        CGFloat widthSelf = originXY * 2 + width;
        widthSelf += (!image ? 0.0 : (originXY + CGRectGetHeight(self.imageView.frame)));
        CGRect rectSelf = self.frame;
        rectSelf.origin.x = ((widthMainScreen - widthSelf) / 2);
        rectSelf.size.width = widthSelf;
        self.frame = rectSelf;
    }
    
    [self layoutSubviews];
}

- (void)showWithView:(UIView *)view position:(PositionMode)posttion message:(NSString *)message image:(UIImage *)image animation:(BOOL)animation
{
    [self setSelf:view];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    self.positionMode = posttion;
    self.animation = animation;
    
    [self show:message image:image animation:animation];
}

- (void)show:(NSString *)message image:(UIImage *)image animation:(BOOL)animation
{
    self.imageView.frame = CGRectMake(originXY, originXY, (CGRectGetHeight(self.bounds) - originXY * 2), (CGRectGetHeight(self.bounds) - originXY * 2));
    if (!self.imageView.superview)
    {
        [self addSubview:self.imageView];
    }
    self.imageView.image = image;
    
    self.messagelabel.frame = CGRectMake((self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY), 0.0, (CGRectGetWidth(self.bounds) - (self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY) - originXY), CGRectGetHeight(self.bounds));
    if (!self.messagelabel.superview)
    {
        [self addSubview:self.messagelabel];
    }
    self.messagelabel.text = message;
    self.messagelabel.textAlignment = NSTextAlignmentLeft;

    CGSize sizeMessage = [self.messagelabel.text sizeWithFont:self.messagelabel.font forWidth:widthMainScreen lineBreakMode:self.messagelabel.lineBreakMode];
    CGFloat widthMessage = sizeMessage.width;
    CGFloat widthMax = (CGRectGetWidth(self.bounds) - originXY * 3 - self.imageView.frame.size.width);
    
    if (!image)
    {
        widthMax = (CGRectGetWidth(self.bounds) - originXY * 2);

        CGRect rectImage = self.imageView.frame;
        rectImage.size.width = 0.0;
        rectImage.size.height = 0.0;
        self.imageView.frame = rectImage;
        
        CGRect rectlabel = self.messagelabel.frame;
        rectlabel.origin.x = originXY;
        rectlabel.size.width = (CGRectGetWidth(self.bounds) - originXY);
        self.messagelabel.frame = rectlabel;
        self.messagelabel.textAlignment = NSTextAlignmentCenter;
    }

    widthMessage = (widthMessage >= widthMax ? widthMax : widthMessage);
    [self resetUI:widthMessage image:image];
    
    if (self.animation)
    {
        self.alpha = 0.0;
        self.hidden = NO;
        
        [UIView animateWithDuration:dutationTime animations:^{
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hidden) withObject:nil afterDelay:delayTime];
        }];
    }
    else
    {
        self.hidden = NO;
        [self performSelector:@selector(hidden) withObject:nil afterDelay:delayTime];
    }
}

- (void)hidden
{
    [UIView animateWithDuration:dutationTime animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - setter

- (void)setPositionMode:(PositionMode)positionMode
{
    _positionMode = positionMode;
    
    CGRect rectSelf = self.frame;
    
    if (PositionTop == _positionMode)
    {
        rectSelf.origin.x = 0.0;
        CGFloat originY = (self.isWindow ? (originYStatus + 0.0) : 0.0);
        rectSelf.origin.y = originY;
        rectSelf.size.width = widthMainScreen;
        
        self.layer.cornerRadius = 0.0;
        self.layer.masksToBounds = NO;
    }
    if (PositionTopRountAdjust == _positionMode)
    {
        CGFloat originY = (self.isWindow ? (originYStatus + originXY) : originXY);
        rectSelf.origin.y = originY;
    }
    else if (PositionCenterRountAdjust == _positionMode)
    {
        CGFloat originY = ((CGRectGetHeight(self.superView.bounds) - heightStatusView) / 2);
        rectSelf.origin.y = originY;
      
        [self layoutSubviews];
    }
    else if (PositionBottomRountAdjust == _positionMode)
    {
        CGFloat originY = ((CGRectGetHeight(self.superView.bounds) - heightStatusView) - originYStatus);
        rectSelf.origin.y = originY;
    
        [self layoutSubviews];
    }
    
    self.frame = rectSelf;
}

- (UILabel *)messagelabel
{
    if (!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.backgroundColor = [UIColor clearColor];
        _messagelabel.textColor = [UIColor whiteColor];
    }
    
    return _messagelabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
    }
    
    return _imageView;
}

@end
