//
//  SYImageBrowserHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/8.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYImageBrowseHelper.h"

@implementation SYImageBrowseHelper

/// 获取图片类型
+ (SYImageType)getSYImageType:(id)object
{
    return [object imageTypeWithImage];
}

@end
