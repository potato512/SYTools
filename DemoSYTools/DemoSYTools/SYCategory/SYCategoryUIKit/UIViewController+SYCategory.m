//
//  UIViewController+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIViewController+SYCategory.h"
#import <objc/runtime.h>

// 自定义左右导航栏按钮大小
//static CGFloat const sizeButton = 20.0;
//static CGFloat const sizeButton = 15.0;

// 高度设置 20 44 64
//static CGFloat const heightStatusbar = 20.0;
//static CGFloat const heightNavigationbar = 44.0;
//static CGFloat const heightStatusAndNavbar = 64.0;
#define widthScreen  [UIScreen mainScreen].applicationFrame.size.width
#define heightScreen [UIScreen mainScreen].applicationFrame.size.height

@interface UIViewController ()

@end

@implementation UIViewController (SYCategory)

#pragma mark - setter/getter

- (void)setButtonActionClick:(void (^)(UIBarButtonItem *))buttonActionClick
{
    objc_setAssociatedObject(self, @selector(buttonActionClick), buttonActionClick, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIBarButtonItem *))buttonActionClick
{
    return objc_getAssociatedObject(self, @selector(buttonActionClick));
}

- (void)setHiddenKeyboard:(BOOL)hiddenKeyboard
{
    objc_setAssociatedObject(self, @selector(hiddenKeyboard), @(hiddenKeyboard), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hiddenKeyboard
{
    return objc_getAssociatedObject(self, @selector(hiddenKeyboard));
}

#pragma mark - 响应手势

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.hiddenKeyboard)
    {
        [self.view endEditing:YES];
    }
}

#pragma mark --

/// 是否是根视图
- (BOOL)isRootController
{
    if ([self.navigationController.viewControllers.firstObject isEqual:self])
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 导航栏设置

#pragma mark 返回上层视图响应

/// 返回上层视图响应
- (void)backPreviousController
{
    if ([self isRootController])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        if (self.presentedViewController)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark 导航栏标题

/// 设置导航栏标题视图
- (void)setNavigationTitleView:(UIView *)titleView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, titleView.frame.size.width, titleView.frame.size.height)];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleView.autoresizesSubviews = YES;
    self.navigationItem.titleView = view;
    
    titleView.center = view.center;
    [view addSubview:titleView];
}

/// 设置导航栏标题
- (void)setNavigationTitle:(NSString *)title
{
    if (!title || 0 >= title.length)
    {
        title = @"未设置标题";
    }
    // self.navigationItem.title = title;
    [self setNavigationDefaultFontTitle:title];
}

- (void)setNavigationDefaultFontTitle:(NSString *)title
{
    // 系统方法 张绍裕 20150604
    self.navigationItem.title = title;
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    // 自定义方法
    // UILabel *label = InsertLabel(nil, CGRectMake(0.0, 0.0, 200.0, kNavigationHeight), NSTextAlignmentCenter, title, kFontSizeBold17, UIColorHex(0x000000), NO);
    // self.navigationItem.titleView = label;
}

#pragma mark setter/getter

- (void)setNavigationItemTitle:(NSString *)navigationItemTitle
{
    if (navigationItemTitle)
    {
        objc_setAssociatedObject(self, @selector(navigationItemTitle), navigationItemTitle, OBJC_ASSOCIATION_RETAIN);
        
        self.navigationItem.title = navigationItemTitle;
    }
}

- (NSString *)navigationItemTitle
{
    NSString *object = objc_getAssociatedObject(self, @selector(navigationItemTitle));
    return object;
}

#pragma mark - 链式属性

/// 链式编程 适配（视图显示在导航栏之下）
- (UIViewController *(^)())autoLayoutExtended
{
    return ^() {
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            // 不要往四周边沿展开，避免被导航栏遮挡
            self.edgesForExtendedLayout = UIRectEdgeNone;
        
            // 取消半透明色，避免被导航栏遮挡
            self.navigationController.navigationBar.translucent = NO;
            
            // 展开时不包含导航栏，避免被导航栏遮挡
            self.extendedLayoutIncludesOpaqueBars = NO;
            
            // 改变scrollView的contentInsets，避免scrollView，tableView，collectionView的contentInset.top = 64
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        return self;
    };
}

@end
