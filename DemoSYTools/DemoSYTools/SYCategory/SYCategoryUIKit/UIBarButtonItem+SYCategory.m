//
//  UIBarButtonItem+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/3/21.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "UIBarButtonItem+SYCategory.h"

// 按钮大小
static CGFloat const sizeButton = 40.0;

@implementation UIBarButtonItem (SYCategory)

#pragma mark completionHandle

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight action:action];
    return item;
}

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:colorN titleColorHlight:colorH titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight action:action];
    return item;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight action:action];
    return item;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:imageH imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight action:action];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft action:action];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:colorN titleColorHlight:colorH titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft action:action];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft action:action];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH action:(void (^)(UIButton *item))action
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:imageH imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft action:action];
    return item;
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleHlight:(NSString *)titleH titleSelected:(NSString *)titleS titleFont:(UIFont *)font titleColor:(UIColor *)color titleColorHlight:(UIColor *)colorH titleColorSelected:(UIColor *)colorS image:(UIImage *)image imageHlight:(UIImage *)imageH imageSelected:(UIImage *)imageS backImage:(UIImage *)backImage backImageHlight:(UIImage *)backImageH backImageSelected:(UIImage *)backImageS selected:(BOOL)selected buttonType:(SYButtonStyle)buttonType type:(UIBarButtonItemType)type action:(void (^)(UIButton *item))action
{
    UIButton *button = [self buttonWithTitle:title titleHlight:titleH titleSelected:titleS titleFont:font titleColor:color titleColorHlight:colorH titleColorSelected:colorS image:image imageHlight:imageH imageSelected:imageS backImage:backImage backImageHlight:backImageH backImageSelected:backImageS selected:selected buttonType:buttonType type:type actionHandle:action target:nil actionSelector:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

#pragma mark Selector

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:colorN titleColorHlight:colorH titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:imageH imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeRight target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:title titleHlight:nil titleSelected:nil titleFont:nil titleColor:colorN titleColorHlight:colorH titleColorSelected:nil image:nil imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:nil imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithTitle:nil titleHlight:nil titleSelected:nil titleFont:nil titleColor:nil titleColorHlight:nil titleColorSelected:nil image:image imageHlight:imageH imageSelected:nil backImage:nil backImageHlight:nil backImageSelected:nil selected:NO buttonType:SYButtonStyleDefault type:UIBarButtonItemTypeLeft target:target selector:selector];
    return item;
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleHlight:(NSString *)titleH titleSelected:(NSString *)titleS titleFont:(UIFont *)font titleColor:(UIColor *)color titleColorHlight:(UIColor *)colorH titleColorSelected:(UIColor *)colorS image:(UIImage *)image imageHlight:(UIImage *)imageH imageSelected:(UIImage *)imageS backImage:(UIImage *)backImage backImageHlight:(UIImage *)backImageH backImageSelected:(UIImage *)backImageS selected:(BOOL)selected buttonType:(SYButtonStyle)buttonType type:(UIBarButtonItemType)type target:(id)target selector:(SEL)selector
{
    UIButton *button = [self buttonWithTitle:title titleHlight:titleH titleSelected:titleS titleFont:font titleColor:color titleColorHlight:colorH titleColorSelected:colorS image:image imageHlight:imageH imageSelected:imageS backImage:backImage backImageHlight:backImageH backImageSelected:backImageS selected:selected buttonType:buttonType type:type actionHandle:nil target:target actionSelector:selector];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

#pragma mark button

+ (UIButton *)buttonWithTitle:(NSString *)title titleHlight:(NSString *)titleH titleSelected:(NSString *)titleS titleFont:(UIFont *)font titleColor:(UIColor *)color titleColorHlight:(UIColor *)colorH titleColorSelected:(UIColor *)colorS image:(UIImage *)image imageHlight:(UIImage *)imageH imageSelected:(UIImage *)imageS backImage:(UIImage *)backImage backImageHlight:(UIImage *)backImageH backImageSelected:(UIImage *)backImageS selected:(BOOL)selected buttonType:(SYButtonStyle)buttonType type:(UIBarButtonItemType)type actionHandle:(void (^)(UIButton *item))actionHandle target:(id)target actionSelector:(SEL)actionSelector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    // 标题字体
    button.titleLabel.font = (font ? font : [UIFont systemFontOfSize:13.0]);
    // 状态
    button.selected = selected;
    // 响应事件
    button.buttonClick = ^(UIButton *button) {
        if (actionHandle)
        {
            actionHandle(button);
        }
    };
    if (target)
    {
        [button addTarget:target action:actionSelector forControlEvents:UIControlEventTouchUpInside];
    }
    // 标题
    if (title)
    {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleH)
    {
        [button setTitle:titleH forState:UIControlStateHighlighted];
    }
    if (titleS)
    {
        [button setTitle:titleS forState:UIControlStateSelected];
    }
    // 标题颜色
    [button setTitleColor:(color ? color : [UIColor blackColor]) forState:UIControlStateNormal];
    [button setTitleColor:(colorH ? colorH : [UIColor lightGrayColor]) forState:UIControlStateHighlighted];
    [button setTitleColor:(colorS ? colorS : [UIColor blackColor]) forState:UIControlStateSelected];
    // 图标
    if (image)
    {
        [button setImage:image forState:UIControlStateNormal];
    }
    [button setImage:(imageH ? imageH : nil) forState:UIControlStateHighlighted];
    if (imageS)
    {
        [button setImage:imageS forState:UIControlStateSelected];
    }
    // 背景图片
    if (backImage)
    {
        [button setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (backImageH)
    {
        [button setBackgroundImage:backImageH forState:UIControlStateHighlighted];
    }
    if (backImageS)
    {
        [button setBackgroundImage:backImageS forState:UIControlStateSelected];
    }
    // 按钮类型
    [button buttonStyle:buttonType offSet:5.0];
    // 实际按钮宽
    CGFloat width = [button widthWithText:button.titleLabel.text font:button.titleLabel.font];
    if (button.imageView.image)
    {
        // 有图片时，添加图片宽
        width += (button.imageView.image.size.width + 5.0);
    }
    else
    {
        // 没有图标，纯字符时的字体位置
        button.titleEdgeInsets = (UIBarButtonItemTypeLeft == type ? UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0) : UIEdgeInsetsMake(0.0, 0.0, 0.0, -5.0));
    }
    width = (width < sizeButton ? sizeButton : width);
    button.frame = CGRectMake(0.0, 0.0, width, sizeButton);
    
    // 只有图标时
    if (button.imageView.image && 0 == button.titleLabel.text.length)
    {
        button.imageEdgeInsets = (UIBarButtonItemTypeLeft == type ? UIEdgeInsetsMake(0.0, -10.0, 0.0, 0.0) : UIEdgeInsetsMake(0.0, 0.0, 0.0, -10.0));
    }
    
    return button;
}

@end
