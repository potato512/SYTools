//
//  UIViewController+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+SYCategory.h"

@interface UIViewController (SYCategory)


/**
 *  是否通过点击视图控制器隐藏键盘（默认NO）
 */
@property (nonatomic, assign) BOOL hiddenKeyboard;

/// 是否是根视图
- (BOOL)isRootController;

/// 返回上层视图响应
- (void)backPreviousController;

/// 设置导航栏标题视图
- (void)setNavigationTitleView:(UIView *)titleView;
/// 设置导航栏标题
- (void)setNavigationTitle:(NSString *)title;
/// 导航栏标题
@property (nonatomic, strong) NSString *navigationItemTitle;

#pragma mark - 链式属性

/// 链式编程 适配（视图显示在导航栏之下）
- (UIViewController *(^)())autoLayoutExtended;

@end
