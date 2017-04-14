//
//  SYCommon_Image.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用图片

#ifndef Common_Image_h
#define Common_Image_h

/********************** image ****************************/

#pragma mark - 设置图片

/// 读取本地图片
#define kImageFromBundleNameType(fileName,fileType) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:fileType]])

/// 定义UIImage对象
#define kImageFromBundleName(name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]])

/// 获取图片，根据图片名称
#define kImageWithName(name) [UIImage imageNamed:name]

/// 获取图片，根据图片url
#define kImageWithURL(name) [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:URLWithString(name)]]

/// 拉伸图片边框处理
#define kImageUIEdgeWithName(name) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

/// 拉伸图片边框处理
#define kImageWithUIEdge(name, UIEdgeInsets) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsets resizingMode:UIImageResizingModeStretch]

/// 获取图片，根据颜色设置
#define kImageWithColor(color) [UIImage imageWithColor:color size:CGSizeMake(1.0, 1.0)]

#pragma mark - 常用图片

/// 默认图标-广告栏
#define kImageDefaultADIcon     kImageWithName(@"AD_default")

/// 默认图标
#define kImageDefault           kImageWithName(@"defaultImage")

/// 默认图标-头像
#define kImageHeaderDefault     kImageWithName(@"headerDefaultIcon")

/// 默认图标-商品图片
#define kImageProductDefault    kImageWithName(@"goodsImage_default")

/// 默认图标-背景图标
#define kImageBackgroundDefault kImageWithName(@"bgImageDefault")


/// cell透明背景色
//#define kImage_cellClear [[UIImage imageWithColor:kColorClear size:CGSizeMake(1.0, 1.0)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 60, 0, 80) resizingMode:UIImageResizingModeStretch]

/// cell未选择时背景色
//#define kImage_cellNormal [[UIImage imageWithColor:kColorWhite size:CGSizeMake(1.0, 1.0)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 60, 0, 80) resizingMode:UIImageResizingModeStretch]

/// cell选择时背景色
//#define kImage_cellSelected [[UIImage imageWithColor:UIColorHex(0xfcf8cd) size:CGSizeMake(1.0, 1.0)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 60, 0, 80) resizingMode:UIImageResizingModeStretch]

/// 按钮透明颜色
//#define kImageButtonNormal kImageWithColor(kColorClear)

/// 按钮点击颜色
//#define kImageButtonHighlight kImageWithColor(UIColorHex_Alpha(0x000000, 0.3))

/********************** image ****************************/

#endif /* Common_Image_h */
