//
//  UIImagePickerController+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/29.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 保存图片到相册情况，成功或失败
typedef NS_ENUM(NSInteger, SavePhotoStatus)
{
    /// 保存成功
    SavePhotoSuccess = 1,
    
    /// 保存失败
    SavePhotoFail
};

@interface UIImagePickerController (SYCategory) <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 *  获取相册图片，或拍照（无样式设置）
 *
 *  @param sourceType 图片类型
 *  @param target     响应对象视图控制器
 *  @param complete   获取图片回调
 *  @param isSave     是否保存拍照的图片到相册
 *  @param saveStart  开始保存图片（是保存时才有效）
 *  @param saveFinish 保存图片状态（成功，或失败）
 */
+ (void)pickerImageWithType:(UIImagePickerControllerSourceType)sourceType target:(id)target complete:(void (^)(UIImage *image))complete photosAlbum:(BOOL)isSave saveStart:(void (^)(void))saveStart saveFinish:(void (^)(SavePhotoStatus status))saveFinish;

/**
 *  获取相册图片，或拍照（样式设置/编辑）
 *
 *  @param sourceType 图片类型
 *  @param allowEdit  图片编辑
 *  @param bgColor    导航栏背景颜色
 *  @param textColor  导航栏字体颜色
 *  @param textFont   导航栏字体大小
 *  @param target     响应对象视图控制器
 *  @param complete   获取图片回调
 *  @param isSave     是否保存拍照的图片到相册
 *  @param saveStart  开始保存图片（是保存时才有效）
 *  @param saveFinish 保存图片状态（成功，或失败）
 */
+ (void)pickerImageWithType:(UIImagePickerControllerSourceType)sourceType edit:(BOOL)allowEdit styleBgColor:(UIColor *)bgColor styleTextColor:(UIColor *)textColor styleTextFont:(UIFont *)textFont target:(id)target complete:(void (^)(UIImage *image))complete photosAlbum:(BOOL)isSave saveStart:(void (^)(void))saveStart saveFinish:(void (^)(SavePhotoStatus status))saveFinish;

@end
