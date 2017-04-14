//
//  SYWebView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/11.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "SYWebView.h"

@interface SYWebView () <UIWebViewDelegate>

@property (nonatomic, copy) void (^blockStart)(void);
@property (nonatomic, copy) void (^blockFinish)(void);
@property (nonatomic, copy) void (^blockFailue)(void);

@end

@implementation SYWebView

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
    if ([self isLoading])
    {
        [self stopLoading];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.isLoaded = NO;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (self.blockStart)
    {
        self.blockStart();
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.isLoaded = YES;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.blockFinish)
    {
        self.blockFinish();
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.blockFailue)
    {
        self.blockFailue();
    }
}


/// 响应回调
- (void)webViewStart:(void (^)(void))startBlock finish:(void (^)(void))finishBlock failue:(void (^)(void))failueBlock
{
    self.blockStart = startBlock;
    self.blockFinish = finishBlock;
    self.blockFailue = failueBlock;
}

@end
