//
//  HUDManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-28.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "HUDManager.h"

// 定义变量
static MBProgressHUD *mbProgressHUD;
static UITapGestureRecognizer *tapRecognizer;

@implementation HUDManager

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnabled message:(NSString *)message view:(UIView *)view customView:(UIView *)customview
{
    // 如果已存在，则从父视图移除
    if (mbProgressHUD.superview) {
        if (tapRecognizer.view) {
            [mbProgressHUD removeGestureRecognizer:tapRecognizer];
            tapRecognizer = nil;
        }
        
        [mbProgressHUD removeFromSuperview];
        mbProgressHUD = nil;
    }
    
    // 方法1
    //mbProgressHUD = [[MBProgressHUD alloc] initWithWindow:delegate.window];
    //[delegate.window addSubview:mbProgressHUD];
    // 方法2
    if (view == nil) {
        view = [[UIApplication sharedApplication].delegate window];
    }
    mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];

    /*
     MBProgressHUDModeIndeterminate            // 显示风火轮滚动（默认方式）
     MBProgressHUDModeDeterminate              // 显示圆形填充
     MBProgressHUDModeAnnularDeterminate       // 显示环形填充
     MBProgressHUDModeDeterminateHorizontalBar // 显示进度条
     MBProgressHUDModeCustomView               // 自定义显示图标
     MBProgressHUDModeText                     // 只显示标签
     */
    // 设置显示模式
    [mbProgressHUD setMode:mode];
    
    // 如果是自定义图标模式，则显示
    if (mode == MBProgressHUDModeCustomView && customview && [customview isKindOfClass:[UIView class]]) {
        [mbProgressHUD setCustomView:customview];
    }
    
    // 设置标示标签
    mbProgressHUD.label.text = message;

    // 设置显示类型 出现或消失
    [mbProgressHUD setAnimationType:MBProgressHUDAnimationZoomOut];
    
    // 显示
    [mbProgressHUD showAnimated:YES];
    //
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideClick)];
    [mbProgressHUD addGestureRecognizer:tapRecognizer];
    
    // 加上这个属性才能在HUD还没隐藏的时候点击到别的view
    [mbProgressHUD setUserInteractionEnabled:isEnabled];
    
    // 隐藏后从父视图移除
    [mbProgressHUD setRemoveFromSuperViewOnHide:YES];
    
    // 设置自动隐藏
    if (autoHide) {
        [mbProgressHUD hideAnimated:autoHide afterDelay:timeDelay];
    }
}

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnabled message:(NSString *)message view:(UIView *)view
{
    [self showHUD:mode hide:autoHide afterDelay:timeDelay enabled:isEnabled message:message view:view customView:nil];
}

+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)isEnabled message:(NSString *)message
{
    [self showHUD:mode hide:autoHide afterDelay:timeDelay enabled:isEnabled message:message view:nil customView:nil];
}

/// 显示在指定视图并自动隐藏（菊花转）
+ (void)showHUDIndeterminateWithMessage:(NSString *)message view:(UIView *)view
{
    [self showHUD:MBProgressHUDModeIndeterminate hide:YES afterDelay:1.2 enabled:YES message:message view:view customView:nil];
}

/// 显示后自动隐藏（菊花转）
+ (void)showHUDIndeterminateWithMessage:(NSString *)message
{
    [self showHUDIndeterminateWithMessage:message view:nil];
}

/// 显示在指定视图并自动隐藏
+ (void)showHUDWithMessage:(NSString *)message view:(UIView *)view
{
    [self showHUD:MBProgressHUDModeText hide:YES afterDelay:1.2 enabled:YES message:message view:view customView:nil];
}

/// 显示后自动隐藏
+ (void)showHUDWithMessage:(NSString *)message
{
    [self showHUDWithMessage:message view:nil];
}

/// 隐藏
+ (void)hideHUD
{
    [mbProgressHUD hideAnimated:YES];
}

+ (void)hideClick
{
    [self hideHUD];
}

@end
