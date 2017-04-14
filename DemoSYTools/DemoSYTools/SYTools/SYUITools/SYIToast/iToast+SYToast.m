//
//  iToast+SYToast.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-4-26.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "iToast+SYToast.h"

@implementation iToast (SYToast)

// 实例化iToast
+ (void)alertWithTitle:(NSString *)title
{
    if ([NSString isNullNSString:title])
    {
        return ;
    }

    [[iToast shareIToast] setMessageFont:[UIFont systemFontOfSize:SYAutoSizeGetHeight(14.0)]];
    [[iToast shareIToast] showText:title postion:iToastPositionTop];
}

+ (void)alertWithTitleCenter:(NSString *)title
{
    if ([NSString isNullNSString:title])
    {
        return ;
    }
    
    [[iToast shareIToast] setMessageFont:[UIFont systemFontOfSize:SYAutoSizeGetHeight(14.0)]];
    [[iToast shareIToast] showText:title postion:iToastPositionCenter];
}

+ (void)alertWithTitleBottom:(NSString *)title
{
    if ([NSString isNullNSString:title])
    {
        return ;
    }
    
    [[iToast shareIToast] setMessageFont:[UIFont systemFontOfSize:SYAutoSizeGetHeight(14.0)]];
    [[iToast shareIToast] showText:title postion:iToastPositionBottom];
}

// 隐藏iToast
+ (void)hiddenIToast
{
    [[iToast shareIToast] hidden];
}

@end
