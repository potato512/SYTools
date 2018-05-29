//
//  UISegmentedControl+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/1/16.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "UISegmentedControl+SYCategory.h"
#import <objc/runtime.h>

@implementation UISegmentedControl (SYCategory)

#pragma mark - 回调方法

- (void)setSegmentClick:(SegmentClick)segmentClick
{
    if (segmentClick)
    {
        [self addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventValueChanged];
        objc_setAssociatedObject(self, @selector(segmentClick), segmentClick, OBJC_ASSOCIATION_COPY);
    }
}

- (SegmentClick)segmentClick
{
    SegmentClick segmentClick = objc_getAssociatedObject(self, @selector(segmentClick));
    return segmentClick;
}

- (void)actionClick:(UISegmentedControl *)sender
{
    if (self.segmentClick)
    {
        self.segmentClick(sender);
    }
}

+ (instancetype)segmentControlWithItems:(NSArray *)titles frame:(CGRect)frame view:(UIView *)superview action:(SegmentClick)segmentClick
{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:titles];
    segmentControl.frame = frame;
    if (superview && [superview isKindOfClass:[UIView class]])
    {
        [superview addSubview:segmentControl];
    }
    if (segmentClick)
    {
        segmentControl.segmentClick = [segmentClick copy];
    }
    
    return segmentControl;
}

@end
