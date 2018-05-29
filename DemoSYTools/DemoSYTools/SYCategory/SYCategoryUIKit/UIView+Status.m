//
//  UIView+Status.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/11/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "UIView+Status.h"
#import <objc/runtime.h>

static CGFloat const originTopButtom = 60.0;
static CGFloat const originItem = 5.0;
static CGFloat const heightItem = 25.0;
static CGFloat const widthItem = 60.0;
static CGFloat const sizeItem = 70.0;

@interface UIView ()

@property (nonatomic, strong, readonly) UIView *backView;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *messageLabel;
@property (nonatomic, strong, readonly) UIButton *clickButton;

@property (nonatomic, assign) BOOL isActivity;
@property (nonatomic, strong) NSArray <UIImage *> *images;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, assign) BOOL statusScrollEnable;
@property (nonatomic, copy) void (^statusReload)(void);
@property (nonatomic, assign) BOOL isInitlized; // 是否已经初始化信息，是的话就不再处理

@end

@implementation UIView (Status)

#pragma mark - getter/setter

#pragma mark 私有

- (UIView *)backView
{
    return objc_getAssociatedObject(self, @selector(backView));
}

- (void)setBackView:(UIView *)backView
{
    objc_setAssociatedObject(self, @selector(backView), backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)activityView
{
    return objc_getAssociatedObject(self, @selector(activityView));
}

- (void)setActivityView:(UIActivityIndicatorView *)activityView
{
    objc_setAssociatedObject(self, @selector(activityView), activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)imageView
{
    return objc_getAssociatedObject(self, @selector(imageView));
}

- (void)setImageView:(UIImageView *)imageView
{
    objc_setAssociatedObject(self, @selector(imageView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)messageLabel
{
    return objc_getAssociatedObject(self, @selector(messageLabel));
}

- (void)setMessageLabel:(UILabel *)messageLabel
{
    objc_setAssociatedObject(self, @selector(messageLabel), messageLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)clickButton
{
    return objc_getAssociatedObject(self, @selector(clickButton));
}

- (void)setClickButton:(UIButton *)clickButton
{
    objc_setAssociatedObject(self, @selector(clickButton), clickButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isActivity
{
    NSNumber *status = objc_getAssociatedObject(self, @selector(isActivity));
    return status.boolValue;
}

- (void)setIsActivity:(BOOL)isActivity
{
    NSNumber *status = @(isActivity);
    objc_setAssociatedObject(self, @selector(isActivity), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<UIImage *> *)images
{
    return objc_getAssociatedObject(self, @selector(images));
}

- (void)setImages:(NSArray<UIImage *> *)images
{
    objc_setAssociatedObject(self, @selector(images), images, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)message
{
    return objc_getAssociatedObject(self, @selector(message));
}

- (void)setMessage:(NSString *)message
{
    objc_setAssociatedObject(self, @selector(message), message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)statusScrollEnable
{
    NSNumber *status = objc_getAssociatedObject(self, @selector(statusScrollEnable));
    return status.boolValue;
}

- (void)setStatusScrollEnable:(BOOL)statusScrollEnable
{
    NSNumber *status = @(statusScrollEnable);
    objc_setAssociatedObject(self, @selector(statusScrollEnable), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))statusReload
{
    return objc_getAssociatedObject(self, @selector(statusReload));
}

- (void)setStatusReload:(void (^)(void))statusReload
{
    objc_setAssociatedObject(self, @selector(statusReload), statusReload, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isInitlized
{
    NSNumber *status = objc_getAssociatedObject(self, @selector(isInitlized));
    return status.boolValue;
}

- (void)setIsInitlized:(BOOL)isInitlized
{
    NSNumber *status = @(isInitlized);
    objc_setAssociatedObject(self, @selector(isInitlized), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark 公有

- (StatusViewAlignment)statusViewAlignment
{
    NSNumber *status = objc_getAssociatedObject(self, @selector(statusViewAlignment));
    return status.integerValue;
}

- (void)setStatusViewAlignment:(StatusViewAlignment)statusViewAlignment
{
    NSNumber *status = @(statusViewAlignment);
    objc_setAssociatedObject(self, @selector(statusViewAlignment), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)statusButtonFullScreen
{
    NSNumber *status = objc_getAssociatedObject(self, @selector(statusButtonFullScreen));
    return status.boolValue;
}

- (void)setStatusButtonFullScreen:(BOOL)statusButtonFullScreen
{
    NSNumber *status = @(statusButtonFullScreen);
    objc_setAssociatedObject(self, @selector(statusButtonFullScreen), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)statusAnimationTime
{
    NSNumber *status = objc_getAssociatedObject(self, @selector(statusAnimationTime));
    return status.doubleValue;
}

- (void)setStatusAnimationTime:(NSTimeInterval)statusAnimationTime
{
    NSNumber *status = @(statusAnimationTime);
    objc_setAssociatedObject(self, @selector(statusAnimationTime), status, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark getter

- (UIView *)statusView
{
    [self setUIStatusView];
    return self.backView;
}

- (UIActivityIndicatorView *)statusActivityView
{
    [self setUIActiveView];
    return self.activityView;
}

- (UIImageView *)statusImageView
{
    [self setUIImageView];
    return self.imageView;
}

- (UILabel *)statusMessageLabel
{
    [self setUIMessageLabel];
    return self.messageLabel;
}

- (UIButton *)statusButton
{
    [self setUIButton];
    return self.clickButton;
}

#pragma mark - 视图处理

- (void)setUI
{
    if (self.isInitlized)
    {
        // 已经初始化，则不再进行初始化
        return;
    }
    
    self.isInitlized = YES;
    
    // 实始化
    [self setUIStatusView];
    [self setUIActiveView];
    [self setUIImageView];
    [self setUIMessageLabel];
    [self setUIButton];
    
    [self addSubview:self.backView];
    [self bringSubviewToFront:self.backView];
    [self.backView addSubview:self.activityView];
    [self.backView addSubview:self.imageView];
    [self.backView addSubview:self.messageLabel];
    [self.backView addSubview:self.clickButton];
    
    if (0.0 >= self.statusAnimationTime)
    {
        self.statusAnimationTime = 0.6;
    }
}

- (void)setUIStatusView
{
    if (self.backView == nil)
    {
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = self.backgroundColor;
        
        self.backView.frame = self.bounds;
    }
}

- (void)setUIActiveView
{
    if (self.activityView == nil)
    {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.backgroundColor = [UIColor clearColor];
        self.activityView.color = [UIColor redColor];
    }
}

- (void)setUIImageView
{
    if (self.imageView == nil)
    {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.imageView.frame = CGRectMake(0.0, 0.0, sizeItem, sizeItem);
    }
}

- (void)setUIMessageLabel
{
    if (self.messageLabel == nil)
    {
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        
        self.messageLabel.frame = CGRectMake(originItem, 0.0, (self.frame.size.width - originItem * 2), heightItem);
    }
}

- (void)setUIButton
{
    if (self.clickButton == nil)
    {
        self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.clickButton.backgroundColor = [UIColor clearColor];
        self.clickButton.layer.cornerRadius = 5.0;
        self.clickButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
        self.clickButton.layer.borderWidth = 0.5;
        self.clickButton.layer.masksToBounds = YES;
        self.clickButton.clipsToBounds = YES;
        
        [self.clickButton setTitle:@"重新加载" forState:UIControlStateNormal];
        self.clickButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.clickButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.5] forState:UIControlStateNormal];
        [self.clickButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.2] forState:UIControlStateHighlighted];
        
        [self.clickButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.clickButton.frame = CGRectMake(0.0, 0.0, widthItem, heightItem);
    }
}

- (void)resetUI
{
    [self setUI];
    
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.statusScrollEnable;
    }
    
    self.activityView.hidden = YES;
    self.imageView.hidden = YES;
    self.messageLabel.hidden = YES;
    self.clickButton.hidden = YES;
}

- (void)resetUI:(NSString *)message image:(NSArray <UIImage *> *)images
{
    [self resetUI];
    
    // 图标
    if (images && 0 < images.count)
    {
        self.imageView.hidden = NO;
        
        if (1 == images.count)
        {
            self.imageView.image = images.firstObject;
            
            if ([self.imageView isAnimating])
            {
                [self.imageView stopAnimating];
                self.imageView.animationImages = nil;
            }
        }
        else if (1 < images.count)
        {
            self.imageView.animationDuration = self.statusAnimationTime;
            self.imageView.animationImages = images;
            [self.imageView startAnimating];
            
            self.imageView.image = nil;
        }
    }
    
    // 提示语
    if (message && 0 < message.length)
    {
        self.messageLabel.hidden = NO;
        
        self.messageLabel.text = message;
    }
}

- (void)reloadUIFrame
{
    // 如果是UIScrollView及其子类，占位图展示期间禁止scroll
    if ([self isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView *)self;
        // 先记录原本的scrollEnabled
        self.statusScrollEnable = scrollView.scrollEnabled;
        // 再将scrollEnabled设为NO
        scrollView.scrollEnabled = NO;
    }
    
    if (self.activityView.hidden)
    {
        CGFloat heightTotal = 0.0;
        if (!self.imageView.hidden)
        {
            CGRect rectImage = self.imageView.frame;
            rectImage.origin.x = (self.backView.frame.size.width - self.imageView.frame.size.width) / 2;
            self.imageView.frame = rectImage;
            
            heightTotal += self.imageView.frame.size.height;
        }
        if (!self.messageLabel.hidden)
        {
            heightTotal += (self.messageLabel.frame.size.height + originItem);
        }
        if (!self.clickButton.hidden && !self.statusButtonFullScreen)
        {
            heightTotal += (self.clickButton.frame.size.height + originItem);
        }
        
        CGFloat originYTotal = (self.backView.frame.size.height - heightTotal) / 2;
        if (self.statusViewAlignment == StatusViewAlignmentTop)
        {
            originYTotal = originTopButtom;
        }
        else if (self.statusViewAlignment == StatusViewAlignmentBottom)
        {
             originYTotal = (self.backView.frame.size.height - heightTotal - originTopButtom);
        }
        
        UIView *currentView = nil;
        if (!self.imageView.hidden)
        {
            CGRect rectImage = self.imageView.frame;
            rectImage.origin.x = (self.backView.frame.size.width - self.imageView.frame.size.width) / 2;
            rectImage.origin.y = originYTotal;
            self.imageView.frame = rectImage;
            
            currentView = self.imageView;
        }
        if (!self.messageLabel.hidden)
        {
            CGRect rectLabel = self.messageLabel.frame;
            rectLabel.origin.x = (self.backView.frame.size.width - self.messageLabel.frame.size.width) / 2;
            if (self.messageLabel.frame.size.width > (self.backView.frame.size.width - originItem * 2))
            {
                rectLabel.origin.x = originItem;
                rectLabel.size.width = (self.backView.frame.size.width - originItem * 2);
            }
            rectLabel.origin.y = originYTotal;
            if (!self.imageView.hidden)
            {
                rectLabel.origin.y = (currentView.frame.origin.y + currentView.frame.size.height + originItem);
            }
            self.messageLabel.frame = rectLabel;
            
            currentView = self.messageLabel;
        }
        if (!self.clickButton.hidden)
        {
            CGRect rectButton = self.clickButton.frame;
            if (self.statusButtonFullScreen)
            {
                rectButton = self.bounds;
                
                self.clickButton.layer.cornerRadius = 0.0;
                self.clickButton.layer.borderColor = [UIColor clearColor].CGColor;
                self.clickButton.layer.borderWidth = 0.0;
                [self.clickButton setTitle:@"" forState:UIControlStateNormal];
            }
            else
            {
                rectButton.origin.y = originYTotal;
                if (!self.imageView.hidden || !self.messageLabel.hidden)
                {
                    rectButton.origin.x = (self.backView.frame.size.width - self.clickButton.frame.size.width) / 2;
                    if (self.clickButton.frame.size.width > (self.backView.frame.size.width - originItem * 2))
                    {
                        rectButton.origin.x = originItem;
                        rectButton.size.width = (self.backView.frame.size.width - originItem * 2);
                    }
                    rectButton.origin.y = (currentView.frame.origin.y + currentView.frame.size.height + originItem);
                }
            }
            self.clickButton.frame = rectButton;
        }
    }
    else
    {
        CGPoint center = CGPointMake(self.backView.frame.size.width / 2, self.backView.frame.size.height / 2);
        if (self.statusViewAlignment == StatusViewAlignmentTop)
        {
            center = CGPointMake(self.backView.frame.size.width / 2, self.backView.frame.size.height / 4);
        }
        else if (self.statusViewAlignment == StatusViewAlignmentBottom)
        {
            center = CGPointMake(self.backView.frame.size.width / 2, self.backView.frame.size.height / 4 * 3);
        }
        
        self.activityView.center = center;
    }
}

/// 移除视图
- (void)removeStatusView
{
    self.isInitlized = NO;
    
    // 移除视图
    if (self.activityView)
    {
        [self.activityView removeFromSuperview];
        self.activityView = nil;
    }
    
    if (self.imageView)
    {
        [self.imageView removeFromSuperview];
        self.imageView = nil;
    }
    
    if (self.messageLabel)
    {
        [self.messageLabel removeFromSuperview];
        self.messageLabel = nil;
    }
    
    if (self.clickButton)
    {
        [self.clickButton removeFromSuperview];
        self.clickButton = nil;
    }
    
    if (self.backView)
    {
        [self.backView removeFromSuperview];
        self.backView = nil;
    }
    
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.statusScrollEnable;
    }
}

#pragma mark - 状态视图方法

#pragma mark 开始

// 开始（菊花转）
- (void)statusViewLoadStart
{
    [self resetUI];
    
    self.isActivity = YES;
    
    [self.activityView startAnimating];
    self.activityView.hidden = NO;
    
    [self reloadUIFrame];
}

// 开始（自定义）
- (void)statusViewLoadStart:(NSString *)message image:(NSArray <UIImage *> *)images
{
    self.message = message;
    self.images = images;
    
    [self resetUI:message image:images];
    
    [self reloadUIFrame];
}

#pragma mark 成功

// 结束，加载成功
- (void)statusViewLoadSuccess
{
    if (self.isActivity)
    {
        if ([self.activityView isAnimating])
        {
            [self.activityView stopAnimating];
        }
    }
    else
    {
        if ([self.imageView isAnimating])
        {
            [self.imageView stopAnimating];
        }
    }
    
    [self removeStatusView];
}

// 结束，加载成功，无数据
- (void)statusViewLoadSuccessWithoutData:(NSString *)message image:(NSArray<UIImage *> *)images
{
    [self resetUI:message image:images];
    
    [self reloadUIFrame];
}

// 结束，加载成功，无数据，重新加载
- (void)statusViewLoadSuccessWithoutData:(NSString *)message image:(NSArray<UIImage *> *)images click:(void (^)(void))click
{
    [self resetUI:message image:images];
    
    self.clickButton.hidden = NO;
    self.statusReload = [click copy];
    
    [self reloadUIFrame];
}

#pragma mark 失败

// 结束，加载失败
- (void)statusViewLoadFailue:(NSString *)message image:(NSArray<UIImage *> *)images
{
    [self resetUI:message image:images];
    
    [self reloadUIFrame];
}

- (void)statusViewLoadFailue:(NSString *)message image:(NSArray<UIImage *> *)images click:(void (^)(void))click
{
    [self resetUI:message image:images];
    
    self.clickButton.hidden = NO;
    self.statusReload = [click copy];
    
    [self reloadUIFrame];
}

#pragma mark - 响应

- (void)buttonClick:(UIButton *)button
{
    if (self.isActivity)
    {
        [self statusViewLoadStart];
    }
    else
    {
        [self statusViewLoadStart:self.message image:self.images];
    }
    
    if (self.statusReload)
    {
        self.statusReload();
    }
}

@end
