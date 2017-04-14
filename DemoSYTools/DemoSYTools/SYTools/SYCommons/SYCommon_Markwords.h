//
//  SYCommon_Markwords.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用提示语

#ifndef zhangshaoyu_Common_Markwords_h
#define zhangshaoyu_Common_Markwords_h

/********************** message ****************************/

#pragma mark - ActionSheep弹出视图提示语

static NSString *const kActionTitle                  = @"温馨提示";
static NSString *const kActionCancel                 = @"取消";
static NSString *const kActionConfirm                = @"确定";
static NSString *const kActionTitleModifyHeaderImage = @"修改头像";
static NSString *const kActionTakingPictures         = @"拍照";
static NSString *const kActionPhotoAlbum             = @"从相册选择";

#pragma mark - AlertView弹出视图提示语

static NSString *const kAlertTitle      = @"温馨提示";
static NSString *const kAlertCancel     = @"取消";
static NSString *const kAlertExit       = @"退出登录";
static NSString *const kAlertConfirm    = @"确认";
static NSString *const kAlertRealized   = @"知道了";
static NSString *const kAlertClose      = @"关闭";
static NSString *const kAlertUpgrade    = @"去升级";
static NSString *const kAlertUpDate     = @"立即更新";
static NSString *const kAlertMeaageExit = @"确定要退出当前登录账号吗？";
static NSString *const kAlertWithdraw   = @"提现";
static NSString *const kAlertRecharge   = @"充值";

#pragma mark - 网络交互提示语

static NSString *const kNetworkNotReachable          = @"网络异常，请检查网络设置";
static NSString *const kNetworkWithoutInternet       = @"网络异常，请检查网络设置";
static NSString *const kNetworkWithoutData           = @"暂无数据";
static NSString *const kNetworkWithoutInvestmentData = @"暂无可投资项目";
static NSString *const kNetworkLoading               = @"加载中...";
static NSString *const kNetworkLoadFailed            = @"加载失败";
static NSString *const kNetworkSaveFailed            = @"保存失败";
static NSString *const kNetworkWaitting              = @"请稍后...";

#pragma mark - 注册登录

static NSString *const kAccountLogining        = @"登录...";
static NSString *const kAccountLoginSuccess    = @"登录成功！";
static NSString *const kAccoutRegistering      = @"注册中...";
static NSString *const kAccountSettingPassword = @"设置密码中...";
static NSString *const kAccountRegisterSuccsee = @"注册成功！";

static NSString *const kVeridateSending  = @"正在发送短信验证码...";
static NSString *const kVeridateChecking = @"正在校验短信验证码...";

static NSString *const kAccountUserNameNull = @"请输入用户名或手机号";
static NSString *const kAccountpasswordNull = @"请输入密码";

#pragma mark - 输入限制

static NSString *const kRegisterMobileNull          = @"请输入11位手机号";
static NSString *const kRegisterMobileWrong         = @"请输入正确的手机号";
static NSString *const kRegisterVerityNull          = @"请输入验证码";
static NSString *const kRegisterVerityWrong         = @"请输入正确的验证码";
static NSString *const kRegisterAccountNull         = @"请输入用户名";
static NSString *const kRegisterAccountNum          = @"请输入6-20位用户名";
static NSString *const kRegisterAccountRegex        = @"帐号格式错误，请重试";
static NSString *const kRegisterPasswordNull        = @"请输入密码";
static NSString *const kRegisterPasswordNum         = @"请输入6-20位密码";
static NSString *const kRegisterPasswordConfrimNull = @"请输入确认密码";
static NSString *const kRegisterPasswordConfirmNum  = @"请输入6-20位确认密码";
static NSString *const kRegisterPasswordNoSame      = @"密码输入不一致，请重新输入";
static NSString *const kRegisterPasswordOld         = @"请输入原密码";
static NSString *const kRegisterPasswordNew         = @"请输入6-20位新密码";
static NSString *const kPayPasswordNum              = @"请输入6位支付密码";

#pragma mark - 定位

static NSString *const kAreaDefault      = @"选择省/市/区";
static NSString *const klocationFailed   = @"定位失败...";
static NSString *const klocationStart    = @"正在定位...";
static NSString *const kSearchRoadFailed = @"寻路失败";
static NSString *const kSearchRoadStart  = @"寻路中...";

/********************** message ****************************/

#endif
