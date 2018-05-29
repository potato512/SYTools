//
//  UIView+Status.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/11/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 对齐方式（顶端对齐、居中对齐-默认、底端对齐）
typedef NS_ENUM(NSInteger, StatusViewAlignment)
{
    /// 对齐方式-居中对齐-默认
    StatusViewAlignmentDefault = 0,
    
    /// 对齐方式-顶端对齐
    StatusViewAlignmentTop = 1,
    
    /// 对齐方式-居中对齐-默认
    StatusViewAlignmentCenter = StatusViewAlignmentDefault,
    
    /// 对齐方式-底端对齐
    StatusViewAlignmentBottom = 2
};

@interface UIView (Status)

/// 对齐方式（顶端对齐、居中对齐-默认、底端对齐）
@property (nonatomic, assign) StatusViewAlignment statusViewAlignment;
/// 按钮全屏（默认：NO；全屏时，按钮不显示）
@property (nonatomic, assign) BOOL statusButtonFullScreen;
/// 多图时的动画时间（默认：0.6）
@property (nonatomic, assign) NSTimeInterval statusAnimationTime;

@property (nonatomic, strong, readonly) UIView *statusView;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *statusActivityView;
@property (nonatomic, strong, readonly) UIImageView *statusImageView;
@property (nonatomic, strong, readonly) UILabel *statusMessageLabel;
@property (nonatomic, strong, readonly) UIButton *statusButton;

/**
 *  开始（默认：菊花转）
 */
- (void)statusViewLoadStart;
/**
 *  开始（自定义：提示语、图标）
 *
 *  @param message 提示语
 *  @param images  图标数组
 */
- (void)statusViewLoadStart:(NSString *)message image:(NSArray <UIImage *> *)images;

/**
 *  结束，加载成功（默认：无提示语、无图标）
 */
- (void)statusViewLoadSuccess;
/**
 *  结束，加载成功，无数据（自定义：提示语、图标；无重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 */
- (void)statusViewLoadSuccessWithoutData:(NSString *)message image:(NSArray <UIImage *> *)images;
/**
 *  结束，加载成功，无数据（自定义：提示语、图标；重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 *  @param click   重新加载
 */
- (void)statusViewLoadSuccessWithoutData:(NSString *)message image:(NSArray <UIImage *> *)images click:(void (^)(void))click;

/**
 *  结束，加载失败（自定义：提示语、图标；无重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 */
- (void)statusViewLoadFailue:(NSString *)message image:(NSArray <UIImage *> *)images;
/**
 *  结束，加载失败（自定义：提示语、图标；重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 *  @param click   重新加载
 */
- (void)statusViewLoadFailue:(NSString *)message image:(NSArray <UIImage *> *)images click:(void (^)(void))click;

@end
