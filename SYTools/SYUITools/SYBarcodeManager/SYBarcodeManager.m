//
//  BarCodeManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/19.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "SYBarcodeManager.h"
#import <AVFoundation/AVFoundation.h>
#import "SYBarcodeView.h"

typedef void (^ScanningComplete)(NSString *scanResult);

typedef void (^SaveToPhotosAlbumComplete)(BOOL isSuccess);
static SaveToPhotosAlbumComplete saveToPhotosAlbumComplete;

@interface SYBarcodeManager () <AVCaptureMetadataOutputObjectsDelegate>
    
@property (nonatomic, assign) CGRect superFrame;
@property (nonatomic, strong) SYBarcodeView *scanView;

@property (nonatomic, strong) AVCaptureSession *avSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *avLayer;
    
@property (nonatomic, copy) ScanningComplete scanningComplete;

@end

@implementation SYBarcodeManager

- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)superView
{
    self = [super init];
    if (self)
    {
        _maskColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _scanlineColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        _scanCornerColor = [[UIColor greenColor] colorWithAlphaComponent:1.0];
        
        _scanTimeDuration = 1.6;
        
        _alertMessage = @"未获取到摄像设备";
        _alertTitle = @"知道了";
        
        self.superFrame = frame;
        CGFloat size = ((frame.size.width > frame.size.height ? frame.size.height : frame.size.width) * 0.6);
        self.scanFrame = CGRectMake((frame.size.width - size) / 2, (frame.size.width - size) / 2, size, size);
        if (superView)
        {
            [superView addSubview:self.scanView];
        }
    }
    return self;
}
    
- (void)dealloc
{
    NSLog(@"%@ 被释放了...", [self class]);
}
    
#pragma mark - 扫描二维码

/// 退出扫描
- (void)barcodeScanningCancel
{
    [self.avSession stopRunning];
    if (self.avLayer.superlayer)
    {
        [self.avLayer removeFromSuperlayer];
    }
    
    self.scanView.hidden = YES;
}

/// 开始扫描
- (void)barcodeScanningStart:(void (^)(NSString *scanResult))complete
{
    // 回调
    self.scanningComplete = [complete copy];
    
    // 显示扫描相机
    if (self.avLayer.superlayer == nil)
    {
        // 扫描框的位置和大小
        self.avLayer.frame = self.scanView.superview.bounds;
        [self.scanView.superview.layer insertSublayer:self.avLayer above:0];
        [self.scanView.superview bringSubviewToFront:self.scanView];
    }
    
    // 开始捕获
    [self.avSession startRunning];
    
    self.scanView.hidden = NO;
    [self.scanView scanLineStart];
}

#pragma mark - getter
    
#pragma mark 窗口
    
- (SYBarcodeView *)scanView
{
    if (_scanView == nil)
    {
        _scanView = [[SYBarcodeView alloc] initWithFrame:self.superFrame];
    }
    return _scanView;
}

#pragma mark 扫描器
    
- (AVCaptureSession *)avSession
{
    if (_avSession == nil)
    {
        // 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 异常判断
        if (device == nil)
        {
            // 设备无摄像时
            [[[UIAlertView alloc] initWithTitle:nil message:self.alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:self.alertTitle, nil] show];
            return nil;
        }
        
        // 创建输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        // 创建输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        // 设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 初始化链接对象
        _avSession = [[AVCaptureSession alloc] init];
        // 高质量采集率
        [_avSession setSessionPreset:AVCaptureSessionPresetHigh];
        
        [_avSession addInput:input];
        [_avSession addOutput:output];
        
        // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    
    return _avSession;
}

- (AVCaptureVideoPreviewLayer *)avLayer
{
    if (_avLayer == nil)
    {
        _avLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.avSession];
        _avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    
    return _avLayer;
}
    
#pragma mark - setter
    
- (void)setScanFrame:(CGRect)scanFrame
{
    _scanFrame = scanFrame;
    self.scanView.scanFrame = _scanFrame;
    [self.scanView reloadBarcodeView];
}
    
- (void)setMaskColor:(UIColor *)maskColor
{
    _maskColor = maskColor;
    self.scanView.backgroundColor = _maskColor;
    [self.scanView reloadBarcodeView];
}
    
- (void)setScanCornerColor:(UIColor *)scanCornerColor
{
    _scanCornerColor = scanCornerColor;
    self.scanView.cornerColor = _scanCornerColor;
    [self.scanView reloadBarcodeView];
}

- (void)setScanlineColor:(UIColor *)scanlineColor
{
    _scanlineColor = scanlineColor;
    self.scanView.scanline.backgroundColor = _scanlineColor;
    [self.scanView reloadBarcodeView];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

// 通过代理方法获取扫描到的结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSLog(@"%s", __func__);
    
    if (metadataObjects.count > 0)
    {
        // [session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex: 0];
        // 输出扫描字符串
        NSLog(@"输出扫描字符串 = %@，value = %@", metadataObject, metadataObject.stringValue);
        
        // 停止扫描
        [self.avSession stopRunning];
        
        // 停止扫描线
        [self.scanView scanLineStop];
        
        if (self.scanningComplete)
        {
            NSString *scanResult = metadataObject.stringValue;
            self.scanningComplete(scanResult);
        }
    }
}

#pragma mark - 生成二维码

// 根据字符内容生成二维码图片CIImage
+ (CIImage *)barcodeCIImageWithContent:(NSString *)content
{
    NSData *barCodeData = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [filter setValue:barCodeData forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return filter.outputImage;
}

// 二维码图片UIImage
+ (UIImage *)barcodeImageWithCIImage:(CIImage *)ciimage size:(CGFloat)size
{
    CGRect extent = CGRectIntegral(ciimage.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciimage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

// 内存管理
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

/// 黑白二维码转成指定颜色
+ (UIImage *)barcodeImageChangeColor:(UIImage *)image colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue
{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)
        {
            // 将白色变成透明
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

/// 生成二维码（指定内容，指定大小，指定颜色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue
{
    CIImage *ciimage = [self barcodeCIImageWithContent:content];
    UIImage *image = [self barcodeImageWithCIImage:ciimage size:size];
    image = [self barcodeImageChangeColor:image colorRed:red colorGreen:green colorBlue:blue];
    return image;
}

/// 生成二维码（指定内容，指定大小，透明色）
+ (UIImage *)barcodeImageWithContent:(NSString *)content size:(CGFloat)size
{
    UIImage *image = [self barcodeImageWithContent:content size:size colorRed:0.0 colorGreen:0.0 colorBlue:0.0];
    return image;
}

@end
