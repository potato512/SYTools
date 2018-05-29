//
//  UISwitch+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/2.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UISwitch+SYCategory.h"
#import <objc/runtime.h>

@implementation UISwitch (SYCategory)

#pragma mark - 回调方法

- (void)setSwitchClick:(SwitchClick)switchClick
{
    if (switchClick)
    {
        [self addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventValueChanged];
        objc_setAssociatedObject(self, @selector(switchClick), switchClick, OBJC_ASSOCIATION_COPY);
    }
}

- (SwitchClick)switchClick
{
    SwitchClick switchClick = objc_getAssociatedObject(self, @selector(switchClick));
    return switchClick;
}

- (void)actionClick:(UISwitch *)sender
{
    if (self.switchClick)
    {
        self.switchClick(sender);
    }
}

+ (instancetype)switchWithFrame:(CGRect)frame view:(UIView *)superview status:(BOOL)isOff action:(SwitchClick)switchClick
{
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:frame];
    if (superview && [superview isKindOfClass:[UIView class]])
    {
        [superview addSubview:switchView];
    }
    switchView.on = !isOff;
    if (switchClick)
    {
        switchView.switchClick = [switchClick copy];
    }
    
    return switchView;
}


#pragma mark - 链式属性

/// 链式编程 关闭时的背景色
- (UISwitch *(^)(UIColor *color))switchTintColor
{
    return ^(UIColor *color) {
        self.tintColor = color;
        return self;
    };
}

/// 链式编程 打开时的背景色
- (UISwitch *(^)(UIColor *color))switchOnTintColor
{
    return ^(UIColor *color) {
        self.onTintColor = color;
        return self;
    };
}

/// 链式编程 拖动块颜色
- (UISwitch *(^)(UIColor *color))switchThumbTintColor
{
    return ^(UIColor *color) {
        self.thumbTintColor = color;
        return self;
    };
}

/// 链式编程 打开时的图标
- (UISwitch *(^)(UIImage *image))switchOnImage
{
    return ^(UIImage *image) {
        self.onImage = image;
        return self;
    };
}

/// 链式编程 关闭时的图标
- (UISwitch *(^)(UIImage *image))switchOffImage
{
    return ^(UIImage *image) {
        self.offImage = image;
        return self;
    };
}

/// 链式编程 是否打开
- (UISwitch *(^)(BOOL isEnable))switchOn
{
    return ^(BOOL isEnable) {
        self.on = isEnable;
        return self;
    };
}

@end
