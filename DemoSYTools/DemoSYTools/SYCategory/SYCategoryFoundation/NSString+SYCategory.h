//
//  NSString+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SYCategory)

#pragma mark - 字符串后缀信息

- (NSString *)fileName;

- (NSString *)fileType;

#pragma mark - 数值转字符串

/// number转字string
+ (NSString *)stringWithNumber:(NSNumber *)value;

/// int转字string
+ (NSString *)stringWithInt:(int)value;
/// integer转字string
+ (NSString *)stringWithInteger:(NSInteger)value;

/// float转字string
+ (NSString *)stringWithFloat:(float)value;

/// double转字string
+ (NSString *)stringWithDouble:(double)value;

#pragma mark -

/**
 *  获取字符串首字符（汉字会被转换成全拼音）
 *
 *  @return 字符串首字符
 */
- (NSString *)firstCharacter;

#pragma mark - 字符处理方法

/// 字符隐藏显示设置（使用诸如“*”符号代替，同时设置只显示前几位，及后几位）
- (NSString *)textHiddenWithSymbol:(NSString *)symbol showBegin:(NSInteger)begin showEnd:(NSInteger)end;

/// 数字字符串保留小数点后任意位数
- (NSString *)textKeepDecimalPointWithNumber:(NSInteger)length;

/// 金额字符串转换显示样式（每三位以空格，或,进行分割显示）
- (NSString *)textMoneySeparatorWithSymbol:(NSString *)symbol;

#pragma mark - 字符异常判断方法

/// 有效字符（非空，且非空格）
+ (BOOL)isValidNSString:(NSString *)string;

/// 字符非空判断（可以是空格字符串）
+ (BOOL)isNullNSString:(NSString *)string;

/// 字符非空判断（不能是空格字符串）
+ (BOOL)isNullBlankNSString:(NSString *)string;

/// 过滤字符串中的空格符
- (NSString *)textFilterBlankSpace;

/// 判断输入的字符长度 一个汉字算2个字符，是否区分中英文
- (NSUInteger)textLength:(BOOL)isCN;

#pragma mark - 字符等级强弱度识别

/// 5个条件（长度大于10、含大写字母、含小写字母、含数字、含特殊符号）0不包含，1任一条件，2任二条件，3任三条件，4任条件，5包含
- (NSInteger)textStrengthGrade;

#pragma mark - 连续数字字符串

/// 判断数字字符是否是连续n个或n个以上数字字符串，区分降序或升序（默认长序）
- (BOOL)isContinuousNumberNSString:(NSInteger)number order:(BOOL)isAscending;

#pragma mark - 链式属性

/// 属性设置NSString转换NSAttributedString
- (NSAttributedString *(^)(NSString *text, UIColor *color, UIColor *backColor, UIFont *font, CGFloat characterSpace, CGFloat rowSpace))attributedText;

/// 设置字体的下划线，或删除线，及其线条大小、颜色与类型（如下划线单线类型NSUnderlineStyleSingle）
- (NSAttributedString *(^)(NSString *text, UIColor *color, UIFont *font, BOOL isDelete, NSInteger lineType, CGFloat lineWidth, UIColor *lineColor))attributedTextlineStyle;

@end
