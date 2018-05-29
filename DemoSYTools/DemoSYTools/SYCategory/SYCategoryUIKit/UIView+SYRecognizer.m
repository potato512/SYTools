//
//  UIView+SYRecognizer.m
//  DemoCategory
//
//  Created by Herman on 2018/5/13.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "UIView+SYRecognizer.h"
#import "UIGestureRecognizer+SYCategory.h"

@implementation UIView (SYRecognizer)

#pragma mark - 解摸手势

/// 单击，或双击响应
- (UITapGestureRecognizer *)tapRecognizer:(NSInteger)tapNumber action:(void (^)(UITapGestureRecognizer *recognizer))action
{
    return [[UITapGestureRecognizer alloc] initTapGestureRecognizerWithView:self tapNumber:tapNumber action:action];
}

/// 长按手势（长按时间默认0.5）
- (UILongPressGestureRecognizer *)longPressRecognizer:(CFTimeInterval)time action:(void (^)(UILongPressGestureRecognizer *recognizer))action
{
    return [[UILongPressGestureRecognizer alloc] initLongPressGestureRecognizerWithView:self pressDuration:time action:action];
}

/// 拖动手势
- (UIPanGestureRecognizer *)panRecognizer:(void (^)(UIPanGestureRecognizer *recognizer))action
{
    return [[UIPanGestureRecognizer alloc] initPanGestureRecognizerWithView:self action:action];
}

/// 拿捏手势
- (UIPinchGestureRecognizer *)pinchRecognizer:(void (^)(UIPinchGestureRecognizer *recognizer))action
{
    return [[UIPinchGestureRecognizer alloc] initPinchGestureRecognizerWithView:self action:action];
}

/// 滑动手势
- (UISwipeGestureRecognizer *)swipeRecognizer:(UISwipeGestureRecognizerDirection)direction action:(void (^)(UISwipeGestureRecognizer *recognizer))action
{
    return [[UISwipeGestureRecognizer alloc] initSwipeGestureRecognizerWithView:self direction:direction action:action];
}

/// 旋转手势
- (UIRotationGestureRecognizer *)rotationRecognizer:(void (^)(UIRotationGestureRecognizer *recognizer))action
{
    return [[UIRotationGestureRecognizer alloc] initRotationGestureRecognizerWithView:self action:action];
}

@end
