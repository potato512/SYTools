//
//  ImagePickerBlockVC.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/4/30.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYImagePickerBlockVC.h"
#import <AVFoundation/AVFoundation.h>

@interface SYImagePickerBlockVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) void (^succeedBack)(UIImage *image); // 设置代码块属性-成功
@property (nonatomic, copy) void (^errorBack)(void);             // 设置代码块属性-失败

@property (nonatomic, assign) BOOL isSave;                              // 设置代码块属性-是否保存图片
@property (nonatomic, copy) void (^startSave)(void);                    // 设置代码块属性-保存图片开始
@property (nonatomic, copy) void (^finishSave)(SavePhotoStatus status); // 设置代码块属性-保存图片完成

@end

@implementation SYImagePickerBlockVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sourceType = self.pickerSourceType;
    self.delegate = self;
    // self.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 异常处理

// 根据数据源异常处理
- (BOOL)isValidWithPickerSourceType
{
    if (self.pickerSourceType == UIImagePickerControllerSourceTypeCamera)
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
    
    if (![UIImagePickerController isSourceTypeAvailable:self.pickerSourceType])
    {
        NSString *message = (self.pickerSourceType == UIImagePickerControllerSourceTypeCamera ? @"该设备找不到相机" : @"资源不可访问");
        
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil] show];
        
        return NO;
    }
    else
    {
        self.sourceType = self.pickerSourceType;
        return YES;
    }
}

// 设备启用判断
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

- (void)getPickerImage:(void (^)(UIImage *image))succeed error:(void (^)(void))error PhotosAlbum:(BOOL)save saveStart:(void (^)(void))saveStart saveFinish:(void (^)(SavePhotoStatus status))saveFinish
{
    self.succeedBack = [succeed copy];
    self.errorBack = [error copy];
    
    self.isSave = save;
    if (self.isSave)
    {
        self.startSave = [saveStart copy];
        self.finishSave = [saveFinish copy];
    }
}

#pragma mark - 保存图片

// 拍照模式时才保存到相册
- (void)saveImage:(UIImage *)image
{
    if (self.isSave && [self isSourceTypeCamera])
    {
        if (self.startSave)
        {
            self.startSave();
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }
}

- (BOOL)isSourceTypeCamera
{
    return (self.pickerSourceType == UIImagePickerControllerSourceTypeCamera);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        if (self.finishSave)
        {
            self.finishSave(SavePhotoFail);
        }
    }
    else
    {
        if (self.finishSave)
        {
            self.finishSave(SavePhotoSuccess);
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (!image)
    {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    NSLog(@"scaleImage width %f, height %f",image.size.width, image.size.height);
    
    if (self.succeedBack)
    {
        self.succeedBack(image);
    }
    
    [self saveImage:image];
  
    image = nil;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.errorBack)
    {
        self.errorBack();
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
