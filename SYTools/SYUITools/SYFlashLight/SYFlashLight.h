//
//  SYFlashLight.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-6-23.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  灯光控制

#import <Foundation/Foundation.h>

/// 提示语，可根据需要修改
static NSString *const AlertTitle = @"温馨提醒";
static NSString *const AlertMessage = @"抱歉，该设备不具备闪光灯功能！";
static NSString *const AlertConfirm = @"确定";

@interface SYFlashLight : NSObject

/// 打开或关闭闪光灯
+ (void)showFlashlight:(void (^)(BOOL hasFlash))callback;

@end

/*
 使用
 1 导入framework：AVFoundation.framework
 
 2 导入头文件
 #import "SYFlashLight.h"
 
 3 使用，开灯或关灯
 [SYFlashLight showFlashlight];
 
 ————————————————————————————————————————————————————————————————————————————————————————————————
 
 调用设备闪光灯的原理说明
 使用“AVFoundation.framework”框架里的“AVCaptureDevice”来调用设备闪光灯。
 
 详细操作步骤如下：
 步骤1 导入“AVFoundation.framework”框架
 
 步骤2 引入头文件“<AVFoundation/AVFoundation.h>”
 即 #import <AVFoundation/AVFoundation.h>
 
 步骤3 初始化AVCaptureDevice实例
 AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
 
 步骤4 异常判断，判断设备是否支持闪光灯功能
 4-1 [captureDevice hasTorch]
 4-2 [captureDevice hasFlash]
 
 步骤5 闪光灯的打开或关闭
 [captureDevice lockForConfiguration:nil];
 [captureDevice setTorchMode: AVCaptureTorchModeOff]; // 打开或关闭
 [captureDevice unlockForConfiguration];
 
 */
