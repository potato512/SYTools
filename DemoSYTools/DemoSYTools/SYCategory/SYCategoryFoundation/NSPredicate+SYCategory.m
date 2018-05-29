//
//  NSPredicate+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/3/2.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//  

#import "NSPredicate+SYCategory.h"

@implementation NSPredicate (SYCategory)

#pragma mark - 数值比较运算

/**
 比较运算符
 =、==：判断两个表达式是否相等，如：@"SELF = 123"，或@"SELF == 123"
 >=，=>：判断左边表达式的值是否大于或等于右边表达式的值，如：@"SELF >= 123"
 <=，=<：判断左边表达式的值是否小于或等于右边表达式的值，如：@"SELF <= 123"
 >：判断左边表达式的值是否大于右边表达式的值，如：@"SELF > 123"
 <：判断左边表达式的值是否小于右边表达式的值，如：@"SELF < 123"
 !=、<>：判断两个表达式是否不相等，如：@"SELF != 123"
 BETWEEN：BETWEEN表达式必须满足表达式 BETWEEN {下限，上限}的格式，要求该表达式必须大于或等于下限，并小于或等于上限，如：@"SELF BETWEEN {100, 200}"
 */

+ (BOOL)predicateNumber:(NSNumber *)number filter:(NSString *)filter
{
    if (!number || ![number isKindOfClass:[NSNumber class]] || !filter || filter.length <= 0)
    {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
    BOOL result = [predicate evaluateWithObject:number];
    return result;
}

#pragma mark - 逻辑运算

/**
 AND、&&：逻辑与，要求两个表达式的值都为YES时，结果才为YES，如：@"SELF > 123 && SELE < 200"
 OR、||：逻辑或，要求其中一个表达式为YES时，结果就是YES，如：@"SELF > 123 OR SELE < 200"
 NOT、 !：逻辑非，对原有的表达式取反，如：@"SELF NOT 123"
 */

#pragma mark - 字符串比较运算
/**
 BEGINSWITH：检查某个字符串是否以指定的字符串开头（如判断字符串是否以a开头：BEGINSWITH 'a'）
 ENDSWITH：检查某个字符串是否以指定的字符串结尾
 CONTAINS：检查某个字符串是否包含指定的字符串
 LIKE：检查某个字符串是否匹配指定的字符串模板。其之后可以跟?代表一个字符和*代表任意多个字符两个通配符。比如"name LIKE '*ac*'"，这表示name的值中包含ac则返回YES；"name LIKE '?ac*'"，表示name的第2、3个字符为ac时返回YES。
 MATCHES：检查某个字符串是否匹配指定的正则表达式。虽然正则表达式的执行效率是最低的，但其功能是最强大的，也是我们最常用的。
 
 说明：字符串比较都是区分大小写和重音符号的。如：café和cafe是不一样的，Cafe和cafe也是不一样的。如果希望字符串比较运算不区分大小写和重音符号，请在这些运算符后使用[c]，[d]选项。其中[c]是不区分大小写，[d]是不区分重音符号，其写在字符串比较运算符之后，比如：name LIKE[cd] 'cafe'，那么不论name是cafe、Cafe还是café上面的表达式都会返回YES。
 
 .	匹配除换行符以外的任意字符
 \w	匹配字母或数字或下划线或汉字
 \s	匹配任意的空白符
 \d	匹配数字
 \b	匹配单词的开始或结束
 ^	匹配字符串的开始
 $	匹配字符串的结束
 
 *	重复零次或更多次
 +	重复一次或更多次
 ?	重复零次或一次
 {n}	重复n次
 {n,}	重复n次或更多次
 {n,m}	重复n到m次
 
 注：字符串比较都是区分大小写和重音符号的。如：café和cafe是不一样的，Cafe和cafe也是不一样的。如果希望字符串比较运算不区分大小写和重音符号，请在这些运算符后使用[c]，[d]选项。其中[c]是不区分大小写，[d]是不区分重音符号，其写在字符串比较运算符之后，比如：name LIKE[cd] 'cafe'，那么不论name是cafe、Cafe还是café上面的表达式都会返回YES。
 
 MATCHES匹配，正则表达式使用特殊字符说明：
 1、"\"将下一个字符标记为一个特殊字符，或一个原义字符，或一个向后引用，或一个八进制转义符。例如，"\\n"匹配"\n"，"\n"匹配换行符，"\\"匹配"\"，"\("则匹配"("；
 2、"^"匹配输入字符串的开始位置。如果设置了RegExp对象的Multiline属性，"^"也匹配"\n"或"\r"之后的位置；
 3、"$"匹配输入字符串的结束位置。如果设置了RegExp对象的Multiline属性，"$"也匹配"\n"或"\r"之前的位置；
 4、"*"匹配前面的子表达式零次或多次(大于等于0次)。例如，"zo*"能匹配"z"、"zo"、"zoo"。"*"等价于"{0,}"；
 5、"+"匹配前面的子表达式一次或多次(大于等于1次）。例如，"zo+"能匹配"zo"、"zoo"，但不能匹配"z"。"+"等价于"{1,}"；
 6、"?"匹配前面的子表达式零次或一次。例如，"do(es)?"可以匹配"do"或"does"中的"do"。"?"等价于"{0,1}"；
 7、"{n}"n是一个非负整数。匹配确定的n次。例如，"o{2}"不能匹配"Bob"中的"o"，但是能匹配"food"中的两个"o"；
 8、"{n,}"n是一个非负整数。至少匹配n次。例如，"o{2,}"不能匹配"Bob"中的"o"，但能匹配"foooood"中的所有o，"o{1,}"等价于"o+"，"o{0,}"则等价于"o*"；
 9、"{n,m}"m和n均为非负整数，其中n<=m。最少匹配n次且最多匹配m次。例如，"o{1,3}"将匹配"fooooood"中的前三个o，"o{0,1}"等价于"o?"，请注意在逗号和两个数之间不能有空格；
 10、"?"当该字符紧跟在任何一个其他限制符"*,+,?，{n}，{n,}，{n,m}"后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串"oooo"，"o+?"将匹配单个"o"，而“o+”将匹配所有“o”；
 11、"."点能匹配除"\r\n"之外的任何单个字符。要匹配包括"\r\n"在内的任何字符，请使用像"[\s\S]"的模式；
 12、"x|y"匹配x或y。例如，“z|food”能匹配“z”或“food”。“(z|f)ood”则匹配“zood”或“food”。
 13、"[xyz]"字符集合。匹配所包含的任意一个字符。例如，“[abc]”可以匹配“plain”中的“a”。
 14、"[^xyz]"负值字符集合。匹配未包含的任意字符。例如，“[^abc]”可以匹配“plain”中的“plin”。
 15、"[a-z]"字符范围。匹配指定范围内的任意字符。例如，“[a-z]”可以匹配“a”到“z”范围内的任意小写字母字符。
 注意:只有连字符在字符组内部时,并且出现在两个字符之间时,才能表示字符的范围; 如果出字符组的开头,则只能表示连字符本身.
 16、"[^a-z]"负值字符范围。匹配任何不在指定范围内的任意字符。例如，“[^a-z]”可以匹配任何不在“a”到“z”范围内的任意字符。
 17、"\b"匹配一个单词边界，也就是指单词和空格间的位置。例如，“er\b”可以匹配“never”中的“er”，但不能匹配“verb”中的“er”。
 18、"\B"匹配非单词边界。“er\B”能匹配“verb”中的“er”，但不能匹配“never”中的“er”。
 19、\cx"匹配由x指明的控制字符。例如，\cM匹配一个Control-M或回车符。x的值必须为A-Z或a-z之一。否则，将c视为一个原义的“c”字符。
 20、"\d"匹配一个数字字符。等价于[0-9]。
 21、"\D"匹配一个非数字字符。等价于[^0-9]。
 22、"\f"匹配一个换页符。等价于\x0c和\cL。
 23、"\n"匹配一个换行符。等价于\x0a和\cJ。
 24、"\r"匹配一个回车符。等价于\x0d和\cM。
 25、"\s"匹配任何空白字符，包括空格、制表符、换页符等等。等价于[ \f\n\r\t\v]。
 26、"\S"匹配任何非空白字符。等价于[^ \f\n\r\t\v]。
 27、"\t"匹配一个制表符。等价于\x09和\cI。
 28、"\v"匹配一个垂直制表符。等价于\x0b和\cK。
 29、"\w"匹配包括下划线的任何单词字符。等价于"[A-Za-z0-9_]"。
 30、"\W"匹配任何非单词字符。等价于"[^A-Za-z0-9_]"。
 31、"\xn"匹配n，其中n为十六进制转义值。十六进制转义值必须为确定的两个数字长。例如，“\x41”匹配“A”。“\x041”则等价于“\x04&1”。正则表达式中可以使用ASCII编码。
 32、"\num"匹配num，其中num是一个正整数。对所获取的匹配的引用。例如，“(.)\1”匹配两个连续的相同字符。
 33、"\n"标识一个八进制转义值或一个向后引用。如果\n之前至少n个获取的子表达式，则n为向后引用。否则，如果n为八进制数字（0-7），则n为一个八进制转义值。
 34、"\nm"标识一个八进制转义值或一个向后引用。如果\nm之前至少有nm个获得子表达式，则nm为向后引用。如果\nm之前至少有n个获取，则n为一个后跟文字m的向后引用。如果前面的条件都不满足，若n和m均为八进制数字（0-7），则\nm将匹配八进制转义值nm。
 35、"\nml"如果n为八进制数字（0-7），且m和l均为八进制数字（0-7），则匹配八进制转义值nml。
 36、"\un"匹配n，其中n是一个用四个十六进制数字表示的Unicode字符。例如，\u00A9匹配版权符号（&copy;）。
 
 \< \>	匹配词（word）的开始（\<）和结束（\>）。例如正则表达式\<the\>能够匹配字符串"for the wise"中的"the"，但是不能匹配字符串"otherwise"中的"the"。注意：这个元字符不是所有的软件都支持的。
 \( \)	将 \( 和 \) 之间的表达式定义为“组”（group），并且将匹配这个表达式的字符保存到一个临时区域（一个正则表达式中最多可以保存9个），它们可以用 \1 到\9 的符号来引用。
 |	将两个匹配条件进行逻辑“或”（Or）运算。例如正则表达式(him|her) 匹配"it belongs to him"和"it belongs to her"，但是不能匹配"it belongs to them."。注意：这个元字符不是所有的软件都支持的。
 +	匹配1或多个正好在它之前的那个字符。例如正则表达式9+匹配9、99、999等。注意：这个元字符不是所有的软件都支持的。
 ?	匹配0或1个正好在它之前的那个字符。注意：这个元字符不是所有的软件都支持的。
 {i} {i,j}	匹配指定数目的字符，这些字符是在它之前的表达式定义的。例如正则表达式A[0-9]{3} 能够匹配字符"A"后面跟着正好3个数字字符的串，例如A123、A348等，但是不匹配A1234。而正则表达式[0-9]{4,6} 匹配连续的任意4个、5个或者6个数字
 
 (pattern)
 匹配pattern并获取这一匹配。所获取的匹配可以从产生的Matches集合得到，在VBScript中使用SubMatches集合，在JScript中则使用$0…$9属性。要匹配圆括号字符，请使用“\(”或“\)”。
 
 (?:pattern)
 匹配pattern但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。这在使用或字符“(|)”来组合一个模式的各个部分是很有用。例如“industr(?:y|ies)”就是一个比“industry|industries”更简略的表达式。
 
 (?=pattern)
 正向肯定预查，在任何匹配pattern的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如，“Windows(?=95|98|NT|2000)”能匹配“Windows2000”中的“Windows”，但不能匹配“Windows3.1”中的“Windows”。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。
 
 (?!pattern)
 正向否定预查，在任何不匹配pattern的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如“Windows(?!95|98|NT|2000)”能匹配“Windows3.1”中的“Windows”，但不能匹配“Windows2000”中的“Windows”。
 
 (?<=pattern)
 反向肯定预查，与正向肯定预查类似，只是方向相反。例如，“(?<=95|98|NT|2000)Windows”能匹配“2000Windows”中的“Windows”，但不能匹配“3.1Windows”中的“Windows”。
 
 (?<!pattern)
 反向否定预查，与正向否定预查类似，只是方向相反。例如“(?<!95|98|NT|2000)Windows”能匹配“3.1Windows”中的“Windows”，但不能匹配“2000Windows”中的“Windows”。
 */


#pragma mark - 集合运算

/**
 ANY、SOME：集合中任意一个元素满足条件，就返回YES，如：
 ALL：集合中所有元素都满足条件，才返回YES，如：
 NONE：集合中没有任何元素满足条件就返回YES，如:NONE person.age < 18，表示person集合中所有元素的age>=18时，才返回YES。
 IN：等价于SQL语句中的IN运算符，只有当左边表达式或值出现在右边的集合中才会返回YES，如：
 */

#pragma mark - 直接量

/**
 在谓词表达式中可以使用如下直接量：
 FALSE、NO：代表逻辑假
 TRUE、YES：代表逻辑真
 NULL、NIL：代表空值
 SELF：代表正在被判断的对象自身
 "string"或'string'：代表字符串
 数组：和c中的写法相同，如：{'one', 'two', 'three'}。
 数值：包括证书、小数和科学计数法表示的形式
 十六进制数：0x开头的数字
 八进制：0o开头的数字
 二进制：0b开头的数字
 */

#pragma mark - 字符过滤

/// 使用MATCH过滤字符
+ (BOOL)predicateText:(NSString *)text filter:(NSString *)filter
{
    if (!text || text.length <= 0 || !filter || filter.length <= 0)
    {
        return NO;
    }
    
    NSAssert(text != nil, @"text must be not nil");
    NSAssert(filter != nil, @"filter must be not nil");
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
    BOOL result = [predicate evaluateWithObject:text];
    return result;
}

/// 邮箱验证
+ (BOOL)predicateEmail:(NSString *)email
{
    NSAssert(email != nil, @"email must be not nil");
    
    NSString *filter = @"SELF MATCHES '[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}'";
    BOOL result = [self predicateText:email filter:filter];
    return result;
}

/// 数字验证
+ (BOOL)predicateNumber:(NSString *)number
{
    NSAssert(number != nil, @"number must be not nil");
    
    NSString *filter = @"SELF MATCHES '[0-9]'";
    BOOL result = [self predicateText:number filter:filter];
    return result;
}

/// 不区分大小写字母验证
+ (BOOL)predicateLetter:(NSString *)letter
{
    NSAssert(letter != nil, @"letter must be not nil");
    
    NSString *filter = @"SELF MATCHES '[a-zA-Z]'";
    BOOL result = [self predicateText:letter filter:filter];
    return result;
}

/// 手机号码验证
+ (BOOL)predicatePhoneNum:(NSString *)phoneNum
{
    NSAssert(phoneNum != nil, @"phoneNum must be not nil");
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *filter = @"SELF MATCHES '^1(34[0-8]|(3[5-9]|5[017-9]|8[278]))[0-9]{8}$|^1(3[0-2]|5[256]|8[56])[0-9]{8}$|^1(33|53|8[09])[0-9]{8}|^1(349)[0-9]{7}'";
    BOOL result = [self predicateText:phoneNum filter:filter];
    return result;
}

/// 移动手机号码验证
+ (BOOL)predicatePhoneNumMobile:(NSString *)phoneNumMobile
{
    NSAssert(phoneNumMobile != nil, @"phoneNumMobile must be not nil");
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString *filter = @"SELF MATCHES '^1(34[0-8]|(3[5-9]|5[017-9]|8[278]))[0-9]{8}$'";
    BOOL result = [self predicateText:phoneNumMobile filter:filter];
    return result;
}

/// 联通手机号码验证
+ (BOOL)predicatePhoneNumUnicom:(NSString *)phoneNumUnicom
{
    NSAssert(phoneNumUnicom != nil, @"phoneNumUnicom must be not nil");
    
    /**
     * 手机号码
     * 联通：130,131,132,152,155,156,185,186
     */
    NSString *filter = @"SELF MATCHES '^1(3[0-2]|5[256]|8[56])[0-9]{8}$'";
    BOOL result = [self predicateText:phoneNumUnicom filter:filter];
    return result;
}

/// 电信手机号码验证
+ (BOOL)predicatePhoneNumTelecom:(NSString *)phoneNumTelecom
{
    NSAssert(phoneNumTelecom != nil, @"phoneNumTelecom must be not nil");
    
    /**
     * 手机号码
     * 电信：133,1349,153,180,189
     */
    NSString *filter = @"SELF MATCHES '^1(33|53|8[09])[0-9]{8}|^1(349)[0-9]{7}'";
    BOOL result = [self predicateText:phoneNumTelecom filter:filter];
    return result;
}

/// 固定号码验证
+ (BOOL)predicateTelNum:(NSString *)telNum
{
    NSAssert(telNum != nil, @"telNum must be not nil");
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029,0755,0753,……
     * 号码：七位或八位
     */
    NSString *filter = @"SELF MATCHES '^0(10|2[05789])[1-9]{8}|^0[0-9]{3}[0-9]{7,8}'";
    BOOL result = [self predicateText:telNum filter:filter];
    return result;
}

#pragma mark - 数据过滤

+ (NSArray *)predicateArray:(NSArray *)array filter:(NSString *)filter
{
    if (!array || 0 >= array.count || !filter || 0 >= filter.length)
    {
        return @[];
    }
    
    NSAssert(array != nil, @"array must be not nil");
    NSAssert(filter != nil, @"filter must be not nil");

    NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
    NSArray *results = [array filteredArrayUsingPredicate:predicate];
    return results;
}


@end
