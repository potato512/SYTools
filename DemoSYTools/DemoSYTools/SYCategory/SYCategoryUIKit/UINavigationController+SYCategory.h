//
//  UINavigationController+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SYCategory)

/// 导航栏样式设置
- (void)navigationStyleDefault;

/// 导航栏样式设置（自定义背景颜色、字体）
- (void)navigationStyleColor:(UIColor *)backgroundColor textFont:(UIFont *)textFont textColor:(UIColor *)textColor;

@end
