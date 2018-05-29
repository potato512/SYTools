//
//  UITabBarController+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/4/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (SYCategory)

/**
 *  UITabBarController初始化样式
 *
 *  @param bgroundImage      背景图标
 *  @param textFont          字体大小
 *  @param textColor         字体颜色
 *  @param textColorSelected 字体选中颜色
 */
+ (void)initializeTabBabController:(UIImage *)bgroundImage font:(UIFont *)textFont color:(UIColor *)textColor colorSelected:(UIColor *)textColorSelected;

/**
 *  UITabBarController始化视图控制器（视图控制器、标题、图标、选中图标；需要初始化样式）
 *
 *  @param controllers   视图控制器数组
 *  @param titles        item标题
 *  @param imageNorNames item图标
 *  @param imageSelNames item选中图标
 */
- (void)initWithViewController:(NSArray *)controllers titles:(NSArray *)titles imageNormal:(NSArray *)imageNorNames imageSelected:(NSArray *)imageSelNames;

/**
 *  UITabBarController始化视图控制器（视图控制器、标题、图标、选中图标、字体大小、字体颜色、字体选中颜色；无需初始化样式）
 *
 *  @param controllers       视图控制器数组
 *  @param titles            标题数组
 *  @param imageNorNames     图标数组
 *  @param imageSelNames     选中图标数组
 *  @param textFont          字体大小
 *  @param textColor         字体颜色
 *  @param textColorSelected 选中字体颜色 
 *  @param bgroundImage      背景图标
 */
- (void)initWithViewController:(NSArray *)controllers titles:(NSArray *)titles imageNormal:(NSArray *)imageNorNames imageSelected:(NSArray *)imageSelNames font:(UIFont *)textFont color:(UIColor *)textColor colorSelected:(UIColor *)textColorSelected image:(UIImage *)bgroundImage;

@end
