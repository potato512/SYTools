//
//  SYImageBrowserHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/8.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SYImageBrowseView.h"
#import "NSObject+SYCategory.h"

// 使用SDWebImage
//#import "UIImageView+WebCache.h"

@interface SYImageBrowseHelper : NSObject

/// 获取图片类型
+ (SYImageType)getSYImageType:(id)object;

@end
