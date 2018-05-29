//
//  SYCommon_font.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用字体

#ifndef zhangshaoyu_Common_font_h
#define zhangshaoyu_Common_font_h

/*********************** Font ***************************/

/// 设置字体-未适配
#define kFontWithSize(size) [UIFont systemFontOfSize:size]
#define kFontBoldWithSize(size) [UIFont boldSystemFontOfSize:size]

/// 设置字体-适配
#define kAutoFontWithSize(size) [UIFont systemFontOfSize:SYAutoSizeGetWidth(size)]
#define kAutoFontBoldWithSize(size) [UIFont boldSystemFontOfSize:SYAutoSizeGetWidth(size)]

/// 是否适配
static BOOL const isAutoFont = 0;

#pragma mark - 大小-细体

/// 7号字体
#define kFontSize7 (isAutoFont ? kAutoFontWithSize(7.0) : kFontWithSize(7.0))

/// 8号字体
#define kFontSize8 (isAutoFont ? kAutoFontWithSize(8.0) : kFontWithSize(8.0))

/// 9号字体
#define kFontSize9 (isAutoFont ? kAutoFontWithSize(9.0) : kFontWithSize(9.0))

/// 10号字体
#define kFontSize10 (isAutoFont ? kAutoFontWithSize(10.0) : kFontWithSize(10.0))

/// 11号字体
#define kFontSize11 (isAutoFont ? kAutoFontWithSize(11.0) : kFontWithSize(11.0))

/// 12号字体
#define kFontSize12 (isAutoFont ? kAutoFontWithSize(12.0) : kFontWithSize(12.0))

/// 13号字体
#define kFontSize13 (isAutoFont ? kAutoFontWithSize(13.0) : kFontWithSize(13.0))

/// 14号字体
#define kFontSize14 (isAutoFont ? kAutoFontWithSize(14.0) : kFontWithSize(14.0))

/// 15号字体
#define kFontSize15 (isAutoFont ? kAutoFontWithSize(15.0) : kFontWithSize(15.0))

/// 16号字体
#define kFontSize16 (isAutoFont ? kAutoFontWithSize(16.0) : kFontWithSize(16.0))

/// 17号字体
#define kFontSize17 (isAutoFont ? kAutoFontWithSize(17.0) : kFontWithSize(17.0))

/// 18号字体
#define kFontSize18 (isAutoFont ? kAutoFontWithSize(18.0) : kFontWithSize(18.0))

/// 19号字体
#define kFontSize19 (isAutoFont ? kAutoFontWithSize(19.0) : kFontWithSize(19.0))

/// 20号字体
#define kFontSize20 (isAutoFont ? kAutoFontWithSize(20.0) : kFontWithSize(20.0))

/// 21号字体
#define kFontSize21 (isAutoFont ? kAutoFontWithSize(21.0) : kFontWithSize(21.0))

/// 22号字体
#define kFontSize22 (isAutoFont ? kAutoFontWithSize(22.0) : kFontWithSize(22.0))

/// 24号字体
#define kFontSize24 (isAutoFont ? kAutoFontWithSize(24.0) : kFontWithSize(24.0))

/// 25号字体
#define kFontSize25 (isAutoFont ? kAutoFontWithSize(25.0) : kFontWithSize(25.0))

/// 30号字体
#define kFontSize30 (isAutoFont ? kAutoFontWithSize(30.0) : kFontWithSize(30.0))

/// 40号字体
#define kFontSize40 (isAutoFont ? kAutoFontWithSize(40.0) : kFontWithSize(40.0))

/// 50号字体
#define kFontSize50 (isAutoFont ? kAutoFontWithSize(50.0) : kFontWithSize(50.0))

/// 60号字体
#define kFontSize60 (isAutoFont ? kAutoFontWithSize(60.0) : kFontWithSize(60.0))

#pragma mark - 大小-粗体

/// 7号粗字体
#define kFontSizeBold7 (isAutoFont ? kAutoFontBoldWithSize(7.0) : kFontBoldWithSize(7.0))

/// 8号粗字体
#define kFontSizeBold8 (isAutoFont ? kAutoFontBoldWithSize(8.0) : kFontBoldWithSize(8.0))

/// 9号粗字体
#define kFontSizeBold9 (isAutoFont ? kAutoFontBoldWithSize(9.0) : kFontBoldWithSize(9.0))

/// 10号粗字体
#define kFontSizeBold10 (isAutoFont ? kAutoFontBoldWithSize(10.0) : kFontBoldWithSize(10.0))

/// 11号粗字体
#define kFontSizeBold11 (isAutoFont ? kAutoFontBoldWithSize(11.0) : kFontBoldWithSize(11.0))

/// 12号粗字体
#define kFontSizeBold12 (isAutoFont ? kAutoFontBoldWithSize(12.0) : kFontBoldWithSize(12.0))

/// 13号粗字体
#define kFontSizeBold13 (isAutoFont ? kAutoFontBoldWithSize(13.0) : kFontBoldWithSize(13.0))

/// 14号粗字体
#define kFontSizeBold14 (isAutoFont ? kAutoFontBoldWithSize(14.0) : kFontBoldWithSize(14.0))

/// 15号粗字体
#define kFontSizeBold15 (isAutoFont ? kAutoFontBoldWithSize(15.0) : kFontBoldWithSize(15.0))

/// 16号粗字体
#define kFontSizeBold16 (isAutoFont ? kAutoFontBoldWithSize(16.0) : kFontBoldWithSize(16.0))

/// 17号粗字体
#define kFontSizeBold17 (isAutoFont ? kAutoFontBoldWithSize(17.0) : kFontBoldWithSize(17.0))

/// 18号粗字体
#define kFontSizeBold18 (isAutoFont ? kAutoFontBoldWithSize(18.0) : kFontBoldWithSize(18.0))

/// 20号字粗体
#define kFontSizeBold20 (isAutoFont ? kAutoFontBoldWithSize(20.0) : kFontBoldWithSize(20.0))

/// 21号字粗体
#define kFontSizeBold21 (isAutoFont ? kAutoFontBoldWithSize(21.0) : kFontBoldWithSize(21.0))

/*********************** Font ***************************/

#endif
