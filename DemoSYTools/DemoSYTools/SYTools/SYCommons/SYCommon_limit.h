//
//  SYCommon_limit.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用限制

#ifndef zhangshaoyu_Common_limit_h
#define zhangshaoyu_Common_limit_h

/********************** limit ****************************/

#pragma mark - 时间限制

/// 提示符时间长度
static NSTimeInterval const kHUDTime = 2.5;

/// 动画时间长度
static NSTimeInterval const kAnimationsTime = 0.3;

#pragma mark - 宽高限制

/// 分割线高度
static CGFloat const kSeparatorLineHeight = 0.5;

/// IQKeyboard与输入控件间距
static CGFloat const kIQKeyboardDistanceFromTextField = 10.0;

#pragma mark - 字数输入限制

/// 用户名：4-20位
static NSInteger const kAccountMinLength = 4;
static NSInteger const kAccountMaxLength = 20;

/// 密码：6-20位
static NSInteger const kPasswordMinLength = 6;
static NSInteger const kPasswordMaxLength = 20;

/// 交易密码: 6-16位
static NSInteger const kPayPasswordMin = 6;
static NSInteger const kPayPasswordMax = 16;

/// 昵称：最多20位字符
static NSInteger const kNickNameMaxLength = 20;

/// 验证码：6位
static NSInteger const kValidateCodeMaxLength = 6;

/// 个性签名
static NSInteger const kSignatureMaxLength = 100;

/// 地址
static NSInteger const kAddressMaxLength = 100;

/// 手机号
static NSInteger const kPhoneMaxLength = 11;

/// 电话号
static NSInteger const kTelephoneMaxLength = 18;

/// 身份证号
static NSInteger const kIDCardNumberLength = 18;
/// 真实姓名
static NSInteger const kRealNameLength = 20;
/// 金额位数限制
static NSInteger const kMoneyLength = 12;
/// 银行卡号，12位号码
static NSInteger const kBankCardNumberMinLength = 12;
/// 银行卡号，19位号码
static NSInteger const kBankCardNumberMaxLength = 19;

#pragma mark - 字符输入限制

/// 字符输入限制
static NSString *const kNUMBERS = @"0123456789";
static NSString *const kxX = @"xX";
static NSString *const kAlphaNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
static NSString *const kSpecial_Character = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'";
static NSString *const kSpecialCharacterAndNumber = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789";
static NSString *const kAllCharacterAndNumber = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

/// 验证码，或其他数字输入（数字）
static NSString *const kRegexNumber = @"[0-9]";

/// 验证码，或其他数字输入（数字/大小写字母）
static NSString *const kRegexNumberLetter = @"[A-Za-z0-9]";

/// 验证码，或其他数字输入（大小写字母）
static NSString *const kRegexLetter = @"[A-Za-z]";

/// 验证码，或其他数字输入（大写字母）
static NSString *const kRegexUppercaseLetter = @"[A-Z]";

/// 验证码，或其他数字输入（小定字母）
static NSString *const kRegexLowercaseLetter = @"[a-z]";

/// 验证码，或其他数字输入（中文）
static NSString *const kRegexCN = @"[0x4e00-0x9fff]";

/// 验证码，或其他数字输入（数字/大小写字母/中文）
static NSString *const kRegexNumberLetterCN = @"[A-Za-z0-9\u4e00-\u9fa5]"; // \u4e00-\u9fa5 \0x4e00-\0x9fff

//@"^[0-9a-zA-Z]{4,12}$"

/********************** limit ****************************/

#endif
