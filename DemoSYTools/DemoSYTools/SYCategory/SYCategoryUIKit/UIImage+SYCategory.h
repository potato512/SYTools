//
//  UIImage+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SaveToPhotosAlbumComplete)(BOOL isSuccess);

@interface UIImage (SYCategory)

@property (nonatomic, copy) SaveToPhotosAlbumComplete saveToPhotosAlbumComplete;

#pragma mark - 图片

/// 生成指定颜色和大小的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/// 生成指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 获取图片，根据图片url-缓存功能（如：url = http://.../xxx.jpg）
+ (void)imageWithUrl:(NSString *)url complete:(void ((^)(UIImage *image)))complete;


/// 读取本地图片（如：name = xxx.png）
+ (UIImage *)imageWithBundleName:(NSString *)name;

/// 读取本地图片（如：xxx.png，name = xxx，type = png）
+ (UIImage *)imageWithBundleName:(NSString *)name type:(NSString *)type;

#pragma mark - 图片拉升

/// 图片拉升
- (void)resizableImage;

/// 拉伸图片-指定UIEdgeInsets
- (void)resizableImage:(UIEdgeInsets)edge;

/// 拉伸图片-指定UIEdgeInsets，指定UIImageResizingMode
- (void)resizableImage:(UIEdgeInsets)edge mode:(UIImageResizingMode)mode;

#pragma mark - 图片压缩

/// 改变图片大小
- (UIImage *)scaleImageWithSize:(float)size;

/**
 *  图片调整尺寸大小
 *
 *  @param size 调整后尺寸大小
 *
 *  @return 调整后 image 对象
 */
- (UIImage *)scaleImageWithSizeDimension:(CGSize)size;

/**
 *  图片调整文件大小
 *
 *  @param fileSize 调整后文件大小
 *c
 *  @return 调整后 image 对象
 */
- (UIImage *)compressionImageWithSize:(CGFloat)fileSize;

#pragma mark - 图片裁剪

/// 生成圆角图片（默认圆角大小为8.0）
- (UIImage *)roundedImageWithRadius:(CGFloat)radius;

/// 方形图片
- (UIImage *)squareImageWithSize:(CGSize)newSize;

/// 从图片中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImageWithImage:(UIImage *)image size:(CGRect)rect;

/**
 *  全屏截图
 *
 *  @return 截图后 image 对象
 */
+ (UIImage *)mainScreenImage;

/// 屏幕截图（指定视图）
+ (UIImage *)screenImageWithView:(UIView *)view;
/// 从视图中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImageWithView:(UIView *)view size:(CGRect)rect;

#pragma mark - 图片保存

/// 保存图片到指定路径，是否成功回调
- (void)saveImageWithPath:(NSString *)filePath complete:(void (^)(BOOL isSuccess))complete;

/// 保存图片到手机相册，是否成功回调
- (void)saveImageToPhotosAlbum:(void (^)(BOOL isSuccess))complete;

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;




@end
