//
//  UIImage+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImage+SYCategory.h"
#import <objc/runtime.h>

@implementation UIImage (SYCategory)

#pragma mark - setter/getter

- (void)setSaveToPhotosAlbumComplete:(SaveToPhotosAlbumComplete)saveToPhotosAlbumComplete
{
    if (saveToPhotosAlbumComplete)
    {
        objc_setAssociatedObject(self, @selector(saveToPhotosAlbumComplete), saveToPhotosAlbumComplete, OBJC_ASSOCIATION_COPY);
    }
}

- (SaveToPhotosAlbumComplete)saveToPhotosAlbumComplete
{
    SaveToPhotosAlbumComplete object = objc_getAssociatedObject(self, @selector(saveToPhotosAlbumComplete));
    return object;
}

#pragma mark - 图片

static CGContextRef _newBitmapContext(CGSize size)
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    size_t imgWith = (size_t)(size.width + 0.5);
    size_t imgHeight = (size_t)(size.height + 0.5);
    size_t bytesPerRow = imgWith * 4;
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imgWith,
                                                 imgHeight,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpaceRef);
    return context;
}

/// 生成指定颜色和大小的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGContextRef context = _newBitmapContext(size);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    
    CGContextRelease(context);
    CGImageRelease(imgRef);
    
    return img;
}

/// 生成指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/// 获取图片，根据图片url（如：url = http://.../xxx.jpg）
+ (UIImage *)imageWithUrl:(NSString *)url
{
    NSURL *urlImage = [NSURL URLWithString:url];
    NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
    UIImage *image = [[UIImage alloc] initWithData:dataImage];
    return image;
}

/// 获取图片，根据图片url-缓存功能（如：url = http://.../xxx.jpg）
+ (void)imageWithUrl:(NSString *)url complete:(void ((^)(UIImage *image)))complete
{
    __block NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:url];
    if (imageData && 0 < imageData.length)
    {
        UIImage *image = [UIImage imageWithData:imageData];
        if (complete)
        {
            complete(image);
        }
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 获取网络图片数据
            NSURL *imageUrl = [NSURL URLWithString:url];
            imageData = [NSData dataWithContentsOfURL:imageUrl];
            // 只在图片
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:url];
            // 返回图片
            __block UIImage *image = [UIImage imageWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete)
                {
                    complete(image);
                }
            });
        });
    }
}



/// 读取本地图片（如：name = xxx.png）
+ (UIImage *)imageWithBundleName:(NSString *)name
{
    NSString *filePathImage = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    UIImage *image = [UIImage imageWithContentsOfFile:filePathImage];
    return image;
}

/// 读取本地图片（如：xxx.png，name = xxx，type = png）
+ (UIImage *)imageWithBundleName:(NSString *)name type:(NSString *)type
{
    NSString *filePathImage = [[NSBundle mainBundle] pathForResource:name ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:filePathImage];
    return image;
}

#pragma mark - 图片拉升

/// 图片拉升
- (void)resizableImage
{
    [self resizableImage:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
}

/// 拉伸图片-指定UIEdgeInsets
- (void)resizableImage:(UIEdgeInsets)edge
{
    [self resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
}

/// 拉伸图片-指定UIEdgeInsets，指定UIImageResizingMode
- (void)resizableImage:(UIEdgeInsets)edge mode:(UIImageResizingMode)mode
{
    [self resizableImageWithCapInsets:edge resizingMode:mode];
}

#pragma mark - 图片压缩

/// 改变图片大小
- (UIImage *)scaleImageWithSize:(float)size
{
    CGSize temSize = CGSizeZero;
    if (MIN(self.size.width, self.size.height) <= size)
    {
        temSize = self.size;
    }
    else if (self.size.width - self.size.height > 0.0)
    {
        temSize = CGSizeMake(self.size.width * size / self.size.height, size);
    }
    else
    {
        temSize = CGSizeMake(size, self.size.height * size / self.size.width);
    }
    
    UIGraphicsBeginImageContext(temSize);
    [self drawInRect:CGRectMake(0.0, 0.0, temSize.width, temSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/**
 *  图片调整尺寸大小
 *
 *  @param size 调整后尺寸大小
 *
 *  @return 调整后 image 对象
 */
- (UIImage *)scaleImageWithSizeDimension:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return self;
}

/**
 *  图片调整文件大小
 *
 *  @param fileSize 调整后文件大小
 *c
 *  @return 调整后 image 对象
 */
- (UIImage *)compressionImageWithSize:(CGFloat)fileSize
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length / 1000.0;
    CGFloat maxQuqlity = 0.9;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > fileSize && maxQuqlity > 0.01)
    {
        maxQuqlity = maxQuqlity - 0.01;
        data = UIImageJPEGRepresentation(self, maxQuqlity);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes)
        {
            break;
        }
        else
        {
            lastData = dataKBytes;
        }
    }
    
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

#pragma mark - 图片裁剪

// 将图片裁剪成圆角的，并没有改变图片的质量
static void AddRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    if (ovalWidth == 0.0 || ovalHeight == 0.0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    float fileWidth = CGRectGetWidth(rect) / ovalWidth;
    float fileHeight = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fileWidth, fileHeight / 2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fileWidth, fileHeight, fileWidth / 2, fileHeight, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fileHeight, 0, fileHeight / 2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fileWidth / 2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fileWidth, 0, fileWidth, fileHeight / 2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

/// 生成圆角图片（默认圆角大小为8.0）
- (UIImage *)roundedImageWithRadius:(CGFloat)radius
{
    if (0.0 == radius)
    {
        radius = 8.0;
    }
    // the size of CGContextRef
    int width = self.size.width;
    int height = self.size.height;
    
    UIImage *img = self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0.0, 0.0, width, height);
    
    CGContextBeginPath(context);
    AddRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, width, height), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

/// 方形图片
- (UIImage *)squareImageWithSize:(CGSize)newSize
{
    double ratio;
    double delta;
    CGPoint offset;
    
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    if (self.size.width > self.size.height)
    {
        ratio = newSize.width / self.size.width;
        delta = (ratio * self.size.width - ratio * self.size.height);
        offset = CGPointMake(delta / 2, 0.0);
    }
    else
    {
        ratio = newSize.width / self.size.height;
        delta = (ratio * self.size.height - ratio * self.size.width);
        offset = CGPointMake(0.0, delta / 2);
    }
    
    CGRect clipRect = CGRectMake(-offset.x, -offset.y, (ratio * self.size.width) + delta, (ratio * self.size.height) + delta);
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    }
    else
    {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [self drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/// 从图片中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImageWithImage:(UIImage *)image size:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}

/**
 *  全屏截图
 *
 *  @return 截图后 image 对象
 */
+ (UIImage *)mainScreenImage
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIImage *image = [self screenImageWithView:window];
    return image;
}

/// 屏幕截图（指定视图）
+ (UIImage *)screenImageWithView:(UIView *)view
{
//    UIGraphicsBeginImageContext(view.bounds.size);
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/// 从视图中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImageWithView:(UIView *)view size:(CGRect)rect
{
    // 开始取图，参数：截图图片大小
    UIGraphicsBeginImageContext(rect.size);
    // 截图层放入上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束截图
    UIGraphicsEndImageContext();
    
    return image;
    
    
//    UIImage *image = [self screenImageWithView:view];
//    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, rect.size.height); // 下移
//    CGContextScaleCTM(context, 1.0, -1.0); // 上翻
//    CGContextDrawImage(context, rect, imageRef);
//    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGImageRelease(imageRef);
//    CGContextRelease(context);
//    return result;
}

#pragma mark - 图片保存

/// 保存图片到指定路径，是否成功回调
- (void)saveImageWithPath:(NSString *)filePath complete:(void (^)(BOOL isSuccess))complete
{
    /*
     NSData *imageData = UIImageJPEGRepresentation(tempImage, 1.0);
     NSString *fullPathToFile  = [self cachesFolderPathWithName:imageName];
     [imageData writeToFile:path atomically:NO];
     return fullPathToFile;
     */
    
    NSData *imageData = UIImageJPEGRepresentation(self, 0.5);
    BOOL isResult = [imageData writeToFile:filePath atomically:NO];
    if (complete)
    {
        complete(isResult);
    }
}

/// 保存图片到手机相册，是否成功回调
- (void)saveImageToPhotosAlbum:(void (^)(BOOL isSuccess))complete
{
    if (complete)
    {
        self.saveToPhotosAlbumComplete = [complete copy];
    }
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    BOOL isResult = (error == nil ? YES : NO);
    if (self.saveToPhotosAlbumComplete)
    {
        self.saveToPhotosAlbumComplete(isResult);
    }
}

@end
