//
//  UISegmentedControl+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/1/16.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SegmentClick)(UISegmentedControl *sender);

@interface UISegmentedControl (SYCategory)

/// 回调方法
@property (nonatomic, copy) SegmentClick segmentClick;

/**
 *  实例化UISegmentControl
 *
 *  @param titles       标题数组
 *  @param frame        坐标大小
 *  @param superview    父视图
 *  @param segmentClick 响应回调
 *
 *  @return UISegmentControl
 */
+ (instancetype)segmentControlWithItems:(NSArray *)titles frame:(CGRect)frame view:(UIView *)superview action:(SegmentClick)segmentClick;

@end
