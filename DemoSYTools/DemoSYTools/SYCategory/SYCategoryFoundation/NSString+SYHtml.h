//
//  NSString+SYHtml.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/2/7.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYHtml)

/// html包含图片
- (BOOL)htmlContantImage;

/// html中图片大小自适应屏幕大小
- (NSString *)htmlStringImageAutoSize;

/// 修改html中图片大小的js代码
- (NSString *)htmlStringJSImageSizeWidth:(float)width;

/// 修改html的文字大小
- (NSString *)htmlStringFontSize:(int)fontsize;

/// 过滤html中的图片数组
- (NSArray *)htmlStringFilterImages;

@end
