//
//  UIButton+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图片与标题显示样式
typedef NS_ENUM(NSInteger, SYButtonStyle)
{
    /// 图片与标题显示样式：图片居左，文字居右（默认，水平居中）
    SYButtonStyleDefault = 0,
    
    /// 图片与标题显示样式：图片居右，文字居左（水平居中）
    SYButtonStyleImageRightTextLeftHorizontalCenter = 1,
    
    /// 图片与标题显示样式：图片居中，文字居中（水平居中，垂直居中）
    SYButtonStyleCenter = 2,
    
    /// 图片与标题显示样式：图片居上，文字居下（垂直居中）
    SYButtonStyleImageUpTextDownVerticalCenter = 3,
    
    /// 图片与标题显示样式：图片居下，文字居上（垂直居中）
    SYButtonStyleImageDownTextUpVerticalCenter = 4,
};

/// 倒计时开始后显示样式（菊花转，或文字，默认菊花转）
typedef NS_ENUM(NSInteger, SYCountdownStartType)
{
    /// 菊花转
    SYCountdownStartTypeActivity = 0,
    
    /// 文字
    SYCountdownStartTypeText = 1,
};

/// 倒计时按钮状态（开始请求网络，请求成功-倒计时，请求失败-常规）
typedef NS_ENUM(NSInteger, SYCountdownType)
{
    // 开始请求网络
    SYCountdownTypeBegin = 1,
    
    // 请求成功-倒计时
    SYCountdownTypeSuccess = 2,
    
    // 请求失败-常规/停止
    SYCountdownTypeStop = 3,
};


typedef void (^ButtonClick)(UIButton *button);

@interface UIButton (SYCategory)

/// 图片与标题显示样式（offset大于0时拉开距离，offset小于0时缩小距离）
- (void)buttonStyle:(SYButtonStyle)style offSet:(CGFloat)offset;

/// 回调方法
@property (nonatomic, copy) ButtonClick buttonClick;

#pragma mark - 倒计时按钮
/*
 注意使用时，应该在视图控制器被释放时，将按钮的倒计时状态在方法"- (void)viewWillDisappear:(BOOL)animated
 { }"中设置为CountdownTypeStop，避免内存泄露。
*/

/// 设置当前按钮为倒计时类型的按钮
- (void)setButtonCountdownType;

/// 倒计时长（默认60秒）
- (void)setButtonCountdownTime:(NSTimeInterval)time;

/// 倒计时开始后显示样式（菊花转，或文字，默认菊花转）
- (void)setButtonCountedownStartType:(SYCountdownStartType)type;

/// 倒计时按钮状态（开始请求网络，请求成功-倒计时，请求失败-常规/停止。特别说明，若在倒计时进行时，务必在视图释放时在方法"- (void)viewWillDisappear:(BOOL)animated { }"中置为CountdownTypeStop）
- (void)setButtonCountdownType:(SYCountdownType)type;

/// 按钮标题-normal（默认@"获取验证码"）
@property (nonatomic, strong) NSString *titleNormal;
/// 按钮标题-disabledStart（默认@"正在获取..."）
@property (nonatomic, strong) NSString *titleDisabledStart;
/// 按钮标题-disabledFinish（默认@"N秒"）
@property (nonatomic, strong) NSString *titleDisabledFinish;

/// 字体大小
@property (nonatomic, strong) UIFont *titleFont;
/// 字体颜色-normal
@property (nonatomic, strong) UIColor *colorNormal;
/// 字体颜色-disabledStart/disabledFinish
@property (nonatomic, strong) UIColor *colorDisabled;


@end
