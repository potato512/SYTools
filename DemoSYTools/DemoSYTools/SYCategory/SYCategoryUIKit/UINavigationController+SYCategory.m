//
//  UINavigationController+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UINavigationController+SYCategory.h"
#import "UIImage+SYCategory.h"
#import "UIColor+SYCategory.h"

// 高度设置 20 44 64
//static CGFloat const heightStatusbar = 20.0;
//static CGFloat const heightNavigationbar = 44.0;
//static CGFloat const heightStatusAndNavbar = 64.0;
#define widthScreen  [UIScreen mainScreen].applicationFrame.size.width
#define heightScreen [UIScreen mainScreen].applicationFrame.size.height

@implementation UINavigationController (SYCategory)

#pragma mark 导航栏样式

/// 导航栏样式设置
- (void)navigationStyleDefault
{
    [self navigationStyleColor:[UIColor whiteColor] textFont:[UIFont boldSystemFontOfSize:18.0] textColor:[UIColor blackColor]];
}

/// 导航栏样式设置（自定义背景颜色、字体）
- (void)navigationStyleColor:(UIColor *)backgroundColor textFont:(UIFont *)textFont textColor:(UIColor *)textColor
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        // 背景色
        [self.navigationBar setBarTintColor:backgroundColor];
        self.navigationBar.translucent = NO;
        // 返回按钮标题颜色
        self.navigationBar.tintColor = textColor;
        
        // 字体
        self.navigationBar.titleTextAttributes = @{NSFontAttributeName:textFont, NSForegroundColorAttributeName:textColor};
        
        // 导航底部1px的阴影颜色-修改
        [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexadecimalString:@"0xd6d7dc"] size:CGSizeMake(1.0, 1.0)]];
        
        // 导航底部1px的阴影-遮住
        /*
         CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
         maskLayer.backgroundColor = kColorSeparatorline.CGColor;
         CGRect maskRect = CGRectMake(0, -heightStatusbar, widthScreen, heightStatusAndNavbar);
         maskLayer.path = CGPathCreateWithRect(maskRect, NULL);
         self.navigationBar.layer.mask = maskLayer;
         */
    }
}

@end
