//
//  UIView+SYRecognizer.h
//  DemoCategory
//
//  Created by Herman on 2018/5/13.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SYRecognizer)

/// 单击，或双击响应
- (UITapGestureRecognizer *)tapRecognizer:(NSInteger)tapNumber action:(void (^)(UITapGestureRecognizer *recognizer))action;

/// 长按手势（长按时间默认0.5）
- (UILongPressGestureRecognizer *)longPressRecognizer:(CFTimeInterval)time action:(void (^)(UILongPressGestureRecognizer *recognizer))action;

/// 拖动手势
- (UIPanGestureRecognizer *)panRecognizer:(void (^)(UIPanGestureRecognizer *recognizer))action;

/// 拿捏手势
- (UIPinchGestureRecognizer *)pinchRecognizer:(void (^)(UIPinchGestureRecognizer *recognizer))action;

/// 滑动手势
- (UISwipeGestureRecognizer *)swipeRecognizer:(UISwipeGestureRecognizerDirection)direction action:(void (^)(UISwipeGestureRecognizer *recognizer))action;

/// 旋转手势
- (UIRotationGestureRecognizer *)rotationRecognizer:(void (^)(UIRotationGestureRecognizer *recognizer))action;

@end
