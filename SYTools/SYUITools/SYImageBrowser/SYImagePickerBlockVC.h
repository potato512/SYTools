//
//  ImagePickerBlockVC.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/4/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  功能描述：封装公用UIImagePickerController，避免代码冗余

#import <UIKit/UIKit.h>


// 个人中心item类型
typedef NS_ENUM(NSInteger, PhotoStauts){
    PhotoStautsSuccess = 22222,    // 成功
    PhotoStautsFailed              // 失败
};

///// 保存图片到相册情况，成功或失败
//typedef enum
//{
//    /// 保存成功
//    SavePhotoStatusSuccess = 1,
//    
//    /// 保存失败
//    SavePhotoStatusFail
//    
//}SavePhotoStatus;

@interface SYImagePickerBlockVC : UIImagePickerController

/// 设置属性源
@property (nonatomic, assign) UIImagePickerControllerSourceType pickerSourceType;

/// 根据数据源异常处理
- (BOOL)isValidWithPickerSourceType;

/// 设置代码块回调函数（拍照模式时才保存到相册）
- (void)getPickerImage:(void (^)(UIImage *image))succeed error:(void (^)(void))error PhotosAlbum:(BOOL)save saveStart:(void (^)(void))saveStart saveFinish:(void (^)(PhotoStauts status))saveFinish;

@end

/*
 使用示例
 步骤1 导入头文件
 #import "ImagePickerBlockVC.h"
 
 步骤2 定义属性
 @property (nonatomic, strong) ImagePickerBlockVC *imagePickerVC;
 
 步骤3 实例化
 self.imagePickerVC = [[ImagePickerBlockVC alloc] init];
 
 步骤4 设置数据源
 self.imagePickerVC.pickerSourceType = UIImagePickerControllerSourceTypeCamera;
 
 步骤5 异常判断
 if ([self.imagePickerVC isValidWithPickerSourceType])
 {
    [self presentViewController:self.imagePickerVC animated:YES completion:NULL];
 
    [self.imagePickerVC getPickerImage:^(UIImage *image) {
        NSLog(@"get image success");
    } error:^{
        NSLog(@"get image error");
    } PhotosAlbum:isSave saveStart:^{
        NSLog(@"save image start");
    } saveFinish:^(SavePhotoStatus status) {
        NSLog(@"save image %@", (SavePhotoSuccess == status ? @"成功" : @"失败"));
    }];
 }
 */