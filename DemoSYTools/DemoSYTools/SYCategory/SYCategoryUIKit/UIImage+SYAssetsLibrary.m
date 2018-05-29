//
//  UIImage+SYAssetsLibrary.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/7.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImage+SYAssetsLibrary.h"
#import <AssetsLibrary/AssetsLibrary.h>

#pragma mark - 获取相册图片
static ALAssetsLibrary *assetsLibrary;
static NSMutableArray *imageResults;
typedef void (^startBlock)(void);
static startBlock assetsLibraryStartBlock;
typedef void (^successBlock)(NSArray *imageSuccess);
static successBlock assetsLibrarySuccessBlock;
typedef void (^errorBlock)(void);
static errorBlock assetsLibraryErrorBlock;

@implementation UIImage (SYAssetsLibrary)

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
                                 error:(void(^)(void))error
{
    [[self class] removeImage];
    
    NSInteger imageCount = count;
    BOOL islatest = latest;
    
    assetsLibraryStartBlock = [start copy];
    assetsLibrarySuccessBlock = [success copy];
    assetsLibraryErrorBlock = [error copy];
    
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    imageResults = [[NSMutableArray alloc] init];
    
    __weak UIImage *weakSelf = self;
    
    __block NSString *assetPropertyType = ALAssetTypePhoto;
    __block NSMutableArray *assets = [[NSMutableArray alloc] init];
    
    if (assetsLibraryStartBlock)
    {
        assetsLibraryStartBlock();
    }
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (!group)
            {
                return;
            }
            *stop = YES;
            
            __block int num = 0;
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
             {
                 if (!result)
                 {
                     return;
                 }
                 
                 __block ALAsset *assetResult = result;
                 num++;
                 NSInteger numberOf = [group numberOfAssets];
                 
                 NSString *al_assetPropertyType = [assetResult valueForProperty:ALAssetPropertyType];
                 if ([al_assetPropertyType isEqualToString:assetPropertyType])
                 {
                     [assets addObject:assetResult];
                 }
                 
                 if (num == numberOf)
                 {
                     if (0 == imageCount)
                     {
                         [[weakSelf class] GetImageAll:assets];
                     }
                     else
                     {
                         [[weakSelf class] GetImagelastest:islatest num:imageCount images:assets];
                     }
                 }
             }];
        };
        
        // Group Enumerator Failure Block
        void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"error failure");
                
                if (assetsLibraryErrorBlock)
                {
                    assetsLibraryErrorBlock();
                }
            });
        };
        
        // Enumerate Albums
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                     usingBlock:assetGroupEnumerator
                                   failureBlock:assetGroupEnumberatorFailure];
    });
}

// 清空原有图片
+ (void)removeImage
{
    if (imageResults && 0 != imageResults.count)
    {
        [imageResults removeAllObjects];
    }
}

// 获取所有相片
+ (void)GetImageAll:(NSArray *)array
{
    for (ALAsset *assetResult in array)
    {
        // CGImageRef imageRef = [assetResult thumbnail]; // 缩略图
        CGImageRef imageRef = [[assetResult defaultRepresentation] fullScreenImage]; // 原图
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        if (image)
        {
            // 获取到第一张图片
            [imageResults addObject:image];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (assetsLibrarySuccessBlock)
        {
            assetsLibrarySuccessBlock(imageResults);
        }
    });
}

// 获取最新的，或最早的
+ (void)GetImagelastest:(BOOL)latest num:(NSInteger)count images:(NSArray *)array
{
    if (!array || 0 == array.count)
    {
        return;
    }
    
    NSMutableArray *images = [[NSMutableArray alloc] initWithArray:array];
    NSInteger realCount = images.count; // 实际图片数量
    NSInteger limitCount = (realCount < count ? realCount : count); // 实际限制图片数量
    
    if (latest)
    {
        for (int i = 0; i < limitCount; i++)
        {
            ALAsset *assetResult = [images lastObject];
            // CGImageRef imageRef = [assetResult thumbnail]; // 缩略图
            CGImageRef imageRef = [[assetResult defaultRepresentation] fullScreenImage]; // 原图
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            if (image)
            {
                // 获取到第一张图片
                [imageResults addObject:image];
            }
            [images removeLastObject];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (assetsLibrarySuccessBlock)
            {
                assetsLibrarySuccessBlock(imageResults);
            }
        });
    }
    else
    {
        for (int i = 0; i < limitCount; i++)
        {
            ALAsset *assetResult = [images objectAtIndex:i];
            // CGImageRef imageRef = [assetResult thumbnail]; // 缩略图
            CGImageRef imageRef = [[assetResult defaultRepresentation] fullScreenImage]; // 原图
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            if (image)
            {
                // 获取到第一张图片
                [imageResults addObject:image];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (assetsLibrarySuccessBlock)
            {
                assetsLibrarySuccessBlock(imageResults);
            }
        });
    }
}

@end
