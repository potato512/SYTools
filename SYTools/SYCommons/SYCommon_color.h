//
//  SYCommon_color.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用颜色

#import "SYCommon_Image.h"

#ifndef zhangshaoyu_Common_color_h
#define zhangshaoyu_Common_color_h

/********************** Color ****************************/

#pragma mark - 颜色设置方法

/// 设置随机颜色
#define UIColorRandom [UIColor colorWithRed:(arc4random_uniform(256) / 255.0) green:(arc4random_uniform(256) / 255.0) blue:(arc4random_uniform(256) / 255.0) alpha:1.0]

/// 设置颜色（RGB：0.0~255.0） 示例：UIColorRGB(100, 100, 100)
#define UIColorRGB(R,G,B) [UIColor colorWithRed:(R / 255.0) green:(G / 255.0) blue:(B / 255.0) alpha:1.0]

/// 设置颜色与透明度（RGB：0.0~255.0；alpha：0.0~1.0） 示例：UIColorRGB_Alpha(100.0, 100.0, 20.0, 1.0)
#define UIColorRGB_Alpha(R,G,B,al) [UIColor colorWithRed:(R / 255.0) green:(G / 255.0) blue:(B / 255.0) alpha:al]

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:(((float)((rgbValue & 0xFF0000) >> 16)) / 255.0) green:(((float)((rgbValue & 0xFF00) >> 8)) / 255.0) blue:(((float)(rgbValue & 0xFF)) / 255.0) alpha:1.0]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue,al) [UIColor colorWithRed:(((float)((rgbValue & 0xFF0000) >> 16)) / 255.0) green:(((float)((rgbValue & 0xFF00) >> 8)) / 255.0) blue:(((float)(rgbValue & 0xFF)) / 255.0) alpha:al]

#pragma mark - 导航栏控制器颜色设置

/// 导航栏控制器背景颜色
#define kColorNavBgroundWhite UIColorHex(0xffffff)
#define kColorNavBgroundRed UIColorHex(0xe84515)

#pragma mark - 视图控制器颜色设置

// 视图控制器背景色
#define kColorBackground UIColorHex(0xf0f0f0)

#pragma mark - 线条颜色设置

/// 灰色—如列表cell分割线颜色
#define kColorline UIColorHex(0xd6d7dc)

/// 灰色-边框线颜色
#define kColorBorderline UIColorHex(0xd6d7dc)

#pragma mark - 按钮点击状态颜色

/// 按钮背景透明颜色
#define kColorButtonNormal kImageWithColor(kColorClear)
/// 按钮背景点击颜色
#define kColorButtonHighlight kImageWithColor(UIColorHex_Alpha(0x000000, 0.3))
/// 按钮背景不可点击颜色
#define kColorButtonDisabled UIColorHex(0xcccccc)

/// 按钮标题点击颜色
#define kColorButtonTitleHighlight UIColorHex_Alpha(0x000000, 0.3)

#pragma mark - 字体颜色设置

/// 透明色
#define kColorClear [UIColor clearColor]

/// 浅粉色
#define kColorLightPink UIColorHex(0xFFB6C1)

/// 粉色
#define kColorPink UIColorHex(0xFFC0CB)

/// 猩红
#define kColorCrimson UIColorHex(0xDC143C)

/// 脸红的淡紫色
#define kColorLavenderBlush UIColorHex(0xFFF0F5)

/// 苍白的紫罗兰红色
#define kColorPaleVioletRed UIColorHex(0xDB7093)

/// 热情的粉红
#define kColorHotPink UIColorHex(0xFF69B4)

/// 深粉色
#define kColorDeepPink UIColorHex(0xFF1493)

/// 适中的紫罗兰红色
#define kColorMediumVioletRed UIColorHex(0xC71585)

/// 兰花的紫色
#define kColorOrchid UIColorHex(0xDA70D6)

/// 蓟
#define kColorThistle UIColorHex(0xD8BFD8)

/// 李子
#define kColorplum UIColorHex(0xDDA0DD)

/// 紫罗兰
#define kColorViolet UIColorHex(0xEE82EE)

/// 洋红
#define kColorMagenta UIColorHex(0xFF00FF)

/// 灯笼海棠(紫红色)
#define kColorFuchsia UIColorHex(0xFF00FF)

/// 深洋红色
#define kColorDarkMagenta UIColorHex(0x8B008B)

/// 紫色
#define kColorPurple UIColorHex(0x800080)

/// 适中的兰花紫
#define kColorMediumOrchid UIColorHex(0xBA55D3)

/// 深紫罗兰色
#define kColorDarkVoilet UIColorHex(0x9400D3)

/// 深兰花紫
#define kColorDarkOrchid UIColorHex(0x9932CC)

/// 靛青
#define kColorIndigo UIColorHex(0x4B0082)

/// 深紫罗兰的蓝色
#define kColorBlueViolet UIColorHex(0x8A2BE2)

/// 适中的紫色
#define kColorMediumPurple UIColorHex(0x9370DB)

/// 适中的板岩暗蓝灰色
#define kColorMediumSlateBlue UIColorHex(0x7B68EE)

/// 板岩暗蓝灰色
#define kColorSlateBlue UIColorHex(0x6A5ACD)

/// 深岩暗蓝灰色
#define kColorDarkSlateBlue UIColorHex(0x483D8B)

/// 熏衣草花的淡紫色
#define kColorLavender UIColorHex(0xE6E6FA)

/// 幽灵的白色
#define kColorGhostWhite UIColorHex(0xF8F8FF)

/// 纯蓝
#define kColorBlue UIColorHex(0x0000FF)

/// 适中的蓝色
#define kColorMediumBlue UIColorHex(0x0000CD)

/// 午夜的蓝色
#define kColorMidnightBlue UIColorHex(0x191970)

/// 深蓝色
#define kColorDarkBlue UIColorHex(0x00008B)

/// 海军蓝
#define kColorNavy UIColorHex(0x000080)

/// 皇家蓝
#define kColorRoyalBlue UIColorHex(0x4169E1)

/// 矢车菊的蓝色
#define kColorCornflowerBlue UIColorHex(0x6495ED)

/// 淡钢蓝
#define kColorLightSteelBlue UIColorHex(0xB0C4DE)

/// 浅石板灰
#define kColorLightSlateGray UIColorHex(0x778899)

/// 石板灰
#define kColorSlateGray UIColorHex(0x708090)

/// 道奇蓝
#define kColorDoderBlue UIColorHex(0x1E90FF)

/// 爱丽丝蓝
#define kColorAliceBlue UIColorHex(0xF0F8FF)

/// 钢蓝
#define kColorSteelBlue UIColorHex(0x4682B4)

/// 淡蓝色
#define kColorLightSkyBlue UIColorHex(0x87CEFA)

/// 天蓝色
#define kColorSkyBlue UIColorHex(0x87CEEB)

/// 深天蓝
#define kColorDeepSkyBlue UIColorHex(0x00BFFF)

/// 淡蓝
#define kColorLightBLue UIColorHex(0xADD8E6)

/// 火药蓝
#define kColorPowDerBlue UIColorHex(0xB0E0E6)

/// 军校蓝
#define kColorCadetBlue UIColorHex(0x5F9EA0)

/// 蔚蓝色
#define kColorAzure UIColorHex(0xF0FFFF)

/// 淡青色
#define kColorLightCyan UIColorHex(0xE1FFFF)

/// 苍白的绿宝石
#define kColorPaleTurquoise UIColorHex(0xAFEEEE)

/// 青色
#define kColorCyan UIColorHex(0x00FFFF)

/// 水绿色
#define kColorAqua UIColorHex(0x00FFFF)

/// 深绿宝石
#define kColorDarkTurquoise UIColorHex(0x00CED1)

/// 深石板灰
#define kColorDarkSlateGray UIColorHex(0x2F4F4F)

/// 深青色
#define kColorDarkCyan UIColorHex(0x008B8B)

/// 水鸭色
#define kColorTeal UIColorHex(0x008080)

/// 适中的绿宝石
#define kColorMediumTurquoise UIColorHex(0x48D1CC)

/// 浅海洋绿
#define kColorLightSeaGreen UIColorHex(0x20B2AA)

/// 绿宝石
#define kColorTurquoise UIColorHex(0x40E0D0)

/// 绿玉\碧绿色
#define kColorAuqamarin UIColorHex(0x7FFFAA)

/// 适中的碧绿色
#define kColorMediumAquamarine UIColorHex(0x00FA9A)

/// 适中的春天的绿色
#define kColorMediumSpringGreen UIColorHex(0x00FF7F)

/// 薄荷奶油
#define kColorMintCream UIColorHex(0xF5FFFA)

/// 春天的绿色
#define kColorSpringGreen UIColorHex(0x3CB371)

/// 海洋绿
#define kColorSeaGreen UIColorHex(0x2E8B57)

/// 蜂蜜
#define kColorHoneydew UIColorHex(0xF0FFF0)

/// 淡绿色
#define kColorLightGreen UIColorHex(0x90EE90)

/// 苍白的绿色
#define kColorPaleGreen UIColorHex(0x98FB98)

/// 深海洋绿
#define kColorDarkSeaGreen UIColorHex(0x8FBC8F)

/// 酸橙绿
#define kColorLimeGreen UIColorHex(0x32CD32)

/// 酸橙色
#define kColorLime UIColorHex(0x00FF00)

/// 森林绿
#define kColorForestGreen UIColorHex(0x228B22)

/// 纯绿
#define kColorGreen UIColorHex(0x008000)

/// 深绿色
#define kColorDarkGreen UIColorHex(0x006400)

/// 查特酒绿
#define kColorChartreuse UIColorHex(0x7FFF00)

/// 草坪绿
#define kColorLawnGreen UIColorHex(0x7CFC00)

/// 绿黄色
#define kColorGreenYellow UIColorHex(0xADFF2F)

/// 橄榄土褐色
#define kColorOliveDrab UIColorHex(0x556B2F)

/// 米色(浅褐色)
#define kColorBeige UIColorHex(0xF5F5DC)

/// 浅秋麒麟黄
#define kColorLightGoldenrodYellow UIColorHex(0xFAFAD2)

/// 象牙
#define kColorIvory UIColorHex(0xFFFFF0)

/// 浅黄色
#define kColorLightYellow UIColorHex(0xFFFFE0)

/// 纯黄
#define kColorYellow UIColorHex(0xFFFF00)

/// 橄榄
#define kColorOlive UIColorHex(0x808000)

/// 深卡其布
#define kColorDarkKhaki UIColorHex(0xBDB76B)

/// 柠檬薄纱
#define kColorLemonChiffon UIColorHex(0xFFFACD)

/// 灰秋麒麟
#define kColorPaleGodenrod UIColorHex(0xEEE8AA)

/// 卡其布
#define kColorKhaki UIColorHex(0xF0E68C)

/// 金
#define kColorGold UIColorHex(0xFFD700)

/// 玉米色
#define kColorCornislk UIColorHex(0xFFF8DC)

/// 秋麒麟
#define kColorGoldEnrod UIColorHex(0xDAA520)

/// 花的白色
#define kColorFloralWhite UIColorHex(0xFFFAF0)

/// 老饰带
#define kColorOldLace UIColorHex(0xFDF5E6)

/// 小麦色
#define kColorWheat UIColorHex(0xF5DEB3)

/// 鹿皮鞋
#define kColorMoccasin UIColorHex(0xFFE4B5)

/// 橙色
#define kColorOrange UIColorHex(0xFFA500)

/// 番木瓜
#define kColorPapayaWhip UIColorHex(0xFFEFD5)

/// 漂白的杏仁
#define kColorBlanchedAlmond UIColorHex(0xFFEBCD)

/// 纳瓦霍白
#define kColorNavajoWhite UIColorHex(0xFFDEAD)

/// 古代的白色
#define kColorAntiqueWhite UIColorHex(0xFAEBD7)

/// 晒黑
#define kColorTan UIColorHex(0xD2B48C)

/// 结实的树
#define kColorBrulyWood UIColorHex(0xDEB887)

/// (浓汤)乳脂,番茄等
#define kColorBisque UIColorHex(0xFFE4C4)

/// 深橙色
#define kColorDarkOrange UIColorHex(0xFF8C00)

/// 亚麻布
#define kColorLinen UIColorHex(0xFAF0E6)

/// 秘鲁
#define kColorPeru UIColorHex(0xCD853F)

/// 桃色
#define kColorPeachPuff UIColorHex(0xFFDAB9)

/// 沙棕色
#define kColorSandyBrown UIColorHex(0xF4A460)

/// 巧克力
#define kColorChocolate UIColorHex(0xD2691E)

/// 马鞍棕色
#define kColorSaddleBrown UIColorHex(0x8B4513)

/// 海贝壳
#define kColorSeaShell UIColorHex(0xFFF5EE)

/// 黄土赭色
#define kColorSienna UIColorHex(0xA0522D)

/// 浅鲜肉(鲑鱼)色
#define kColorLightSalmon UIColorHex(0xFFA07A)

/// 珊瑚
#define kColorCoral UIColorHex(0xFF7F50)

/// 橙红色
#define kColorOrangeRed UIColorHex(0xFF4500)

/// 深鲜肉(鲑鱼)色
#define kColorDarkSalmon UIColorHex(0xE9967A)

/// 番茄
#define kColorTomato UIColorHex(0xFF6347)

/// 薄雾玫瑰
#define kColorMistyRose UIColorHex(0xFFE4E1)

/// 鲜肉(鲑鱼)色
#define kColorSalmon UIColorHex(0xFA8072)

/// 雪
#define kColorSnow UIColorHex(0xFFFAFA)

/// 淡珊瑚色
#define kColorLightCoral UIColorHex(0xF08080)

/// 玫瑰棕色
#define kColorRosyBrown UIColorHex(0xBC8F8F)

/// 印度红
#define kColorIndianRed UIColorHex(0xCD5C5C)

/// 纯红
#define kColorRed UIColorHex(0xFF0000)

/// 棕色
#define kColorBrown UIColorHex(0xA52A2A)

/// 耐火砖
#define kColorFireBrick UIColorHex(0xB22222)

/// 深红色
#define kColorDarkRed UIColorHex(0x8B0000)

/// 栗色
#define kColorMaroon UIColorHex(0x800000)

/// 纯白
#define kColorWhite UIColorHex(0xFFFFFF)

/// 白烟
#define kColorWhiteSmoke UIColorHex(0xF5F5F5)

/// 亮灰色
#define kColorGainsboro UIColorHex(0xDCDCDC)

/// 浅灰色
#define kColorLightGrey UIColorHex(0xD3D3D3)

/// 银白色
#define kColorSilver UIColorHex(0xC0C0C0)

/// 深灰色
#define kColorDarkGray UIColorHex(0xA9A9A9)

/// 灰色
#define kColorGray UIColorHex(0x808080)

/// 暗淡的灰色
#define kColorDimGray UIColorHex(0x696969)

/// 纯黑
#define kColorBlack UIColorHex(0x000000)


/********************** Color ****************************/

#endif
