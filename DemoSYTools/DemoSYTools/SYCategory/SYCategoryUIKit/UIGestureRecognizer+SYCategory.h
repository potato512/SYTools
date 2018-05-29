//
//  UIGestureRecognizer+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (SYCategory)

/// 点击手势（点击次数默认1）
- (instancetype)initTapGestureRecognizerWithView:(UIView *)view action:(void (^)(UITapGestureRecognizer *recognizer))callback;
/// 点击手势
- (instancetype)initTapGestureRecognizerWithView:(UIView *)view tapNumber:(NSInteger)number action:(void (^)(UITapGestureRecognizer *recognizer))callback;

/// 长按手势（默认0.5秒）
- (instancetype)initLongPressGestureRecognizerWithView:(UIView *)view action:(void (^)(UILongPressGestureRecognizer *recognizer))callback;
/// 长按手势
- (instancetype)initLongPressGestureRecognizerWithView:(UIView *)view pressDuration:(CFTimeInterval)time action:(void (^)(UILongPressGestureRecognizer *recognizer))callback;

/// 拖拽手势
- (instancetype)initPanGestureRecognizerWithView:(UIView *)view action:(void (^)(UIPanGestureRecognizer *recognizer))callback;

/// 拿捏缩放手势
- (instancetype)initPinchGestureRecognizerWithView:(UIView *)view action:(void (^)(UIPinchGestureRecognizer *recognizer))callback;

/// 滑动手势（未指定方向）
- (instancetype)initSwipeGestureRecognizerWithView:(UIView *)view action:(void (^)(UISwipeGestureRecognizer *recognizer))callback;
/// 滑动手势（指定方向）
- (instancetype)initSwipeGestureRecognizerWithView:(UIView *)view direction:(UISwipeGestureRecognizerDirection)direction action:(void (^)(UISwipeGestureRecognizer *recognizer))callback;

/// 旋转手势
- (instancetype)initRotationGestureRecognizerWithView:(UIView *)view action:(void (^)(UIRotationGestureRecognizer *recognizer))callback;

@end
