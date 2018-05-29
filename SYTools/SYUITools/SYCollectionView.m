//
//  SYCollectionView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/9.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYCollectionView.h"
#import "UIView+Status.h"

@interface SYCollectionView ()

@property (nonatomic, strong) UIView *statusView;

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
    [self.statusView statusViewLoadStart];
}

/// 结束，加载成功
- (void)loadedSueccess
{
    [self.statusView statusViewLoadSuccess];
}

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutData
{
    [self.statusView statusViewLoadSuccessWithoutData:@"还没有数据" image:nil];
}

/// 结束，加载成功，无数据（自定义标题与图标）
- (void)loadedSuccessWithoutData:(NSString *)title image:(UIImage *)image
{
    self.scrollEnabled = NO;
    
    NSArray *images = (image ? @[image] : nil);
    [self.statusView statusViewLoadSuccessWithoutData:title image:images];
}

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutDataAndRestart:(NSString *)message image:(UIImage *)image click:(void (^)(void))restartClick
{
    NSArray *images = (image ? @[image] : nil);
    [self.statusView statusViewLoadSuccessWithoutData:message image:images click:^{
        if (restartClick)
        {
            restartClick();
        }
    }];
}

/// 结束，加载成功，无数据（自定义标题与图标，响应事件）
- (void)loadedSuccessWithoutData:(NSString *)message image:(UIImage *)image title:(NSString *)titleButton click:(void (^)(void))restartClick
{
    self.scrollEnabled = NO;
    
    NSArray *images = (image ? @[image] : nil);
    [self.statusView.statusButton setTitle:titleButton forState:UIControlStateNormal];
    [self.statusView statusViewLoadSuccessWithoutData:message image:images click:^{
        if (restartClick)
        {
            restartClick();
        }
    }];
}

/// 结束，加载失败
- (void)loadedFailue:(NSString *)message image:(UIImage *)image
{
    self.scrollEnabled = NO;
    
    NSArray *images = (image ? @[image] : nil);
    [self.statusView statusViewLoadFailue:message image:images];
}

/// 结束，加载失败（重新加载）
- (void)loadedFailueAndRestart:(void (^)(void))restartClick
{
    [self.statusView statusViewLoadFailue:@"加载失败" image:nil click:^{
        if (restartClick)
        {
            restartClick();
        }
    }];
}

/// 结束，加载失败（自定义标题、图标。重新加载）
- (void)loadedFailueAndRestart:(NSString *)message image:(UIImage *)image click:(void (^)(void))restartClick
{
    NSArray *images = (image ? @[image] : nil);
    [self.statusView statusViewLoadFailue:message image:images click:^{
        if (restartClick)
        {
            restartClick();
        }
    }];
}

- (UIView *)statusView
{
    if (!_statusView)
    {
        _statusView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_statusView];
    }
    
    return _statusView;
}

/// 重置状态视图frame
- (void)resetStatusViewFrame:(CGRect)rect
{
    self.statusView.frame = rect;
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
