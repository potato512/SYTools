//
//  UIView+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 翻转视图类型（水平-默认，或垂直）
typedef NS_ENUM(NSInteger, ViewFlipType)
{
    /// 翻转视图类型-水平（默认）
    ViewFlipTypeHorizontal = 0,
    
    /// 翻转视图类型-垂直
    ViewFlipTypeVertical
};

@interface UIView (SYCategory)

#pragma mark - 原点尺寸

/// 坐标
@property (nonatomic, assign) CGPoint origin;

/// 大小
@property (nonatomic, assign) CGSize size;

/// 底部左侧，即x，y坐标
@property (nonatomic, assign, readonly) CGPoint bottomLeft;

/// 底部右侧，即x，y坐标
@property (nonatomic, assign, readonly) CGPoint bottomRight;

/// 顶端右侧，即x，y坐标
@property (nonatomic, assign, readonly) CGPoint topRight;

/// 高
@property (nonatomic, assign) CGFloat height;

/// 宽
@property (nonatomic, assign) CGFloat width;

/// 顶部，即y坐标
@property (nonatomic, assign) CGFloat top;

/// 左侧，即x坐标
@property (nonatomic, assign) CGFloat left;

/// 底部，即y坐标
@property (nonatomic, assign) CGFloat bottom;

/// 右侧，即x坐标
@property (nonatomic, assign) CGFloat right;

/// 移动到指定位置（中心点位置改变）
- (void)moveToPoint:(CGPoint)point;

/// 变换大小（宽高改变）
- (void)scaleToSize:(CGFloat)scale;


/// 随意拖动（默认NO）
@property (nonatomic, assign) BOOL drapEnable;


#pragma mark - 标题属性

/// 标题（默认无）
@property (nonatomic, strong) NSString *viewText;
/// 标题字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *viewTextColor;
/// 标题字体大小（默认12.0）
@property (nonatomic, strong) UIFont *viewTextFont;
/// 显示行数（默认多行）
@property (nonatomic, assign) NSInteger viewTextNumberLines;
/// 自适应字体大小（默认无）
@property (nonatomic, assign) BOOL viewTextAdjustsFontSizeToFitWidth;
/// 标题显示位置（默认居中）
@property (nonatomic, assign) CGRect viewTextRect;
/// 标题显示对齐方式（默认居中）
@property (nonatomic, assign) NSTextAlignment viewTextAlignment;


#pragma mark - 视图属性设置

/**
 *  毛玻璃效果（注意使用前必须先添加到父视图）
 *
 *  @param alpha 透明度
 */
- (void)effectViewWithAlpha:(CGFloat)alpha;

/// 设置UI视图的边框属性
- (void)layerWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/// 设置UI视图的shape边框属性（圆角、边框颜色、边框大小，是否虚线）
- (void)shapeLayerWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width isDotted:(BOOL)isDotted;
/// 设置视图的shape边框属性-圆角
@property (nonatomic, assign) CGFloat shapeCornerRadius;
/// 设置视图的shape边框属性-边框颜色
@property (nonatomic, strong) UIColor *shapeBorderColor;
/// 设置视图的shape边框属性-边框大小
@property (nonatomic, assign) CGFloat shapeBorderWidth;
/// 设置视图的shape边框属性-是否虚线
@property (nonatomic, assign) BOOL shapeBorderDotted;


/// 旋转
- (void)viewTransformWithRotation:(CGFloat)rotation;

/// 缩放
- (void)viewScaleWithSize:(CGFloat)size;

/// 水平，或垂直翻转
- (void)viewFlipType:(ViewFlipType)type;

#pragma mark - 链式属性

/// 链式编程 视图实例化
+ (UIView *)newUIView:(void (^)(UIView *view))complete;

#pragma mark 原点尺寸

/// 链式编程 视图的父视图
- (UIView *(^)(UIView *view))viewSuperView;

/// 链式编程 视图的位置大小
- (UIView *(^)(CGRect frame))viewFrame;

/// 链式编程 视图的位置
- (UIView *(^)(CGPoint point))viewOrigin;

/// 链式编程 视图的中心点
- (UIView *(^)(CGPoint center))viewCenter;

/// 链式编程 视图的大小
- (UIView *(^)(CGSize size))viewSize;

/// 链式编程 视图的左边距
- (UIView *(^)(CGFloat left))viewLeft;

/// 链式编程 视图的顶部边距
- (UIView *(^)(CGFloat top))viewTop;

/// 链式编程 视图的右边距
- (UIView *(^)(CGFloat right))viewRight;

/// 链式编程 视图的底部边距
- (UIView *(^)(CGFloat bottom))viewBottom;

/// 链式编程 视图的宽
- (UIView *(^)(CGFloat width))viewWidth;

/// 链式编程 视图的高
- (UIView *(^)(CGFloat height))viewHeight;

#pragma mark 变换设置

/// 链式编程 视图移动
- (UIView *(^)(CGPoint point))viewMove;

/// 链式编程 视图旋转
- (UIView *(^)(CGFloat rotation))viewTransformRotation;

/// 链式编程 视图缩放
- (UIView *(^)(CGFloat size))viewTransformScale;

/// 链式编程 视图缩放
- (UIView *(^)(CGFloat scale))viewScale;

#pragma mark 模糊

/// 链式编程 视图模糊化
- (UIView *(^)(CGFloat alpha))viewEffect;

#pragma mark 边框圆角

/// 链式编程 视图圆角
- (UIView *(^)(CGFloat radius))viewRadius;

/// 链式编程 视图边框大小，颜色
- (UIView *(^)(CGFloat width, UIColor *color))viewBorder;

#pragma mark 属性设置

/// 链式编程 视图背景颜色
- (UIView *(^)(UIColor *color))viewBackgroundColor;

/// 链式编程 视图tag
- (UIView *(^)(NSInteger tag))viewTag;

/// 链式编程 视图透明度
- (UIView *(^)(CGFloat alpha))viewAlpha;

/// 链式编程 视图背景颜色透明度
- (UIView *(^)(UIColor *color, CGFloat alpha))viewColorAlpha;

/// 链式编程 视图是否隐藏
- (UIView *(^)(BOOL hidden))viewHidden;

/// 链式编程 视图内容显示模式
- (UIView *(^)(UIViewContentMode mode))viewContentMode;

/// 链式编程 视图适配
- (UIView *(^)(UIViewAutoresizing autoresizing))viewAutoresizing;

/// 链式编程 视图用户交互
- (UIView *(^)(BOOL enable))viewInteractionEnabled;

#pragma mark 文本信息

/// 链式编程 视图标题
- (UIView *(^)(NSString *text))viewTitle;

/// 链式编程 视图标题颜色
- (UIView *(^)(UIColor *color))viewTitleColor;

/// 链式编程 视图标题字体大小
- (UIView *(^)(UIFont *font))viewTitleFont;

/// 链式编程 视图标题位置大小
- (UIView *(^)(CGRect frame))viewTitleFrame;

/// 链式编程 视图标题对齐方式
- (UIView *(^)(NSTextAlignment alignment))viewTitleAlignament;

/// 链式编程 视图拖动
- (UIView *(^)(BOOL dragEnable))viewDragEnable;

@end
