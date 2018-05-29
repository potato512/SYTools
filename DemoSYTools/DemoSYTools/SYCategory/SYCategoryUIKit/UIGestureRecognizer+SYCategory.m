//
//  UIGestureRecognizer+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIGestureRecognizer+SYCategory.h"
#import <objc/runtime.h>

@interface UIGestureRecognizer ()

@property (nonatomic, copy) void (^tapBlock)(UITapGestureRecognizer *recognizer);
@property (nonatomic, copy) void (^longPressBlock)(UILongPressGestureRecognizer *recognizer);
@property (nonatomic, copy) void (^panBlock)(UIPanGestureRecognizer *recognizer);
@property (nonatomic, copy) void (^pinchBlock)(UIPinchGestureRecognizer *recognizer);
@property (nonatomic, copy) void (^swipeBlock)(UISwipeGestureRecognizer *recognizer);
@property (nonatomic, copy) void (^rotationBlock)(UIRotationGestureRecognizer *recognizer);

@end

@implementation UIGestureRecognizer (SYCategory)

/// 点击手势（点击次数默认1）
- (instancetype)initTapGestureRecognizerWithView:(UIView *)view action:(void (^)(UITapGestureRecognizer *recognizer))callback;
{
    self = [self initWithTarget:self action:@selector(tapClick:)];
    if (self)
    {
        ((UITapGestureRecognizer *)self).numberOfTapsRequired = 1;
        
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.tapBlock = [callback copy];
    }
    return self;
}

- (instancetype)initTapGestureRecognizerWithView:(UIView *)view tapNumber:(NSInteger)number action:(void (^)(UITapGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(tapClick:)];
    if (self)
    {
        ((UITapGestureRecognizer *)self).numberOfTapsRequired = (0 >= number ? 1 : number);
        
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.tapBlock = [callback copy];
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)recognizer
{
    if (self.tapBlock)
    {
        self.tapBlock(recognizer);
    }
}

/// 长按手势（默认0.5秒）
- (instancetype)initLongPressGestureRecognizerWithView:(UIView *)view action:(void (^)(UILongPressGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(longPressClick:)];
    if (self)
    {
        ((UILongPressGestureRecognizer *)self).minimumPressDuration = 0.5;
        
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.longPressBlock = [callback copy];
    }
    return self;
}

- (instancetype)initLongPressGestureRecognizerWithView:(UIView *)view pressDuration:(CFTimeInterval)time action:(void (^)(UILongPressGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(longPressClick:)];
    if (self)
    {
        ((UILongPressGestureRecognizer *)self).minimumPressDuration = (0 >= time ? 0.5 : time);
        
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.longPressBlock = [callback copy];
    }
    return self;
}

- (void)longPressClick:(UILongPressGestureRecognizer *)recognizer
{
    if (self.longPressBlock)
    {
        self.longPressBlock(recognizer);
    }
}

/// 拖拽手势
- (instancetype)initPanGestureRecognizerWithView:(UIView *)view action:(void (^)(UIPanGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(panClick:)];
    if (self)
    {
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.panBlock = [callback copy];
    }
    return self;
}

- (void)panClick:(UIPanGestureRecognizer *)recognizer
{
    if (self.panBlock)
    {
        self.panBlock(recognizer);
    }
}

/// 拿捏缩放手势
- (instancetype)initPinchGestureRecognizerWithView:(UIView *)view action:(void (^)(UIPinchGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(pinchClick:)];
    if (self)
    {
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.pinchBlock = [callback copy];
    }
    return self;
}

- (void)pinchClick:(UIPinchGestureRecognizer *)recognizer
{
    if (self.pinchBlock)
    {
        self.pinchBlock(recognizer);
    }
}

/// 滑动手势
- (instancetype)initSwipeGestureRecognizerWithView:(UIView *)view action:(void (^)(UISwipeGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(swipeClick:)];
    if (self)
    {
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.swipeBlock = [callback copy];
    }
    return self;
}

- (instancetype)initSwipeGestureRecognizerWithView:(UIView *)view direction:(UISwipeGestureRecognizerDirection)direction action:(void (^)(UISwipeGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(swipeClick:)];
    if (self)
    {
        ((UISwipeGestureRecognizer *)self).direction = direction;
        
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.swipeBlock = [callback copy];
    }
    return self;
}

- (void)swipeClick:(UISwipeGestureRecognizer *)recognizer
{
    if (self.swipeBlock)
    {
        self.swipeBlock(recognizer);
    }
}

/// 旋转手势
- (instancetype)initRotationGestureRecognizerWithView:(UIView *)view action:(void (^)(UIRotationGestureRecognizer *recognizer))callback
{
    self = [self initWithTarget:self action:@selector(rotationClick:)];
    if (self)
    {
        if (view)
        {
            view.userInteractionEnabled = YES;
            [view addGestureRecognizer:self];
        }
        
        self.rotationBlock = [callback copy];
    }
    return self;
}

- (void)rotationClick:(UIRotationGestureRecognizer *)recognizer
{
    if (self.rotationBlock)
    {
        self.rotationBlock(recognizer);
    }
}

#pragma mark - setter/getter

- (void)setTapBlock:(void (^)(UITapGestureRecognizer *))tapBlock
{
    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITapGestureRecognizer *))tapBlock
{
    return objc_getAssociatedObject(self, @selector(tapBlock));
}

- (void)setLongPressBlock:(void (^)(UILongPressGestureRecognizer *))longPressBlock
{
    objc_setAssociatedObject(self, @selector(longPressBlock), longPressBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UILongPressGestureRecognizer *))longPressBlock
{
    return objc_getAssociatedObject(self, @selector(longPressBlock));
}

- (void)setPanBlock:(void (^)(UIPanGestureRecognizer *))panBlock
{
    objc_setAssociatedObject(self, @selector(panBlock), panBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIPanGestureRecognizer *))panBlock
{
    return objc_getAssociatedObject(self, @selector(panBlock));
}

- (void)setPinchBlock:(void (^)(UIPinchGestureRecognizer *))pinchBlock
{
    objc_setAssociatedObject(self, @selector(pinchBlock), pinchBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIPinchGestureRecognizer *))pinchBlock
{
    return objc_getAssociatedObject(self, @selector(pinchBlock));
}

- (void)setSwipeBlock:(void (^)(UISwipeGestureRecognizer *))swipeBlock
{
    objc_setAssociatedObject(self, @selector(swipeBlock), swipeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISwipeGestureRecognizer *))swipeBlock
{
    return objc_getAssociatedObject(self, @selector(swipeBlock));
}

- (void)setRotationBlock:(void (^)(UIRotationGestureRecognizer *))rotationBlock
{
    objc_setAssociatedObject(self, @selector(rotationBlock), rotationBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIRotationGestureRecognizer *))rotationBlock
{
    return objc_getAssociatedObject(self, @selector(rotationBlock));
}

@end
