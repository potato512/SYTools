//
//  SYCollectionView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/9.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYCollectionView.h"

@interface SYCollectionView ()

@property (nonatomic, strong) SYNetworkStatusView *statusView;

@end

@implementation SYCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    return self;
}

#pragma mark -

/// 水平滚动
UICollectionViewFlowLayout *flowLayoutScrollDirectionHorizontal(void)
{
    UICollectionViewFlowLayout *scrollDirectionHorizontal = [[UICollectionViewFlowLayout alloc] init];
    [scrollDirectionHorizontal setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    return scrollDirectionHorizontal;
}

/// 垂直滚动
UICollectionViewFlowLayout *flowLayoutScrollDirectionVertical(void)
{
    UICollectionViewFlowLayout *scrollDirectionVertical = [[UICollectionViewFlowLayout alloc] init];
    [scrollDirectionVertical setScrollDirection:UICollectionViewScrollDirectionVertical];
    return scrollDirectionVertical;
}

#pragma mark -

/// 开始（菊花转）
- (void)loadingStart
{
    [self.statusView statusloadStart];
}

/// 结束，加载成功
- (void)loadedSueccess
{
    [self.statusView statusloadSueccess];
}

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutData
{
    [self.statusView statusloadSuccessWithoutData:nil image:nil];
}

/// 结束，加载成功，无数据（自定义标题与图标）
- (void)loadedSuccessWithoutData:(NSString *)title image:(UIImage *)image
{
    self.scrollEnabled = NO;
    [self.statusView statusloadSuccessWithoutData:title image:image];
}

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutDataAndRestart:(NSString *)message image:(UIImage *)image click:(void (^)(void))restartClick
{
    [self.statusView statusloadSuccessAndRestart:message image:image title:nil reStart:YES];
    
    self.statusView.buttonClick = ^(){
        if (restartClick)
        {
            restartClick();
        }
    };
}

/// 结束，加载成功，无数据（自定义标题与图标，响应事件）
- (void)loadedSuccessWithoutData:(NSString *)message image:(UIImage *)image title:(NSString *)titleButton click:(void (^)(void))restartClick
{
    self.scrollEnabled = NO;
    [self.statusView statusloadSuccessAndRestart:message image:image title:titleButton];
    
    self.statusView.buttonClick = ^(){
        if (restartClick)
        {
            restartClick();
        }
    };
}

/// 结束，加载失败
- (void)loadedFailue:(NSString *)message image:(UIImage *)image
{
    self.scrollEnabled = NO;
    [self.statusView statusloadFailue:message image:image];
}

/// 结束，加载失败（重新加载）
- (void)loadedFailueAndRestart:(void (^)(void))restartClick
{
    [self loadedFailueAndRestart:nil image:nil click:restartClick];
}

/// 结束，加载失败（自定义标题、图标。重新加载）
- (void)loadedFailueAndRestart:(NSString *)message image:(UIImage *)image click:(void (^)(void))restartClick
{
    [self.statusView statusloadFailueAndRestart:message image:image];
    
    self.statusView.buttonClick = ^(){
        if (restartClick)
        {
            restartClick();
        }
    };
}

- (SYNetworkStatusView *)statusView
{
    if (!_statusView)
    {
        _statusView = [[SYNetworkStatusView alloc] initWithView:self];
    }
    
    return _statusView;
}

/// 重置状态视图frame
- (void)resetStatusViewFrame:(CGRect)rect
{
    [self.statusView setViewFrame:rect];
}

/// 状态视图显示位置（前，或后）
- (void)setShowBack:(BOOL)showBack
{
    _showBack = showBack;
    if (_showBack)
    {
        [self sendSubviewToBack:self.statusView];
    }
    else
    {
        [self bringSubviewToFront:self.statusView];
    }
}

@end
