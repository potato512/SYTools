//
//  SYPopupView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/8.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  弹窗列表视图

#import <UIKit/UIKit.h>

static NSString *const keyImagePopviewCellNormal   = @"keyImagePopviewCellNormal";
static NSString *const keyImagePopviewCellSelected = @"keyImagePopviewCellSelected";

/// 显示类型（全屏左对齐显示，固定宽度右侧显示。默认是全屏左对齐显示）
typedef NS_ENUM(NSInteger, PopviewType)
{
    /// 显示类型-全屏右对齐显示
    PopviewTypeFullScreen = 0,
    
    /// 显示类型-全屏居中显示
    PopviewTypeFullScreenCenter,
    
    /// 显示类型-固定宽度右侧显示
    PopviewTypeRight,
};

@interface SYPopupView : UIView

/// 实例
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view;

/// 图标数组源（UIImage）
@property (nonatomic, strong) NSArray *imagesArray;

/// 标题数据源（NSString）
@property (nonatomic, strong) NSArray *titlesArray;

/// 字体大小
@property (nonatomic, strong) UIFont *titleFont;
/// 字体颜色-常态
@property (nonatomic, strong) UIColor *titleColorNormal;
/// 字体颜色-选中
@property (nonatomic, strong) UIColor *titleColorSelected;
/// 选择标识图标
@property (nonatomic, strong) UIImage *accessoryImage;

/// 当前被选中（默认无选中；取值范围：0 ~ n；设置标题数据源后设置）
@property (nonatomic, assign) NSInteger selectedIndex;
/// 是否显示选中状态
@property (nonatomic, assign) BOOL isShowSelected;

/// 类型选择后响应回调（index：0~n）
@property (nonatomic, copy) void (^selectedClick)(NSInteger index, NSString *text);
/// 隐藏后响应回调
@property (nonatomic, copy) void (^hiddenClick)(void);

/// 显示类型（全屏显示，固定宽度右侧显示。默认是全屏显示）
@property (nonatomic, assign) PopviewType showType;

/// 显示（已显示的情况下，则隐藏）
- (void)show;

/// 隐藏
- (void)hidden;

@end
