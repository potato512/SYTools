//
//  SYWithoutNetworkView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  没有网络时的提示

#import <UIKit/UIKit.h>

/// 显示位置模式（偏上，居中，偏下）
typedef NS_ENUM(NSInteger, PositionMode)
{
    /// 居上（无圆角）
    PositionTop = 0,
    
    /// 居上（圆角，自适应）
    PositionTopRountAdjust = 1,
    
    /// 居中（圆角，自适应）
    PositionCenterRountAdjust = 2,
    
    /// 居下（圆角，自适应）
    PositionBottomRountAdjust = 3,
};

@interface SYWithoutNetworkView : UIView

/// 单例
+ (instancetype)shareManager;

/// 显示无网络状态提示
- (void)showWithView:(UIView *)view position:(PositionMode)posttion message:(NSString *)message image:(UIImage *)image animation:(BOOL)animation;

/// 隐藏
- (void)hidden;

@end
