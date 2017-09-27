//
//  SYCountDownButton.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/24.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 倒计时开始后显示样式（菊花转，或文字，默认菊花转）
typedef NS_ENUM(NSInteger, CountdownStartType)
{
    /// 菊花转
    CountdownStartTypeActivity = 0,
    
    /// 文字
    CountdownStartTypeText = 1,
};

/// 倒计时按钮状态（开始请求网络，请求成功-倒计时，请求失败-常规）
typedef NS_ENUM(NSInteger, CountdownType)
{
    // 开始请求网络
    CountdownTypeBegin = 1,
    
    // 请求成功-倒计时
    CountdownTypeSuccess = 2,
    
    // 请求失败-常规/停止
    CountdownTypeStop = 3,
};

@interface SYCountDownButton : UIButton

/// 倒计时长（默认60秒）
@property (nonatomic, assign) NSTimeInterval timeCountdown;

/// 倒计时开始后显示样式（菊花转，或文字，默认菊花转）
@property (nonatomic, assign) CountdownStartType countDownStartType;

/// 倒计时按钮状态（开始请求网络，请求成功-倒计时，请求失败-常规/停止。特别说明，若在倒计时进行时，务必在视图释放时置为CountdownTypeStop）
@property (nonatomic, assign) CountdownType countdownType;

/// 点击按钮回调
@property (nonatomic, copy) void (^buttonClick)(void);

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

/// 初始化
- (instancetype)init;
/// 初始化-frame
- (instancetype)initWithFrame:(CGRect)frame;
/// 初始化-frame/父视图view/倒计时长time/开始后显示样式startType/响应回调selector
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view time:(NSTimeInterval)timeCountdown startType:(CountdownStartType)type selector:(void (^)(void))selector;

@end
