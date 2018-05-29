//
//  UIImage+SYFilter.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/7.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImage+SYFilter.h"

@implementation UIImage (SYFilter)

#pragma mark - 图片滤镜

/// UIImage转为灰度图 CGColorSpaceCreateDeviceGray会创建一个设备相关的灰度颜色空间的引用。
- (UIImage *)grayImage
{
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL)
    {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}


/**
 *  图片滤镜处理（同步处理）
 *
 *  @param filterName 滤镜名称
 *
 *  怀旧 CIPhotoEffectInstant
 *  黑白 CIPhotoEffectNoir
 *  色调 CIPhotoEffectTonal
 *  岁月 CIPhotoEffectTransfer
 *  单色 CIPhotoEffectMono
 *  褪色 CIPhotoEffectFade
 *  冲印 CIPhotoEffectProcess
 *  铬黄 CIPhotoEffectChrome
 *
 *  @return 处理后 image 对象
 */
- (UIImage *)imageFilterWithFilterName:(NSString *)filterName
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

/**
 *  图片滤镜处理-回调（异步处理）
 *
 *  @param filterName 滤镜名称
 *  @param complete   图片滤镜成功后回调处理
 */
- (void)imageFilterWithFilterName:(NSString *)filterName image:(void (^)(UIImage *image))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self imageFilterWithFilterName:filterName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete)
            {
                complete(image);
            }
        });
    });
}

/**
 *  图片模糊处理（同步处理）
 *
 *  @param blurName 滤镜名称
 *  @param radius   滤镜半径
 *
 *  高斯模糊                                CIGaussianBlur
 *  均值模糊                                CIBoxBlur
 *  环形卷积模糊                             CIDiscBlur
 *  中值模糊，用于消除图像噪点（无需设置radius） CIMedianFilter
 *  运动模糊，用于模拟相机移动拍摄时的扫尾效果    CIMotionBlur
 *
 *
 *  @return 处理后 image 对象
 */
- (UIImage *)imageBlurWithBlurName:(NSString *)blurName radius:(NSInteger)radius
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    
    if (0 != blurName.length)
    {
        CIFilter *filter = [CIFilter filterWithName:blurName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![blurName isEqualToString:@"CIMedianFilter"])
        {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        
        CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return image;
    }
    
    return nil;
}

/**
 *  图片模糊处理-回调（异步处理）
 *
 *  @param blurName 滤镜名称
 *  @param radius   滤镜半径
 *  @param complete 图片滤镜成功后回调处理
 */
- (void)imageBlurWithBlurName:(NSString *)blurName radius:(NSInteger)radius image:(void (^)(UIImage *image))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self imageBlurWithBlurName:blurName radius:radius];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete)
            {
                complete(image);
            }
        });
    });
}

/**
 *  图片调整（饱和度、亮度、对比度）（同步处理）
 *
 *  @param saturation 饱和度
 *  @param brightness 亮度
 *  @param contrast   对比度
 *
 *  @return 处理后 image 对象
 */

- (UIImage *)imageAdjustWithSaturation:(CGFloat)saturation brightness:(CGFloat)brightness contrast:(CGFloat)contrast
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

/**
 *  图片调整（饱和度、亮度、对比度）-回调（异步处理）
 *
 *  @param saturation 饱和度
 *  @param brightness 亮度
 *  @param contrast   对比度
 *  @param complete   图片滤镜成功后回调处理
 */
- (void)imageAdjustWithSaturation:(CGFloat)saturation brightness:(CGFloat)brightness contrast:(CGFloat)contrast image:(void (^)(UIImage *image))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self imageAdjustWithSaturation:saturation brightness:brightness contrast:contrast];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete)
            {
                complete(image);
            }
        });
    });
}

@end
