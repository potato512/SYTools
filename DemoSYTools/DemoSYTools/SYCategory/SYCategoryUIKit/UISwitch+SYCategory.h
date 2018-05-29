//
//  UISwitch+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/2.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SwitchClick)(UISwitch *sender);

@interface UISwitch (SYCategory)

/// 回调方法
@property (nonatomic, copy) SwitchClick switchClick;

/**
 *  实例化UISwitch
 *
 *  @param frame       坐标大小
 *  @param superview   父视图
 *  @param isOff       状态开关
 *  @param switchClick 响应回调
 *
 *  @return UISwitch
 */
+ (instancetype)switchWithFrame:(CGRect)frame view:(UIView *)superview status:(BOOL)isOff action:(SwitchClick)switchClick;


#pragma mark - 链式属性

/// 链式编程 关闭时的背景色
- (UISwitch *(^)(UIColor *color))switchTintColor;

/// 链式编程 打开时的背景色
- (UISwitch *(^)(UIColor *color))switchOnTintColor;

/// 链式编程 拖动块的颜色
- (UISwitch *(^)(UIColor *color))switchThumbTintColor;

/// 链式编程 打开时的图标
- (UISwitch *(^)(UIImage *image))switchOnImage;

/// 链式编程 关闭时的图标
- (UISwitch *(^)(UIImage *image))switchOffImage;

/// 链式编程 是否打开
- (UISwitch *(^)(BOOL isEnable))switchOn;

@end
