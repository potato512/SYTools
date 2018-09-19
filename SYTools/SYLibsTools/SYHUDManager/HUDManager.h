//
//  HUDManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-28.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

// 导入头文件
#import <MBProgressHUD/MBProgressHUD.h>

// 设置协议
@interface HUDManager : NSObject <MBProgressHUDDelegate>

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnabled message:(NSString *)message view:(UIView *)view customView:(UIView *)customview;

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnabled message:(NSString *)message view:(UIView *)view;

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnabled message:(NSString *)message;

/// 显示在指定视图并自动隐藏（菊花转）
+ (void)showHUDIndeterminateWithMessage:(NSString *)message view:(UIView *)view;

/// 显示后自动隐藏（菊花转）
+ (void)showHUDIndeterminateWithMessage:(NSString *)message;

/// 显示在指定视图并自动隐藏
+ (void)showHUDWithMessage:(NSString *)message view:(UIView *)view;

/// 显示后自动隐藏
+ (void)showHUDWithMessage:(NSString *)message;

/// 隐藏
+ (void)hideHUD;

@end
