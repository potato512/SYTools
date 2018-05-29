//
//  UISlider+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/2.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UISlider+SYCategory.h"
#import <objc/runtime.h>

@implementation UISlider (SYCategory)

#pragma mark - 回调方法

- (void)setSliderClick:(SliderClick)sliderClick
{
    if (sliderClick)
    {
        [self addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventValueChanged];
        objc_setAssociatedObject(self, @selector(sliderClick), sliderClick, OBJC_ASSOCIATION_COPY);
    }
}

- (SliderClick)sliderClick
{
    SliderClick sliderClick = objc_getAssociatedObject(self, @selector(sliderClick));
    return sliderClick;
}

- (void)actionClick:(UISlider *)slider
{
    if (self.sliderClick)
    {
        self.sliderClick(slider);
    }
}

+ (instancetype)sliderWithFrame:(CGRect)frame view:(UIView *)superview value:(float)value action:(SliderClick)sliderClick
{
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    if (superview && [superview isKindOfClass:[UIView class]])
    {
        [superview addSubview:slider];
    }
    slider.value = value;
    if (sliderClick)
    {
        slider.sliderClick = [sliderClick copy];
    }
    
    return slider;
}


#pragma mark - 链式属性

/// 链式编程 进度
- (UISlider *(^)(float value))sliderValue
{
    return ^(float value) {
        self.value = value;
        return self;
    };
}

/// 链式编程 最小值
- (UISlider *(^)(float value))sliderMiniValue
{
    return ^(float value) {
        self.minimumValue = value;
        return self;
    };
}

/// 链式编程 最大值
- (UISlider *(^)(float value))sliderMaxiValue
{
    return ^(float value) {
        self.maximumValue = value;
        return self;
    };
}

/// 链式编程 拖动块图标
- (UISlider *(^)(UIImage *image))sliderThumbImage
{
    return ^(UIImage *image) {
        [self setThumbImage:image forState:UIControlStateNormal];
        return self;
    };
}

/// 链式编程 最小值图标
- (UISlider *(^)(UIImage *image))sliderMiniValueImage
{
    return ^(UIImage *image) {
        self.minimumValueImage = image;
        return self;
    };
}

/// 链式编程 最大值图标
- (UISlider *(^)(UIImage *image))sliderMaxiValueImage
{
    return ^(UIImage *image) {
        self.maximumValueImage = image;
        return self;
    };
}

/// 链式编程 拖动块颜色
- (UISlider *(^)(UIColor *color))sliderThumbTintColor
{
    return ^(UIColor *color) {
        self.thumbTintColor = color;
        return self;
    };
}

/// 链式编程 最小值背景颜色
- (UISlider *(^)(UIColor *color))sliderMiniTrackTintColor
{
    return ^(UIColor *color) {
        self.minimumTrackTintColor = color;
        return self;
    };
}

/// 链式编程 最大值背景颜色
- (UISlider *(^)(UIColor *color))sliderMaxiTrackTintColor
{
    return ^(UIColor *color) {
        self.maximumTrackTintColor = color;
        return self;
    };
}

@end
