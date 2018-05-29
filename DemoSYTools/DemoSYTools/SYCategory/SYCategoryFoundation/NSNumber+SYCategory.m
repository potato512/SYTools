//
//  NSNumber+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSNumber+SYCategory.h"

@implementation NSNumber (SYCategory)

#pragma mark - 字符串转数值

/// string转double
+ (double)doubleWithString:(NSString *)string
{
    return string.doubleValue;
}

/// string转float
+ (float)floatWithString:(NSString *)string
{
    return string.floatValue;
}

/// string转int
+ (int)intWithString:(NSString *)string
{
    return string.intValue;
}

#pragma mark - 位数保留

/// 保留n位小数
+ (double)keepDecimalsDoubleValue:(double)number decimal:(int)decimalNumber
{
    return (trunc(number * pow(10, decimalNumber)) / pow(10, decimalNumber));
}

/// 保留2位小数
+ (double)keepTwoDecimalsDoubleValue:(double)number
{
//    return round(number * 100.0) / 100.0;
    return [[self class] keepDecimalsDoubleValue:number decimal:2];
}

#pragma mark - 随机数

/// 获取一个随机整数，范围在[from,to）
+ (int)randomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

#pragma mark - 大小写转换

/// 阿拉伯数字转罗马大写
- (NSString *)numberConvertedUpperRoman
{
    NSInteger number = self.integerValue;
    switch (number)
    {
        case 1: return @"一"; break;
        case 2: return @"二"; break;
        case 3: return @"三"; break;
        case 4: return @"四"; break;
        case 5: return @"五"; break;
        case 6: return @"六"; break;
        case 7: return @"七"; break;
        case 8: return @"八"; break;
        case 9: return @"九"; break;
        default: break;
    }
    return nil;
}

/// 阿拉伯数字转中文大写
- (NSString *)numberConvertedCNCapital
{
    NSInteger number = self.integerValue;
    switch (number)
    {
        case 0: return @"零"; break;
        case 1: return @"壹"; break;
        case 2: return @"贰"; break;
        case 3: return @"叁"; break;
        case 4: return @"肆"; break;
        case 5: return @"伍"; break;
        case 6: return @"陆"; break;
        case 7: return @"柒"; break;
        case 8: return @"捌"; break;
        case 9: return @"玖"; break;
        default: break;
    }
    return nil;
}

#pragma mark - 数值比较

/// 某个数的整数和小数
+ (NSArray *)numberIntegerAndDecimal:(float)number
{
    float quo;
    NSMutableArray *array = [NSMutableArray new];
    float result = modff(number, &quo);
    [array addObject:@(quo)];
    [array addObject:@(result)];
    return array;
}

/// 大于等于N的最小整数
+ (float)numberCeil:(float)number
{
    return ceilf(number);
}

/// 小于等于N的最大整数
+ (float)numberFloor:(float)number
{
    return floorf(number);
}

/// 最接近N的整数
+ (float)numberNear:(float)number
{
    return nearbyintf(number);
}

/// 四舍五入后的整数
+ (float)numberRound:(float)number
{
    return roundf(number);
}

/// 商和余数
+ (NSArray *)numberAuotientMod:(float)number numbr:(float)dividendNumber
{
    int quo;
    NSMutableArray *array = [NSMutableArray new];
    float result = remquof(number, dividendNumber, &quo);
    [array addObject:@(quo)];
    [array addObject:@(result)];
    return array;
}

/// 余数
+ (float)numberMod:(float)number number:(float)dividendNumber
{
    return fmodf(number, dividendNumber);
}

///// 两数中的小数
//// 返回x和y中小的数字： z = min(x,y)
//NSLog(@"返回x和y中小的数字： z = min(x,y) = %f", fminf(11.22, 22.33));
//NSLog(@"返回x和y中小的数字： z = min(x,y) = %f", fmin(11.22, 22.33));
//NSLog(@"返回x和y中小的数字： z = min(x,y) = %Lf", fminl(11.22, 22.33));
//
///// 两数中的大数
//NSLog(@"返回x和y中大的数字： z = max(x,y) = %f", fmaxf(11.22, 22.33));
//NSLog(@"返回x和y中大的数字： z = max(x,y) = %f", fmax(11.22, 22.33));
//NSLog(@"返回x和y中大的数字： z = max(x,y) = %Lf", fmaxl(11.22, 22.33));
//
///// 三数中的小数
//
///// 三数中的大数


@end
