//
//  UIImageView+SYWebImageView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/5.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "UIImageView+SYWebImageView.h"
#import <objc/runtime.h>
#import "YYKit.h"

@interface UIImageView ()

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIImage *imageHolder;
@property (nonatomic, strong) UIImage *imageFailure;
@property (nonatomic, strong) NSString *textLoading;
@property (nonatomic, strong) NSString *textFailure;
@property (nonatomic, assign) BOOL showProgress;
@property (nonatomic, assign) BOOL showActivity;
@property (nonatomic, assign) BOOL shouldReload;

@property (nonatomic, strong) CAShapeLayer *progressView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation UIImageView (SYWebImageView)

- (void)setImageWithUrl:(NSString *)url imagePlaceholder:(UIImage *)imagePlaceholder imageFailure:(UIImage *)imageFailure textLoading:(NSString *)textLoading textFailure:(NSString *)textFailure showProgress:(BOOL)showProgress showActivity:(BOOL)showActivity reloadWhileFailure:(BOOL)reload
{
    self.url = url;
    self.imageHolder = imagePlaceholder;
    self.imageFailure = imageFailure;
    self.textLoading = textLoading;
    self.textFailure = textFailure;
    self.showProgress = showProgress;
    self.showActivity = showActivity;
    self.shouldReload = reload;
    
    //
    typeof(self) __weak weakSelf = self;
    NSURL *imageURL = [NSURL URLWithString:url];
    [self setImageWithURL:imageURL placeholder:self.imageHolder options:(YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionUseNSURLCache) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (expectedSize > 0 && receivedSize > 0)
        {
            // 进度条
            if (weakSelf.progressView == nil)
            {
                weakSelf.progressView = [CAShapeLayer layer];
                [weakSelf.layer addSublayer:weakSelf.progressView];
                weakSelf.progressView.frame = CGRectMake(0.0, 0.0, weakSelf.frame.size.width, 3.0);
                //
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, weakSelf.progressView.frame.size.height / 2)];
                [path addLineToPoint:CGPointMake(weakSelf.frame.size.width, weakSelf.progressView.frame.size.height / 2)];
                weakSelf.progressView.lineWidth = 3.0;
                weakSelf.progressView.path = path.CGPath;
                weakSelf.progressView.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
                weakSelf.progressView.lineCap = kCALineCapButt;
                weakSelf.progressView.strokeStart = 0;
                weakSelf.progressView.strokeEnd = 0;
            }
            if (weakSelf.progressView.hidden && showProgress)
            {
                weakSelf.progressView.hidden = NO;
            }
            CGFloat progress = (CGFloat)receivedSize / expectedSize;
            progress = ((progress < 0) ? 0 : ((progress > 1) ? 1 : progress));
            weakSelf.progressView.strokeEnd = progress;
            
            // 菊花转
            if (weakSelf.activityView == nil)
            {
                weakSelf.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                [weakSelf addSubview:weakSelf.activityView];
                weakSelf.activityView.center = CGPointMake(weakSelf.frame.size.width / 2, weakSelf.frame.size.height / 2);
            }
            
            if (weakSelf.activityView.hidden && showActivity)
            {
                weakSelf.activityView.hidden = NO;
                [weakSelf.activityView startAnimating];
            }
            
            // 显示标签
            if (weakSelf.messageLabel == nil)
            {
                weakSelf.messageLabel = [[UILabel alloc] initWithFrame:weakSelf.bounds];
                [weakSelf addSubview:weakSelf.messageLabel];
                weakSelf.messageLabel.textAlignment = NSTextAlignmentCenter;
                weakSelf.messageLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.5];
                weakSelf.messageLabel.numberOfLines = 0;
                weakSelf.messageLabel.font = [UIFont systemFontOfSize:12.0];
            }
            if (weakSelf.messageLabel.hidden && textLoading)
            {
                weakSelf.messageLabel.hidden = NO;
            }
            weakSelf.messageLabel.text = textLoading;
        }
    } transform:nil completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        if (stage == YYWebImageStageFinished)
        {
            // 进度条
            if (!weakSelf.progressView.hidden)
            {
                weakSelf.progressView.hidden = YES;
                weakSelf.progressView.strokeEnd = 0;
            }
            
            // 菊花转
            if (!weakSelf.activityView.hidden)
            {
                if (weakSelf.activityView.isAnimating)
                {
                    [weakSelf.activityView stopAnimating];
                }
                weakSelf.activityView.hidden = YES;
            }
            
            // 显示标签
            if (!weakSelf.messageLabel.hidden && !textFailure)
            {
                weakSelf.messageLabel.hidden = YES;
            }
            
            // 显示异常
            if (image == nil)
            {
                // 失败图标
                if (imageFailure)
                {
                    weakSelf.image = imageFailure;
                }
                
                // 失败标签
                if (weakSelf.messageLabel.hidden && textFailure)
                {
                    weakSelf.messageLabel.hidden = NO;
                    weakSelf.messageLabel.text = textFailure;
                }
                
                // 重新加载
                if (reload)
                {
                    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(tapClick:)];
                    weakSelf.userInteractionEnabled = YES;
                    [weakSelf addGestureRecognizer:tapRecognizer];
                }
            }
        }
    }];
}

#pragma mark - 响应

- (void)tapClick:(UITapGestureRecognizer *)recognizer
{
    [self setImageWithUrl:self.url imagePlaceholder:self.imageHolder imageFailure:self.imageFailure textLoading:self.textLoading textFailure:self.textFailure showProgress:self.showProgress showActivity:self.showActivity reloadWhileFailure:self.shouldReload];
}

#pragma mark - getter/setter

- (void)setUrl:(NSString *)url
{
    objc_setAssociatedObject(self, @selector(url), url, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)url
{
    return objc_getAssociatedObject(self, @selector(url));
}

- (void)setImageHolder:(UIImage *)imageHolder
{
    objc_setAssociatedObject(self, @selector(imageHolder), imageHolder, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage *)imageHolder
{
    return objc_getAssociatedObject(self, @selector(imageHolder));
}

- (void)setImageFailure:(UIImage *)imageFailure
{
    objc_setAssociatedObject(self, @selector(imageFailure), imageFailure, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage *)imageFailure
{
    return objc_getAssociatedObject(self, @selector(imageFailure));
}

- (void)setTextLoading:(NSString *)textLoading
{
    objc_setAssociatedObject(self, @selector(textLoading), textLoading, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)textLoading
{
    return objc_getAssociatedObject(self, @selector(textLoading));
}

- (void)setTextFailure:(NSString *)textFailure
{
    objc_setAssociatedObject(self, @selector(textFailure), textFailure, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)textFailure
{
    return objc_getAssociatedObject(self, @selector(textFailure));
}

- (void)setShowProgress:(BOOL)showProgress
{
    objc_setAssociatedObject(self, @selector(showProgress), @(showProgress), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showProgress
{
    return [objc_getAssociatedObject(self, @selector(showProgress)) boolValue];
}

- (void)setShowActivity:(BOOL)showActivity
{
    objc_setAssociatedObject(self, @selector(showActivity), @(showActivity), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showActivity
{
    return [objc_getAssociatedObject(self, @selector(showActivity)) boolValue];
}

- (void)setShouldReload:(BOOL)shouldReload
{
    objc_setAssociatedObject(self, @selector(shouldReload), @(shouldReload), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)shouldReload
{
    return [objc_getAssociatedObject(self, @selector(shouldReload)) boolValue];
}


- (void)setProgressView:(CAShapeLayer *)progressView
{
    objc_setAssociatedObject(self, @selector(progressView), progressView, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)progressView
{
    return objc_getAssociatedObject(self, @selector(progressView));
}

- (void)setActivityView:(UIActivityIndicatorView *)activityView
{
    objc_setAssociatedObject(self, @selector(activityView), activityView, OBJC_ASSOCIATION_RETAIN);
}

- (UIActivityIndicatorView *)activityView
{
    return objc_getAssociatedObject(self, @selector(activityView));
}

- (void)setMessageLabel:(UILabel *)messageLabel
{
    objc_setAssociatedObject(self, @selector(messageLabel), messageLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *)messageLabel
{
    return objc_getAssociatedObject(self, @selector(messageLabel));
}

@end
