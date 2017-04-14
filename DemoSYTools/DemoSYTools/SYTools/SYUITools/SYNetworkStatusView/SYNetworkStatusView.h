//
//  SYNetworkStatusView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  网络加载视图控件（开始加载时，加载结束（或功，或失败，或空数据）、加载异常重新加载、加载无网络）

#import <UIKit/UIKit.h>

/// 显示样式（偏上显示，或居中显示，默认居中显示）
typedef NS_ENUM(NSInteger, NetworkStatusShowType)
{
    /// 显示样式 居中显示-默认显示
    NetworkStatusShowTypeCenter = 0,
    
    /// 显示样式 偏上显示
    NetworkStatusShowTypeTop = 1,
};

@interface SYNetworkStatusView : UIView

/// 实例化
- (instancetype)initWithView:(UIView *)view;

/// 重置视图frame
- (void)setViewFrame:(CGRect)rect;

/// 开始（菊花转）
- (void)statusloadStart;

/// 开始（自定义）
- (void)statusloadStartCustom:(NSString *)message image:(UIImage *)image;

/// 结束，加载成功
- (void)statusloadSueccess;

/// 结束，加载成功，无数据
- (void)statusloadSuccessWithoutData:(NSString *)message image:(UIImage *)image;

/// 结束，加载成功无数据（重新加载）
- (void)statusloadSuccessAndRestart:(NSString *)message image:(UIImage *)image;

/// 结束，加载成功无数据（重新加载，自定义）
- (void)statusloadSuccessAndRestart:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle;

// 结束，加载成功无数据（是否重新加载，自定义）
- (void)statusloadSuccessAndRestart:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle reStart:(BOOL)isRestart;

/// 结束，加载失败
- (void)statusloadFailue:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败（重新加载）
- (void)statusloadFailueAndRestart:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败（重新加载，自定义）
- (void)statusloadFailueAndRestart:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle;

/// 结束，成功或失败（重新加载。自定义信息，图标，标题）
- (void)statusloadFinish:(NSString *)message image:(UIImage *)image title:(NSString *)buttonTitle restart:(BOOL)isRestart;

/// 重新加载时响应回调
@property (nonatomic, copy) void (^buttonClick)(void);

/// 显示样式（偏上显示，或居中显示，默认居中显示）
@property (nonatomic, assign) NetworkStatusShowType showType;

/// 开始加载动图（未设置时，默认activityView显示）
@property (nonatomic, strong) NSArray *animationImages;

@end

