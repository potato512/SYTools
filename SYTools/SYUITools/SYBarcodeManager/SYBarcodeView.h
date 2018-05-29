//
//  SYBarcodeView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/10/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBarcodeView : UIView

- (instancetype)init __attribute__((unavailable("init 方法不可用，请用 initWithFrame:")));
- (instancetype)initWithFrame:(CGRect)frame;

/// 重置视图
- (void)reloadBarcodeView;
    
/// 扫描线停止
- (void)scanLineStop;
/// 扫描线开始
- (void)scanLineStart;
    
/// 扫描窗口大小，默认居中偏上
@property (nonatomic, assign) CGRect scanFrame;
    
/// 对角线颜色，默认绿色
@property (nonatomic, strong) UIColor *cornerColor;
/// 扫描线，没有图标时，默认绿色
@property (nonatomic, strong) UIImageView *scanline;
/// 扫描线动画时间，默认1.6秒
@property (nonatomic, assign) NSTimeInterval scanTimeDuration;
    
@end
