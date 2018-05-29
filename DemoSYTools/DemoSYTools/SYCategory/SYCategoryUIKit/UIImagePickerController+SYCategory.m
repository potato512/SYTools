//
//  UIImagePickerController+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/29.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImagePickerController+SYCategory.h"
#import <AVFoundation/AVFoundation.h>

typedef void (^CompleteBlock)(UIImage *image);
typedef void (^StartBlock)(void);
typedef void (^SaveBlock)(SavePhotoStatus status);
static CompleteBlock completeBlock;
static StartBlock startBlock;
static SaveBlock saveBlock;

static UIImagePickerControllerSourceType sourceTypePicker;
static BOOL isSavePhoto;
static UIViewController __weak *targetController;

@implementation UIImagePickerController (SYCategory)

#pragma mark - 异常处理

// 根据数据源异常处理
+ (BOOL)isValidWithPickerSourceType
{
    if (sourceTypePicker == UIImagePickerControllerSourceTypeCamera)
    {
        if (![[self class] isCameraServiceValid])
        {
            [[[UIAlertView alloc] initWithTitle:@"提示"
                                        message:@"无法使用相机，请在iPhone的“设置--隐私--相机”中允许访问相机"
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil] show];
            
            return NO;
        }
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceTypePicker])
    {
        NSString *message = (sourceTypePicker == UIImagePickerControllerSourceTypeCamera ? @"该设备找不到相机" : @"资源不可访问");
        
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil] show];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

// 相机设备启用判断
+ (BOOL)isCameraServiceValid
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - 代码块回调

/**
 *  获取相册图片，或拍照
 *
 *  @param sourceType 图片类型
 *  @param target     响应对象视图控制器
 *  @param complete   获取图片回调
 *  @param isSave     是否保存拍照的图片到相册
 *  @param saveStart  开始保存图片（是保存时才有效）
 *  @param saveFinish 保存图片状态（成功，或失败）
 */
+ (void)pickerImageWithType:(UIImagePickerControllerSourceType)sourceType target:(id)target complete:(void (^)(UIImage *image))complete photosAlbum:(BOOL)isSave saveStart:(void (^)(void))saveStart saveFinish:(void (^)(SavePhotoStatus status))saveFinish
{
    [self pickerImageWithType:sourceType edit:NO styleBgColor:nil styleTextColor:nil styleTextFont:nil target:target complete:complete photosAlbum:isSave saveStart:saveStart saveFinish:saveFinish];
}

+ (void)pickerImageWithType:(UIImagePickerControllerSourceType)sourceType edit:(BOOL)allowEdit styleBgColor:(UIColor *)bgColor styleTextColor:(UIColor *)textColor styleTextFont:(UIFont *)textFont target:(id)target complete:(void (^)(UIImage *image))complete photosAlbum:(BOOL)isSave saveStart:(void (^)(void))saveStart saveFinish:(void (^)(SavePhotoStatus status))saveFinish
{
    sourceTypePicker = sourceType;
    if ([[self class] isValidWithPickerSourceType])
    {
        targetController = target;
        completeBlock = [complete copy];
        isSavePhoto = isSave;
        
        if (isSavePhoto)
        {
            startBlock = [saveStart copy];
            saveBlock = [saveFinish copy];
        }
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = sourceType;
        pickerController.allowsEditing = allowEdit;
        pickerController.delegate = [self class];
        // 导航栏样式设置
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            // 背景色
            if (bgColor)
            {
                [pickerController.navigationBar setBarTintColor:bgColor];
                pickerController.navigationBar.translucent = NO;
            }
            // 返回按钮标题颜色，导航标题
            if (textColor && textFont)
            {
                pickerController.navigationBar.tintColor = textColor;
                pickerController.navigationBar.titleTextAttributes = @{NSFontAttributeName:textFont, NSForegroundColorAttributeName:textColor};
            }
        }
        [target presentViewController:pickerController animated:YES completion:nil];
    }
}

#pragma mark - 保存图片

// 拍照模式时才保存到相册
+ (void)saveImage:(UIImage *)image
{
    if (isSavePhoto && [self isSourceTypeCamera])
    {
        if (startBlock)
        {
            startBlock();
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }
}

+ (BOOL)isSourceTypeCamera
{
    return (sourceTypePicker == UIImagePickerControllerSourceTypeCamera);
}

+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (saveBlock)
    {
        saveBlock((error ? SavePhotoFail : SavePhotoSuccess));
    }
}

#pragma mark - UIImagePickerControllerDelegate

+ (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (!image)
    {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    NSLog(@"scaleImage width %f, height %f",image.size.width, image.size.height);
    
    if (completeBlock)
    {
        completeBlock(image);
    }
    
    [[self class] saveImage:image];
    
    image = nil;
    
    [targetController dismissViewControllerAnimated:YES completion:NULL];
}

+ (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (completeBlock)
    {
        completeBlock(nil);
    }
    
    [targetController dismissViewControllerAnimated:YES completion:NULL];
}

@end
