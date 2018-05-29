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
 01 iPhone4      3.5 640*960   320*480 @2x
 02 iPhone4S     3.5 640*960   320*480 @2x
 03 iPhone5      4.0 640*1136  320*568 @2x
 04 iPhone5S     4.0 640*1136  320*568 @2x
 05 iPhone5C     4.0 640*1136  320*568 @2x
 06 iPhone6      4.7 750*1334  375*667 @2x
 07 iPhone6Plus  5.5 1242*2208 414*736 @3x
 08 iPhone7      4.7 750*1334  375*667 @2x
 09 iPhone7Plus  5.5 1242*2208 414*736 @3x
 10 iPhone8      4.7 750*1334  375*667 @2x
 11 iPhone8Plus  5.5 1242*2208 414*736 @3x
 12 iPhoneX      5.8 1125*2436 375*812 @3x
 
 各版本比例
 iPhone5，    autoSizeScaleX=1，autoSizeScaleY=1；
 iPhone6，    autoSizeScaleX=1.171875，autoSizeScaleY=1.17429577；
 iPhone6Plus，autoSizeScaleX=1.29375， autoSizeScaleY=1.295774；
 iPhoneX，    autoSizeScaleX=1.7578125， autoSizeScaleY=2.144366197183099；
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
#define SYIS_IPHONE_X_AutoSize         (SYIS_IPHONE_AutoSize && SYSCREEN_MAX_LENGTH_AutoSize == 812.0)

////////////////////////////////////////////////////////////////////////////////////

#define SYAutoSizeDelegate_AutoSize     ([[UIApplication sharedApplication] delegate])
#define SYAutoSizeScreenWidth_AutoSize  ([[UIScreen mainScreen] bounds].size.width)
#define SYAutoSizeScreenHeight_AutoSize ([[UIScreen mainScreen] bounds].size.height)

#define SYAutoSizeScaleX_AutoSize ((SYAutoSizeScreenHeight_AutoSize > 480.0) ? (SYAutoSizeScreenWidth_AutoSize / 320.0) : 1.0)
#define SYAutoSizeScaleY_AutoSize ((SYAutoSizeScreenHeight_AutoSize > 480.0) ? ((SYAutoSizeScreenHeight_AutoSize >= 812.0) ? (SYAutoSizeScreenHeight_AutoSize / 667.0) : (SYAutoSizeScreenHeight_AutoSize / 568.0)) : 1.0)

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

#define kScreenHeightiPhoneX [UIScreen mainScreen].bounds.size.height
#define kScreenWidthiPhoneX  [UIScreen mainScreen].bounds.size.width
#define isIPoneX (kScreenHeightiPhoneX == 812.0f ? YES : NO)

///
#define kHeightCoefficientiPhoneX (isIPoneX ? 667.0f / 667.0f : kScreenHeightiPhoneX / 667.0f)

///
#define kHeightStatusSafeArea (isIPoneX ? 44.0f : 20.0f)
///
#define kHeightNavigationSafeArea (44.0f)
///
#define kHeightStatusNavigationSafeArea (kHeightStatusSafeArea + kHeightNavigationSafeArea)
///
#define kHeightBottomSafeArea (isIPoneX ? 34.0f : 0.0f)

CG_INLINE CGFloat
SYGetTop(CGFloat y, BOOL hiddenNav)
{
    CGFloat result = (hiddenNav ? (kHeightStatusSafeArea + y) : y);
    return result;
}

CG_INLINE CGFloat
SYGetBottom(CGFloat y, BOOL hiddenNav)
{
    CGFloat result = (hiddenNav ? (y - kHeightBottomSafeArea) : y);
    return result;
}

CG_INLINE CGFloat
SYGetHeightTop(CGFloat height, BOOL hiddenNav)
{
    CGFloat result = (hiddenNav ? (kHeightStatusSafeArea + height) : height);
    return result;
}

CG_INLINE CGFloat
SYGetHeightBottom(CGFloat height, BOOL hiddenTap)
{
    CGFloat result = (hiddenTap ? (kHeightBottomSafeArea + height) : height);
    return result;
}

/// iPhoneX适配
CG_INLINE CGRect
SYCGRectMakeSafeArea(CGFloat x, CGFloat y, CGFloat width, CGFloat height, BOOL hiddenNav, BOOL hiddenTab, BOOL isTop)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = width;
    rect.size.height = height;
    if (isTop)
    {
        // 顶端时
        rect.size.height = (hiddenNav ? (kHeightStatusSafeArea + height) : height);
    }
    else
    {
        // 底部时
        rect.origin.y = (hiddenTab ? (y - kHeightBottomSafeArea) : y);
        rect.size.height = (hiddenTab ? (kHeightBottomSafeArea + height) : height);
    }
    return rect;
}

////////////////////////////////////////////////////////////////////////////////////

#endif
