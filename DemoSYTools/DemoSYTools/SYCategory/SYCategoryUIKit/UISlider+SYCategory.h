//
//  UISlider+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/2.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SliderClick)(UISlider *slider);

@interface UISlider (SYCategory)

/// 回调方法
@property (nonatomic, copy) SliderClick sliderClick;

/**
 *  实例化UISlider
 *
 *  @param frame       坐标大小
 *  @param superview   父视图
 *  @param value       当前进度值（默认最小值：0.0；默认最大值：1.0）
 *  @param sliderClick 响应事件
 *
 *  @return UISlider
 */
+ (instancetype)sliderWithFrame:(CGRect)frame view:(UIView *)superview value:(float)value action:(SliderClick)sliderClick;

#pragma mark - 链式属性

/// 链式编程 进度
- (UISlider *(^)(float value))sliderValue;

/// 链式编程 最小值
- (UISlider *(^)(float value))sliderMiniValue;

/// 链式编程 最大值
- (UISlider *(^)(float value))sliderMaxiValue;

/// 链式编程 拖动块图标
- (UISlider *(^)(UIImage *image))sliderThumbImage;

/// 链式编程 最小值图标
- (UISlider *(^)(UIImage *image))sliderMiniValueImage;

/// 链式编程 最大值图标
- (UISlider *(^)(UIImage *image))sliderMaxiValueImage;

/// 链式编程 拖动块颜色
- (UISlider *(^)(UIColor *color))sliderThumbTintColor;

/// 链式编程 最小值背景颜色
- (UISlider *(^)(UIColor *color))sliderMiniTrackTintColor;

/// 链式编程 最大值背景颜色
- (UISlider *(^)(UIColor *color))sliderMaxiTrackTintColor;

@end
