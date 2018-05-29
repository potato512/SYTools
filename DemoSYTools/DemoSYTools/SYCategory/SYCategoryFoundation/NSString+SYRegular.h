//
//  NSString+SYRegular.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYRegular)

#pragma mark - 字符正则

/**
 *  是否是正确的指定正则的格式
 *
 *  @param regex 正则
 *
 *  @return 是，或否
 */
- (BOOL)isValidText:(NSString *)regex;

/**
 *  判断是否正确的移动手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobileCM;

/**
 *  判断是否正确的联通手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobileCU;

/**
 *  判断是否正确的电信手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobileCT;

/**
 *  判断是否正确的手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobile;

/**
 *  判断是否正确的电子邮箱格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidEmail;

/// 字符是否只包含"数字、大小写字母、_、@"的用户帐号
- (BOOL)isValidAccount;

/// 字符是否只包含"数字、大小写字母"且为4~12位的有效帐户
- (BOOL)isValidLimitAccount;

/// 字符是否是有效密码（大小写字母、数字组成，8-16位）
- (BOOL)isValidPassword;

/// 字符是否指定金额（100位整数，2位小数）
- (BOOL)isValidMoney;

/// 字符是否是有效的银行卡号（12~19位数字）
- (BOOL)isValidBankCardNumber;

/// 字符是否是合法身份证账号（数字与字母组成）
- (BOOL)isValidIDCard;

/// 字符是否是有效的身份证号码
- (BOOL)isValidIdentityCard;

/// 正则判断
- (BOOL)isValidTextWithPredicate:(NSString *)regex;

#pragma mark - 字符判断

/**
 *  判断是否含有空格的字符串
 *
 *  @return 是，或否
 */
- (BOOL)isSpaceString;

/**
 *  判断字符串是否是纯数字字符串
 *
 *  @return 是，或否
 */
- (BOOL)isNumberNSString;

/// 判断一个数字字符串是整数还是一个小数字符串
- (BOOL)isDecimalNumberNSString;

/// 字符串是否是纯汉字字符串
- (BOOL)isCNNSString;

/// 字符串是大小写英文字符串
- (BOOL)isENNString;

/// 字符串是大写英文字符串
- (BOOL)isUppercaseNSString;

/// 字符串是小写英文字符串
- (BOOL)isLowercaseNSString;

/// 字符串是特殊字符字符串
- (BOOL)isSpecialNSString;

/// 字符串中是否包含汉字字符
- (BOOL)isContantCNNSString;

/// 判断当前字符类型（NO中文字符；YES英文字符）
- (BOOL)isENCharacter;

/// 是否是指定的字符类型
- (BOOL)isContantWithText:(NSString *)text;

/// 是否包含子字符串
- (BOOL)isContantSubtext:(NSString *)text;

/// 是否包含指定的字符
- (BOOL)isContantSomeCharacters:(NSString *)characters;

#pragma mark - 表情输入限制

/// 包含表情字符
- (BOOL)isEmojiString;

#pragma mark - 字符类型判断

/**
 *  限制不能输入指定字符回调
 *
 *  @param text    限制不能输入的字符串
 *  @param regular 回调
 */
- (void)regularWithText:(NSString *)text limitedHandle:(void (^)(NSInteger index))regular;

/**
 *  限制只能输入指定字符回调
 *
 *  @param text    限制只能输入的字符串
 *  @param regular 回调
 */
- (void)regularWithText:(NSString *)text allowedHandle:(void (^)(NSInteger index))regular;

/**
 *  限制输入指定字符回调
 *
 *  @param text    限制指定字符串
 *  @param islimit 是限制输入，还是允许输入
 *  @param regular 回调
 */
- (void)regularWithText:(NSString *)text limited:(BOOL)islimit handle:(void (^)(NSInteger index))regular;

@end
