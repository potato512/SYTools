//
//  iToast+SYToast.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-4-26.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "iToast.h"

@interface iToast (SYToast)

/// 顶端显示提示iToast
+ (void)alertWithTitle:(NSString *)title;

/// 居中显示提示iToast
+ (void)alertWithTitleCenter:(NSString *)title;

/// 底端显示提示iToast
+ (void)alertWithTitleBottom:(NSString *)title;

/// 隐藏iToast
+ (void)hiddenIToast;

@end
