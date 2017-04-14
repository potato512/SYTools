//
//  SYCollectionView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/9.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYCollectionView : UICollectionView

/// 水平滚动
UICollectionViewFlowLayout *flowLayoutScrollDirectionHorizontal(void);

/// 垂直滚动
UICollectionViewFlowLayout *flowLayoutScrollDirectionVertical(void);

/// 状态视图显示位置（前，或后。默认前置显示）
@property (nonatomic, assign) BOOL showBack;

/// 重置状态视图frame
- (void)resetStatusViewFrame:(CGRect)rect;

/// 开始（菊花转）
- (void)loadingStart;

/// 结束，加载成功
- (void)loadedSueccess;

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutData;

/// 结束，加载成功，无数据（自定义标题与图标）
- (void)loadedSuccessWithoutData:(NSString *)title image:(UIImage *)image;

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutDataAndRestart:(NSString *)message image:(UIImage *)image click:(void (^)(void))restartClick;

/// 结束，加载成功，无数据（自定义标题与图标，响应事件）
- (void)loadedSuccessWithoutData:(NSString *)message image:(UIImage *)image title:(NSString *)titleButton click:(void (^)(void))restartClick;

/// 结束，加载失败
- (void)loadedFailue:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败（重新加载）
- (void)loadedFailueAndRestart:(void (^)(void))restartClick;

/// 结束，加载失败（自定义标题、图标。重新加载）
- (void)loadedFailueAndRestart:(NSString *)message image:(UIImage *)image click:(void (^)(void))restartClick;

@end
