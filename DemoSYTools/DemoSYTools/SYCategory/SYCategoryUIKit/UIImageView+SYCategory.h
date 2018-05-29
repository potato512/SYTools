//
//  UIImageView+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/29.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SYCategory)

#pragma mark - 链式属性

/// 链式编程 图片
- (UIImageView *(^)(UIImage *image))normalImage;

/// 链式编程 高亮图片
- (UIImageView *(^)(UIImage *image))highlightImage;

/// 链式编程 动画图片数组
- (UIImageView *(^)(NSArray<UIImage *> *images))animationImageArray;

/// 链式编程 高亮动画图片数组
- (UIImageView *(^)(NSArray<UIImage *> *images))highlightAnimationImageArray;

/// 链式编程 动画播放时长
- (UIImageView *(^)(NSTimeInterval duration))animationTime;

/// 链式编程 动画播放次数
- (UIImageView *(^)(NSInteger repeat))animationRepeat;

@end
