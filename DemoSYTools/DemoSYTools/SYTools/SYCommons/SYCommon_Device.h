//
//  SYCommon_Device.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用设备，或系统宏定义

#ifndef Common_Device_h
#define Common_Device_h

/********************** device ****************************/

#pragma mark - APP操作

/// 获取当前app delegate
#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// 打开浏览器
#define OpenUrlInExplorer(urlString) {NSURL *url = [[NSURL alloc] initWithString:urlString];[[UIApplication sharedApplication] openURL:url];}

/// 拨打电话
#define PhoneTelprompt(numString) {NSURL *mobileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", numString]];[[UIApplication sharedApplication] openURL:mobileUrl];}

/// 拨打电话
#define PhoneTel(numString) {NSURL *mobileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", numString]];[[UIApplication sharedApplication] openURL:mobileUrl];}

#pragma mark - APP信息

/// 当前app信息
#define GetAppInfo [[NSBundle mainBundle] infoDictionary]

/// 当前app版本号
#define GetAppCurrentVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

/// 当前app build版本号
#define GetAppCurrentBuildVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"])

/// 当前app标识
#define GetAppIdentifier ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"])

/// 当前app名称
#define GetAppName ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"])

/// 当前app bundle名称
#define GetAppBundleName ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"])

/// 获取当前语言
#define GetAppLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/// 获取当前设备平台系统版本号
#define GetAppCurrentPlatformVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"DTPlatformVersion"])

/// 获取当前app支持的最小系统版本号
#define GetAppMiniSystemVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"MinimumOSVersion"])

#pragma mark - 设备尺寸

/// 全屏宽度
#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width

/// 全屏高度，不含状态栏高度
#define kScreenHeight       [UIScreen mainScreen].applicationFrame.size.height

/// 全屏高度，含状态栏高度
#define kAllHeight          ([UIScreen mainScreen].applicationFrame.size.height + 20.0)

/// 视图控制器高度，不含导航栏控制器高度
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)

/// tabbar切换视图控制器高度
static CGFloat const kTabbarHeight       = 49.0;

/// 搜索视图高度
static CGFloat const kSearchBarHeight    = 45.0;

/// 状态栏高度
static CGFloat const kStatusBarHeight    = 20.0;

/// 导航栏高度
static CGFloat const kNavigationHeight   = 44.0;

#pragma mark - 设备类型

///// 判断是真机还是模拟器
//#if TARGET_OS_IPHONE
///// iPhone Device
//#endif
//#if TARGET_IPHONE_SIMULATOR
///// iPhone Simulator
//#endif


/// iPhone设备
#define isIPHONE    ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

/// iPad设备
#define isIPAD      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

/// iPhone5设备
//#define iSiPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.0, 1136.0), [[UIScreen mainScreen] currentMode].size) : NO)
/// iPhone4设备
#define isIPHONE4  (isIPHONE && (MAX(([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height))) < 568.0)

/// iPhone5设备
#define isIPHONE5  (isIPHONE && (MAX(([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height))) == 568.0)

/// iPhone6设备
#define isIPHONE6  (isIPHONE && (MAX(([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height))) == 667.0)

/// iPhone6Plus设备
#define isIPHONE6P (isIPHONE && (MAX(([[UIScreen mainScreen] bounds].size.width), ([[UIScreen mainScreen] bounds].size.height))) == 736.0)


/// 获取设备系统号
#define GetSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/// IOS6及以上的系统
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

/// IOS7及以上的系统
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

/// IOS8及以上的系统
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

/// IOS9及以上的系统
#define isIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

/// 设备类型-模拟器（模拟器，或真机）
#define isSimulatorDevice ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformName"] isEqualToString:@"iphonesimulator"])

/// 设备类型-真机（模拟器，或真机）
#define isIphoneosDevice ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformName"] isEqualToString:@"iphoneos"])

/// 设备序列号
#define GetDeviceIdentifier [[UIDevice currentDevice] identifierForVendor].UUIDString

/// 设备别名：用户定义的名称
#define GetDeviceName [[UIDevice currentDevice] name]

/// 设备名称
#define GetDeviceSystemName [[UIDevice currentDevice] systemName]

/// 设备型号（iPhone，或iPad）
#define GetDeviceModel [[UIDevice currentDevice] model]

/// 设备地方型号（国际化区域名称）
#define GetDeviceLocalModel [[UIDevice currentDevice] localizedModel]

/// 设备电池电量
#define GetDeviceBatteryLevel [[UIDevice currentDevice] batteryLevel]

/// 设备电池状态
#define GetDeviceBatteryState [[UIDevice currentDevice] batteryState]


#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight

/********************** device ****************************/

#endif /* Common_Device_h */
