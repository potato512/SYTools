//
//  BarCodeManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/19.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYBarcodeManager : NSObject

- (instancetype)init __attribute__((unavailable("init 方法不可用，请用 initWithFrame:view:")));
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)superView;

/// 扫描窗口大小，默认居中
@property (nonatomic, assign) CGRect scanFrame;

/// 遮罩层颜色，默认半透明
@property (nonatomic, strong) UIColor *maskColor;
/// 扫描线颜色，默认绿色
@property (nonatomic, strong) UIColor *scanlineColor;
/// 角线颜色，默认绿色
@property (nonatomic, strong) UIColor *scanCornerColor;
    
/// 扫描线动画时间，默认1.6秒
@property (nonatomic, assign) NSTimeInterval scanTimeDuration;

@property (nonatomic, strong) NSString *alertMessage;
@property (nonatomic, strong) NSString *alertTitle;
    
#pragma mark - 扫描二维码

/// 退出扫描
- (void)barcodeScanningCancel;

/// 开始扫描
- (void)barcodeScanningStart:(void (^)(NSString *scanResult))complete;

#pragma mark - 生成二维码

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue;

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size;

@end
