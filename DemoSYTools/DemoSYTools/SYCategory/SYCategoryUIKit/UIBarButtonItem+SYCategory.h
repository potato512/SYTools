//
//  UIBarButtonItem+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/3/21.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+SYCategory.h"
#import "NSObject+SYCategory.h"

/// 按钮类型（左按钮、右按钮）
typedef NS_ENUM(NSInteger, UIBarButtonItemType)
{
    /// 按钮类型 左按钮
    UIBarButtonItemTypeLeft = 0,
    
    /// 按钮类型 右按钮
    UIBarButtonItemTypeRight = 1,
};

@interface UIBarButtonItem (SYCategory)

#pragma mark BarButtonItem-completionHandle

/**
 *  UIBarButtonItem：标题、响应回调
 *
 *  @param title  按钮标题
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：标题（常规颜色、高亮颜色）、响应回调
 *
 *  @param title  按钮标题
 *  @param colorN 按钮标题颜色
 *  @param colorH 按钮标题高亮颜色
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：图标、响应回调
 *
 *  @param image  按钮图标
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：图标、高亮图标、响应回调
 *
 *  @param image  按钮图标
 *  @param imageH 按钮高亮图标
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：标题、响应回调
 *
 *  @param title  按钮标题
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：标题（标题颜色、标题高亮颜色）、响应回调
 *
 *  @param title  按钮标题
 *  @param colorN 按钮标题颜色
 *  @param colorH 按钮标题高亮颜色
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：图标、响应回调
 *
 *  @param image  按钮图标
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：图标、高亮图标、响应回调
 *
 *  @param image  按钮图标
 *  @param imageH 按钮高亮图标
 *  @param action 按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH action:(void (^)(UIButton *item))action;

/**
 *  UIBarButtonItem：多属性
 *
 *  @param title      按钮标题
 *  @param titleH     按钮标题高亮
 *  @param titleS     按钮标题选中
 *  @param font       按钮标题字体
 *  @param color      按钮标题颜色
 *  @param colorH     按钮标题颜色高亮
 *  @param colorS     按钮标题颜色选中
 *  @param image      按钮图标
 *  @param imageH     按钮图标高亮
 *  @param imageS     按钮图标选中
 *  @param backImage  按钮背景图标
 *  @param backImageH 按钮背景图标高亮
 *  @param backImageS 按钮背景图标选中
 *  @param selected   是否选中
 *  @param buttonType 按钮图标与标题显示样式
 *  @param type       按钮类型（左按钮，或右按钮）
 *  @param action     按钮响应回调
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleHlight:(NSString *)titleH titleSelected:(NSString *)titleS titleFont:(UIFont *)font titleColor:(UIColor *)color titleColorHlight:(UIColor *)colorH titleColorSelected:(UIColor *)colorS image:(UIImage *)image imageHlight:(UIImage *)imageH imageSelected:(UIImage *)imageS backImage:(UIImage *)backImage backImageHlight:(UIImage *)backImageH backImageSelected:(UIImage *)backImageS selected:(BOOL)selected buttonType:(SYButtonStyle)buttonType type:(UIBarButtonItemType)type action:(void (^)(UIButton *item))action;

#pragma mark BarButtonItem-Selector

/**
 *  UIBarButtonItem（selector）：标题、响应对象、响应方法
 *
 *  @param title    按钮标题
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：标题（标题颜色、标题高亮颜色）、响应对象、响应方法
 *
 *  @param title    按钮标题
 *  @param colorN   按钮标题颜色
 *  @param colorH   按钮标题高亮颜色
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：图标、响应对象、响应方法
 *
 *  @param image    按钮图标
 *  @param target   响应对象
 *  @param selector 响应就进
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：图标、高亮图标、响应对象、响应方法
 *
 *  @param image    按钮图标
 *  @param imageH   按钮高亮图标
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：标题、响应对象、响应方法
 *
 *  @param title    按钮标题
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：标题（标题颜色、标题高亮颜色）、响应对象、响应方法
 *
 *  @param title    按钮标题
 *  @param colorN   标题颜色
 *  @param colorH   标题高亮颜色
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title colorNormal:(UIColor *)colorN colorHighlight:(UIColor *)colorH target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：图标、响应对象、响应方法
 *
 *  @param image    按钮图标
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：图标、高亮图标、响应对象、响应方法
 *
 *  @param image    按钮图标
 *  @param imageH   按钮高亮图标
 *  @param target   响应对象
 *  @param selector 响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image imageHighlight:(UIImage *)imageH target:(id)target selector:(SEL)selector;

/**
 *  UIBarButtonItem（selector）：多属性
 *
 *  @param title      按钮标题
 *  @param titleH     按钮高亮标题
 *  @param titleS     按钮选中标题
 *  @param font       按钮标题字体
 *  @param color      按钮标题颜色
 *  @param colorH     按钮标题高亮颜色
 *  @param colorS     按钮标题选中颜色
 *  @param image      按钮图标
 *  @param imageH     按钮高亮图标
 *  @param imageS     按钮选中图标
 *  @param backImage  按钮背景图标
 *  @param backImageH 按钮背景高亮图标
 *  @param backImageS 按钮背景选中图标
 *  @param selected   是否选中状态
 *  @param buttonType 按钮图标与标题显示样式
 *  @param type       按钮类型（左按钮，或右按钮）
 *  @param target     响应对象
 *  @param selector   响应方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title titleHlight:(NSString *)titleH titleSelected:(NSString *)titleS titleFont:(UIFont *)font titleColor:(UIColor *)color titleColorHlight:(UIColor *)colorH titleColorSelected:(UIColor *)colorS image:(UIImage *)image imageHlight:(UIImage *)imageH imageSelected:(UIImage *)imageS backImage:(UIImage *)backImage backImageHlight:(UIImage *)backImageH backImageSelected:(UIImage *)backImageS selected:(BOOL)selected buttonType:(SYButtonStyle)buttonType type:(UIBarButtonItemType)type target:(id)target selector:(SEL)selector;


@end
