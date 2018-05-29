//
//  UIImageView+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/29.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImageView+SYCategory.h"

@implementation UIImageView (SYCategory)

#pragma mark - 链式属性

/// 链式编程 图片
- (UIImageView *(^)(UIImage *image))normalImage
{
    return ^(UIImage *image) {
        self.image = image;
        return self;
    };
}

/// 链式编程 高亮图片
- (UIImageView *(^)(UIImage *image))highlightImage
{
    return ^(UIImage *image) {
        self.highlightedImage = image;
        return self;
    };
}

/// 链式编程 动画图片数组
- (UIImageView *(^)(NSArray<UIImage *> *images))animationImageArray
{
    return ^(NSArray<UIImage *> *images) {
        self.animationImages = images;
        return self;
    };
}

/// 链式编程 高亮动画图片数组
- (UIImageView *(^)(NSArray<UIImage *> *images))highlightAnimationImageArray
{
    return ^(NSArray<UIImage *> *images) {
        self.highlightedAnimationImages = images;
        return self;
    };
}

/// 链式编程 动画播放时长
- (UIImageView *(^)(NSTimeInterval duration))animationTime
{
    return ^(NSTimeInterval duration) {
        self.animationDuration = duration;
        return self;
    };
}

/// 链式编程 动画播放次数
- (UIImageView *(^)(NSInteger repeat))animationRepeat
{
    return ^(NSInteger repeat) {
        self.animationRepeatCount = repeat;
        return self;
    };
}

@end
