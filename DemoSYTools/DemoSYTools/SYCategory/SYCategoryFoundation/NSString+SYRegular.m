//
//  NSString+SYRegular.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSString+SYRegular.h"
#import "NSString+SYCategory.h"

static NSString *const kNumberRegular = @"0123456789";
static NSString *const kUpperRegular = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static NSString *const kLowerRegular = @"abcdefghijklmnopqrstuvwxyz";
static NSString *const kENRegular = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static NSString *const kSpecialRegular = @";~`!@#$%^&*()_+-={}[]|:\"'<>,.?/\";";

@implementation NSString (SYRegular)

#pragma mark - 字符正则

/**
 *  是否是正确的指定正则的格式
 *
 *  @param regex 正则
 *
 *  @return 是，或否
 */
- (BOOL)isValidText:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:self];
    
    return isValid;
}

/**
 *  判断是否正确的移动手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobileCM
{
    // 替换空格
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (11 != result.length)
    {
        return NO;
    }
    else
    {
        // 移动号码正则
        NSString *regex = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        BOOL isValid = [result isValidText:regex];
        
        return isValid;
    }
}

/**
 *  判断是否正确的联通手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobileCU
{
    // 替换空格
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (11 != result.length)
    {
        return NO;
    }
    else
    {
        // 联通号码正则
        NSString *regex = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5-6]))\\d{8}|(1709)\\d{7}$";
        BOOL isValid = [result isValidText:regex];
        
        return isValid;
    }
}

/**
 *  判断是否正确的电信手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobileCT
{
    // 替换空格
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (11 != result.length)
    {
        return NO;
    }
    else
    {
        // 电信号码正则
        NSString *regex = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        BOOL isValid = [result isValidText:regex];
        
        return isValid;
    }
}

/**
 *  判断是否正确的手机号码格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidMobile
{
    BOOL isCM = [self isValidMobileCM];;
    BOOL isCU = [self isValidMobileCT];
    BOOL isCT = [self isValidMobileCU];
    
    if (isCM || isCU || isCT)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    /*
     // 手机号码判断
     NSString *regex = @"^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\\d{8}$";
     NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
     BOOL isMatch = [pred evaluateWithObject:string];
     if (isMatch)
     {
     return YES;
     }
     else
     {
     return NO;
     }
     */
}

/**
 *  判断是否正确的电子邮箱格式
 *
 *  @return 是，或否
 */
- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,4}";
    BOOL isValid = [self isValidText:regex];
    
    return isValid;
}

/// 字符是否只包含"数字、大小写字母、_、@"的用户帐号
- (BOOL)isValidAccount
{
    BOOL isResult = [self isValidText:@"^[0-9a-zA-Z_.@]"];
    return isResult;
}

/// 字符是否只包含"数字、大小写字母"且为4~12位的有效帐户
- (BOOL)isValidLimitAccount
{
    BOOL isResult = [self isValidText:@"^[0-9a-zA-Z]{4,12}$"];
    return isResult;
}

/// 字符是否是有效密码（字母数字组成，8-16位）
- (BOOL)isValidPassword
{
    BOOL isResult = [self isValidText:@"^[0-9a-zA-Z]{8,16}$"];
    return isResult;
}

/// 字符是否指定金额（100位整数，2位小数）
- (BOOL)isValidMoney
{
    BOOL isResult = [self isValidText:@"^(([1-9]\\d{0,100})|0)(\\.\\d{1,2})?$"];
    return isResult;
}

/// 字符是否是有效的银行卡号（12~19位数字）
- (BOOL)isValidBankCardNumber
{
    BOOL isResult = [self isValidText:@"^[0-9]{12,19}$"];
    return isResult;
}

/// 字符是否是合法身份证账号（数字与字母组成）
- (BOOL)isValidIDCard
{
    BOOL isResult = [self isValidText:@"[0-9xX]"];
    return isResult;
}

/// 字符是否是有效的身份证号码
- (BOOL)isValidIdentityCard
{
    // 判断位数
    NSInteger countCard = self.length;
    if (countCard == 15 || countCard == 18)
    {
        NSString *identityCard = self;
        long lSumQT = 0;
        
        // 加权因子
        int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
        
        // 校验码
        unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
        
        // 将15位身份证号转换成18位
        NSMutableString *mString = [NSMutableString stringWithString:self];
        if (countCard == 15)
        {
            [mString insertString:@"19" atIndex:6];
            long p = 0;
            const char *pid = [mString UTF8String];
            for (int i = 0; i <= 16; i++)
            {
                p += (pid[i] - 48) * R[i];
            }
            int o = p % 11;
            NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
            [mString insertString:string_content atIndex:[mString length]];
            identityCard = mString;
        }
        
        // 判断地区码
        NSString * sProvince = [identityCard substringToIndex:2];
        if (![self areaCode:sProvince])
        {
            return NO;
        }
        
        // 判断年月日是否有效
        // 年份
        int strYear = [[identityCard substringWithRange:NSMakeRange(6,4)] intValue];
        // 月份
        int strMonth = [[identityCard substringWithRange:NSMakeRange(10,2)] intValue];
        // 日
        int strDay = [[identityCard substringWithRange:NSMakeRange(12,2)] intValue];
        
        NSTimeZone *localZone = [NSTimeZone localTimeZone];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setTimeZone:localZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
        if (date == nil)
        {
            return NO;
        }
        const char *PaperId  = [identityCard UTF8String];
        
        // 检验长度
        if (18 != strlen(PaperId))
        {
            return -1;
        }
        
        // 校验数字
        for (int i = 0; i < 18; i++)
        {
            if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i))
            {
                return NO;
            }
        }
        
        // 验证最末的校验码
        for (int i = 0; i <= 16; i++)
        {
            lSumQT += (PaperId[i] - 48) * R[i];
        }
        if (sChecker[lSumQT % 11] != PaperId[17] )
        {
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil)
    {
        return NO;
    }
    
    return YES;
}

/// 正则判断
- (BOOL)isValidTextWithPredicate:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isResult = [predicate evaluateWithObject:self];
    return isResult;
}

#pragma mark - 字符判断

/**
 *  判断是否含有空格的字符串
 *
 *  @return 是，或否
 */
- (BOOL)isSpaceString
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}

/**
 *  判断字符串是否是纯数字字符串
 *
 *  @return 是，或否
 */
- (BOOL)isNumberNSString
{
    /*
     unichar c;
     for (int i = 0; i < self.length; i++)
     {
     c = [self characterAtIndex:i];
     if (!isdigit(c))
     {
     return NO;
     }
     }
     return YES;
     */
    
    BOOL isResult = [self isContantWithText:kNumberRegular];
    return isResult;
}

/// 判断一个数字字符串是整数还是一个小数字符串
- (BOOL)isDecimalNumberNSString
{
    NSRange range = [self rangeOfString:@"."];
    if (range.location == NSNotFound)
    {
        BOOL result = NO;
        
        NSString *pointString = [self substringFromIndex:(range.location + range.length)];
        NSInteger count = pointString.length;
        for (int i = 0; i < count; i++)
        {
            NSString *tempString = [pointString substringWithRange:NSMakeRange(i, 1)];
            if ([tempString isEqualToString:@"0"])
            {
                result = YES;
            }
            else
            {
                result = NO;
                break;
            }
        }
        return result;
    }
    return YES;
}

/// 字符串是否是纯汉字字符串
- (BOOL)isCNNSString
{
    BOOL isResult = YES;
    NSInteger count = self.length;
    for (NSInteger i = 0; i < count; i++)
    {
        int charCN = [self characterAtIndex:i];
        if (charCN > 0x4e00 && charCN < 0x9fff)
        {
            continue;
        }
        else
        {
            isResult = NO;
            break;
        }
    }
    return isResult;
}

- (BOOL)isENNString
{
    BOOL isResult = [self isContantWithText:kENRegular];
    return isResult;
}

- (BOOL)isUppercaseNSString
{
    BOOL isResult = [self isContantWithText:kUpperRegular];
    return isResult;
}

- (BOOL)isLowercaseNSString
{
    BOOL isResult = [self isContantWithText:kLowerRegular];
    return isResult;
}

- (BOOL)isSpecialNSString
{
    BOOL isResult = [self isContantWithText:kSpecialRegular];
    return isResult;
}

/// 字符中是否包含汉字
- (BOOL)isContantCNNSString
{
    BOOL isResult = NO;
    NSInteger count = self.length;
    for (NSInteger i = 0; i < count; i++)
    {
        int charCN = [self characterAtIndex:i];
        if (charCN > 0x4e00 && charCN < 0x9fff)
        {
            isResult = YES;
            break;
        }
    }
    return isResult;
}

/// 判断当前字符是中文字符，还是英文字符
- (BOOL)isENCharacter
{
    unichar uc = [self characterAtIndex:0];
    return (isascii(uc) ? YES : NO);
}

/// 是否是指定的字符类型
- (BOOL)isContantWithText:(NSString *)text
{
    BOOL isResult = YES;
    if ([NSString isValidNSString:self] && 0 != text.length)
    {
        NSInteger length = self.length;
        for (NSInteger index = 0; index < length; index++)
        {
            NSString *subText = [self substringWithRange:NSMakeRange(index, 1)];
            NSRange range = [text rangeOfString:subText];
            if (range.location == NSNotFound)
            {
                isResult = NO;
                break;
            }
        }
    }
    return isResult;
}

/// 是否包含子字符串
- (BOOL)isContantSubtext:(NSString *)text
{
    BOOL isResult = NO;
    if ([NSString isValidNSString:self] && [NSString isValidNSString:text])
    {
        NSRange range = [self rangeOfString:text];
        if (range.location != NSNotFound)
        {
            isResult = YES;
        }
    }
    return isResult;
}

/// 是否包含指定的字符
- (BOOL)isContantSomeCharacters:(NSString *)characters
{
    BOOL isResult = NO;
    if ([NSString isValidNSString:self] && 0 != characters.length)
    {
        NSInteger length = self.length;
        for (NSInteger index = 0; index < length; index++)
        {
            NSString *subText = [self substringWithRange:NSMakeRange(index, 1)];
            NSRange range = [characters rangeOfString:subText];
            if (range.location != NSNotFound)
            {
                isResult = YES;
                break;
            }
        }
    }
    return isResult;
}

#pragma mark - 表情输入限制

/// 包含表情字符
- (BOOL)isEmojiString
{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
             }
         }
         else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3)
             {
                 isEomji = YES;
             }
         }
         else
         {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b)
             {
                 isEomji = YES;
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 isEomji = YES;
             }
             else if (0x2934 <= hs && hs <= 0x2935)
             {
                 isEomji = YES;
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 isEomji = YES;
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a )
             {
                 isEomji = YES;
             }
         }
     }];
    
    return isEomji;
}

#pragma mark - 字符类型判断

- (void)regularWithText:(NSString *)text limitedHandle:(void (^)(NSInteger index))regular
{
    [self regularWithText:text limited:YES handle:regular];
}

- (void)regularWithText:(NSString *)text allowedHandle:(void (^)(NSInteger index))regular
{
    [self regularWithText:text limited:NO handle:regular];
}

- (void)regularWithText:(NSString *)text limited:(BOOL)islimit handle:(void (^)(NSInteger index))regular
{
    if ([NSString isValidNSString:self] && 0 != text.length)
    {
        for (NSInteger index = 0; index < self.length; index++)
        {
            NSString *subSelf = [self substringWithRange:NSMakeRange(index, 1)];
            NSRange range = [text rangeOfString:subSelf];
            if (islimit)
            {
                // 限制不能输入指定字符
                if (range.location != NSNotFound)
                {
                    if (regular)
                    {
                        regular(index);
                    }
                    break;
                }
            }
            else
            {
                // 限制只能输入指定字符
                if (range.location == NSNotFound)
                {
                    if (regular)
                    {
                        regular(index);
                    }
                    break;
                }
            }
        }
    }
}

@end
