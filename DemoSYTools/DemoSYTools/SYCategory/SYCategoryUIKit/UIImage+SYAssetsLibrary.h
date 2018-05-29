//
//  UIImage+SYAssetsLibrary.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/7.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYAssetsLibrary)

#pragma mark - 获取相册图片

/**
 *  获取用户设置的相册图片数组
 *
 *  @param count   图片数量
 *  @param latest  是否最新的图片
 *  @param start   开始获取相册图片回调
 *  @param success 成功获取相册图片回调
 *  @param error   失败回调
 */
+ (void)imagesFromAssetsLibraryWithNum:(NSInteger)count
                                latest:(BOOL)latest
                                 start:(void(^)(void))start
                               success:(void(^)(NSArray *images))success
                                 error:(void(^)(void))error;

@end
