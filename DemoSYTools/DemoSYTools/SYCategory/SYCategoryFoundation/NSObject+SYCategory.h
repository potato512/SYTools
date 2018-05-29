//
//  NSObject+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  图片对象类型（图片名称、图片url地址、图片image）
 */
typedef NS_ENUM(NSInteger, SYImageType)
{
    /**
     *  图片对象类型-图片名称
     */
    SYImageTypeName = 1,
    /**
     *  图片对象类型-图片url地址
     */
    SYImageTypeUrl = 2,
    /**
     *  图片对象类型-图片image
     */
    SYImageTypeImage = 3
};

@interface NSObject (SYCategory)

/**
 *  计算字符文本的宽高
 *
 *  @param text 字符文本
 *  @param font 字体大小
 *  @param size 设置计算宽高范围
 *
 *  @return CGSize
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font constrainedSize:(CGSize)size;

/// 计算字符高度（根据字符，字体，及指定宽度）
- (CGFloat)heightWithText:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/// 单行文字宽度
- (CGFloat)widthWithText:(NSString *)string font:(UIFont *)font;

/// 结束编辑
- (void)editingDone;

/**
 *  判断图片类型（图片名称，或图片url地址，或图片image）
 *
 *  @return 图片类型
 */
- (SYImageType)imageTypeWithImage;

@end
