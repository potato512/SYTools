//
//  SYAutoSizeCGRect.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/6/11.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#ifndef zhangshaoyu_AutoSizeCGRect_h
#define zhangshaoyu_AutoSizeCGRect_h

////////////////////////////////////////////////////////////////////////////////////

/*
 各版本尺寸
 1 iPhone4      640*960   320*480 2倍
 2 iPhone4S     640*960   320*480 2倍
 3 iPhone5      640*1136  320*568 2倍
 4 iPhone5S     640*1136  320*568 2倍
 5 iPhone5C     640*1136  320*568 2倍
 6 iPhone6      750*1334  375*667 2倍
 7 iPhone6 Plus 1242*2208 414*736 3倍
 
 各版本比例
 iPhone5，    autoSizeScaleX=1，autoSizeScaleY=1；
 iPhone6，    autoSizeScaleX=1.171875，autoSizeScaleY=1.17429577；
 iPhone6Plus，autoSizeScaleX=1.29375， autoSizeScaleY=1.295774；
*/

#define SYIS_IPAD_AutoSize             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SYIS_IPHONE_AutoSize           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SYIS_RETINA_AutoSize           ([[UIScreen mainScreen] scale] >= 2.0)

#define SYSCREEN_WIDTH_AutoSize        ([[UIScreen mainScreen] bounds].size.width)
#define SYSCREEN_HEIGHT_AutoSize       ([[UIScreen mainScreen] bounds].size.height)
#define SYSCREEN_MAX_LENGTH_AutoSize   (MAX(SYSCREEN_WIDTH_AutoSize, SYSCREEN_HEIGHT_AutoSize))
#define SYSCREEN_MIN_LENGTH_AutoSize   (MIN(SYSCREEN_WIDTH_AutoSize, SYSCREEN_HEIGHT_AutoSize))

#define SYIS_IPHONE_4_OR_LESS_AutoSize (SYIS_IPHONE_AutoSize && SYSCREEN_MAX_LENGTH_AutoSize < 568.0)
#define SYIS_IPHONE_5_AutoSize         (SYIS_IPHONE_AutoSize && SYSCREEN_MAX_LENGTH_AutoSize == 568.0)
#define SYIS_IPHONE_6_AutoSize         (SYIS_IPHONE_AutoSize && SYSCREEN_MAX_LENGTH_AutoSize == 667.0)
#define SYIS_IPHONE_6P_AutoSize        (SYIS_IPHONE_AutoSize && SYSCREEN_MAX_LENGTH_AutoSize == 736.0)

////////////////////////////////////////////////////////////////////////////////////

#define SYAutoSizeDelegate_AutoSize     ([[UIApplication sharedApplication] delegate])
#define SYAutoSizeScreenWidth_AutoSize  ([[UIScreen mainScreen] bounds].size.width)
#define SYAutoSizeScreenHeight_AutoSize ([[UIScreen mainScreen] bounds].size.height)

#define SYAutoSizeScaleX_AutoSize ((SYAutoSizeScreenHeight_AutoSize > 480.0) ? (SYAutoSizeScreenWidth_AutoSize / 320.0) : 1.0)
#define SYAutoSizeScaleY_AutoSize ((SYAutoSizeScreenHeight_AutoSize > 480.0) ? (SYAutoSizeScreenHeight_AutoSize / 568.0) : 1.0)

#define SYAutoSizeScalesX (SYAutoSizeScaleX_AutoSize)
#define SYAutoSizeScalesY (SYAutoSizeScaleY_AutoSize)

////////////////////////////////////////////////////////////////////////////////////

CG_INLINE CGFloat
SYAutoSizeCGRectGetMinX(CGRect rect)
{
    CGFloat x = rect.origin.x * SYAutoSizeScaleX_AutoSize;
    return x;
}

CG_INLINE CGFloat
SYAutoSizeCGRectGetMinY(CGRect rect)
{
    CGFloat y = rect.origin.y * SYAutoSizeScaleX_AutoSize;
    return y;
}

CG_INLINE CGFloat
SYAutoSizeCGRectGetWidth(CGRect rect)
{
    CGFloat width = rect.size.width * SYAutoSizeScaleX_AutoSize;
    return width;
}

CG_INLINE CGFloat
SYAutoSizeCGRectGetHeight(CGRect rect)
{
    CGFloat height = rect.size.height * SYAutoSizeScaleX_AutoSize;
    return height;
}

CG_INLINE CGPoint
SYAutoSizeCGPointMake(CGFloat x, CGFloat y)
{
    CGPoint point;
    point.x = x * SYAutoSizeScaleX_AutoSize;
    point.y = y * SYAutoSizeScaleY_AutoSize;
    
    return point;
}

CG_INLINE CGSize
SYAutoSizeCGSizeMake(CGFloat width, CGFloat height)
{
    CGSize size;
    size.width = width * SYAutoSizeScaleX_AutoSize;
    size.height = height * SYAutoSizeScaleY_AutoSize;
    
    return size;
}

CG_INLINE CGRect
SYAutoSizeCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x * SYAutoSizeScaleX_AutoSize;
    rect.origin.y = y * SYAutoSizeScaleY_AutoSize;
    rect.size.width = width * SYAutoSizeScaleX_AutoSize;
    rect.size.height = height * SYAutoSizeScaleY_AutoSize;
    
    return rect;
}

////////////////////////////////////////////////////////////////////////////////////

// 常用

CG_INLINE CGRect
SYAutoSizeDidCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = width * SYAutoSizeScaleX_AutoSize;
    rect.size.height = height * SYAutoSizeScaleY_AutoSize;
    
    return rect;
}

CG_INLINE CGRect
SYAutoSizeShouldCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height, BOOL autoW, BOOL autoH)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = (autoW ? (width * SYAutoSizeScaleX_AutoSize) : width);
    rect.size.height = (autoH ? (height * SYAutoSizeScaleY_AutoSize) : height);
    
    return rect;
}

CG_INLINE CGFloat
SYAutoSizeGetHeight(CGFloat height)
{
    CGFloat autoHeight = height * SYAutoSizeScaleY_AutoSize;
    return autoHeight;
}

CG_INLINE CGFloat
SYAutoSizeGetWidth(CGFloat width)
{
    CGFloat autoWidth = width * SYAutoSizeScaleX_AutoSize;
    return autoWidth;
}

////////////////////////////////////////////////////////////////////////////////////

#endif
