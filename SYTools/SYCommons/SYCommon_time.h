//
//  SYCommon_time.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用时间格式

#ifndef zhangshaoyu_Common_time_h
#define zhangshaoyu_Common_time_h

/********************** time ****************************/

#pragma mark - 时间格式

/// yyyy-MM-dd HH:mm:ss
static NSString *const kDateFormatDefault             = @"yyyy-MM-dd HH:mm:ss";

/// yy-MM-dd HH:mm
static NSString *const kDateFormat_yyMdHm             = @"yy-MM-dd HH:mm";

/// yyyy-MM-dd HH:mm
static NSString *const kDateFormat_yyyyMdHm           = @"yyyy-MM-dd HH:mm";

/// yyyy-MM-dd
static NSString *const kDateFormat_yMd                = @"yyyy-MM-dd";

/// MM-dd HH:mm:ss
static NSString *const kDateFormat_MdHms              = @"MM-dd HH:mm:ss";

/// MM-dd HH:mm
static NSString *const kDateFormat_MdHm               = @"MM-dd HH:mm";

/// HH:mm:ss
static NSString *const kDateFormat_Hms                = @"HH:mm:ss";

/// HH:mm
static NSString *const kDateFormat_Hm                 = @"HH:mm";

/// MM-dd
static NSString *const kDateFormat_Md                 = @"MM-dd";

/// yy-MM-dd
static NSString *const kDateFormat_yyMd               = @"yy-MM-dd";

/// yyyyMMdd
static NSString *const kDateFormat_YYMMdd             = @"yyyyMMdd";

/// yyyyMMddHHmmss
static NSString *const kDateFormat_yyyyMdHms          = @"yyyyMMddHHmmss";

/// yyyy-MM-dd HH:mm:ss.SSS
static NSString *const kDateFormat_yyyyMdHmsS         = @"yyyy-MM-dd HH:mm:ss.SSS";

/// yyyyMMddHHmmssSSS
static NSString *const kDateFormat_yyyyMMddHHmmssSSS  = @"yyyyMMddHHmmssSSS";

/// yyyy/MM/dd
static NSString *const kDateFormat_yMdWithSlash       = @"yyyy/MM/dd";

/// yyyy-MM
static NSString *const kDateFormat_yM                 = @"yyyy-MM";

/// yyyy.MM.dd
static NSString *const kDateFormat_yMdChangeSeparator = @"yyyy.MM.dd";

/// yyyy年MM月dd日 HH:mm
static NSString *const kDateFormat_yyyyMdHmCN         = @"yyyy年MM月dd日 HH:mm";

/********************** time ****************************/

#endif
