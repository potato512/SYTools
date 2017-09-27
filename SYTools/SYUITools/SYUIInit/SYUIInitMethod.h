//
//  SYUIInitMethod.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-5-21.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：用于创建UI子类，避免重复编码，造成代码冗余

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 自适应大小类型（宽高，或宽）
typedef enum
{
    /// 自适应宽
    SYAutoSizelabelHorizontal,
    
    /// 自适应宽高
    SYAutoSizelabelAll
}SYAutoSizelabelType;

/// 弹窗视图控制器回调
typedef void (^AlertControllerClick)(int indexButton, NSString *titleButton);

@interface SYUIInitMethod : NSObject

/****************************************************************/

#pragma mark - UIAlertView

/// 实例化UIAlertView
UIAlertView *InsertAlert(UIAlertViewStyle style, NSString *title, NSString *message, NSInteger tag, id delegate, NSString *cancel, NSString *ok);

/// 实例化UIAlertView，带转动视图
UIAlertView *InsertAlertWithActivityIndicatior(NSString *message, NSInteger tag, id delegate, NSString *cancel);

/// 实例化UIAlertView，带输入框
UIAlertView *InsertAlertWithTextField(NSString *title, NSString *cancel, NSString *ok, NSString *set, NSInteger tag, id delegate, SEL selector);

/**
 *  实例化UIAlertController
 *
 *  @param target       UIViewController
 *  @param type         UIAlertControllerStyle:UIAlertControllerStyleActionSheet/UIAlertControllerStyleAlert
 *  @param title        NSString提示标题
 *  @param message      NSString提示信息
 *  @param titlesAction NSString按钮标题数组
 *  @param buttonClick  按钮响应方法
 *
 *  @return UIAlertController
 */
UIAlertController *InsertAlertController(id target, UIAlertControllerStyle type, NSString *title, NSString *message, NSArray *titlesAction, AlertControllerClick buttonClick);

#pragma mark - UIDatePicker

/// 实例化UIDatePicker
UIDatePicker *InsertDatePicker(UIView *view, NSInteger tag, id delegate, UIInterfaceOrientation orientation);

#pragma mark - UIScrollView

/// 实例化UIScrollView
UIScrollView *InsertScrollView(UIView *superView, CGRect rect, int tag,id<UIScrollViewDelegate> delegate);

#pragma mark - UILabel

/// 实例化UILabel，带自适应高度
UILabel *InsertLabel(UIView *superView, CGRect cRect, NSTextAlignment align, NSString *contentStr, UIFont *textFont, UIColor *textColor, BOOL resize);

/// 实例化UILabel，带阴影
UILabel *InsertLabelWithShadow(UIView *superView, CGRect cRect, NSTextAlignment align, NSString *contentStr, UIFont *textFont, UIColor *textColor, BOOL resize, BOOL shadow, UIColor *shadowColor, CGSize shadowOffset);

/// 重置label大小
void LabelReloadSize(UILabel *label, SYAutoSizelabelType autoType);

#pragma mark - UIWebView

/// 实例化UIWebView
UIWebView *InsertWebView(UIView *superView,CGRect cRect, id<UIWebViewDelegate>delegate, int tag);

/// UIWebView使用
void WebViewRequest(UIWebView *web, NSString *strURL);
void WebViewRequestWithCookie(UIWebView *web, NSString *strURL, NSString *cookies);

#pragma mark - UIbutton

/// 实例化按钮
UIButton *InsertButton(UIView *superView, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIColor *titleColorNormal, UIColor *titleColorHighlight, UIColor *titleColorSelected, UIFont *titleFont, UIEdgeInsets titleEdge, UIImage *imageNormal, UIImage *imageHighlight, UIImage *imageSelected, UIEdgeInsets imageEdge, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action);

/// 实例化按钮 带标题
UIButton *InsertButtonWithTitle(UIView *superView, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIColor *titleColorNormal, UIColor *titleColorHighlight, UIColor *titleColorSelected, UIFont *titleFont, id target, SEL action);

/// 实例化按钮 带标题与图标
UIButton *InsertButtonWithTitleAndImage(UIView *superView, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIEdgeInsets titleEdge, UIFont *font, UIColor *colorNormal, UIColor *colorHighlight, UIColor *colorSelected, UIImage *imageNormal, UIImage *imageHighlight, UIImage *imageSelected, UIEdgeInsets imageEdge, id target, SEL action);

/// 实例化按钮 带标题与背景图标
UIButton *InsertButtonWithTitleAndBgroundImage(UIView *superview, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIEdgeInsets titleEdge, UIFont *font, UIColor *colorNormal, UIColor *colorHighlight, UIColor *colorSelected, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action);

/// 实例化按钮 带背景图标
UIButton *InsertButtonWithBgroundImage(UIView *superview, CGRect rect, int tag, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action);

/// 实例化按钮 带图标
UIButton *InsertButtonWithImage(UIView *superview, CGRect rect, UIImage *imageNormal, UIImage *imageHighlight, UIImage *imageSelected, BOOL selected, int tag, id target, SEL action);

#pragma mark - UITableView

/// 实例化UITableView
UITableView *InsertTableView(UIView *superView, CGRect rect, id<UITableViewDataSource> dataSoure, id<UITableViewDelegate> delegate, UITableViewStyle style, UITableViewCellSeparatorStyle cellStyle);

#pragma mark - UITextField

/// 实例化UITextField
UITextField *InsertTextField(UIView *superview, id delegate, CGRect rect, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, float borderwidth, UIColor *bordercolor, UIColor *textFieldColor, float cornerRadius, BOOL isSecureText, UIKeyboardType keyboardType, UIReturnKeyType returnkeyType);

/// 实例化UITextField 带字体颜色设置
UITextField *InsertTextFieldWithTextColor(UIView *superview, id delegate, CGRect rect, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, UIColor *textFieldColor);

/// 实例化UITextField 带边框圆角设置
UITextField *InsertTextFieldWithBorderAndCorRadius(UIView *superview, id delegate, CGRect rect, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, float borderWidth, UIColor *borderColor, UIColor *textFieldColor, float cornerRadius);

#pragma mark - UITextView

/// 实例化UITextView
UITextView *InsertTextView(UIView *superview, id delegate, CGRect rect, UIFont *font, NSTextAlignment textAlignment, float borderWidth, UIColor *borderColor, UIColor *textColor, float cornerRadius, UIKeyboardType keyboardType, UIReturnKeyType returnkeyType);

/// 实例化UITextView 带字体颜色设置
UITextView *InsertTextViewWithTextColor(UIView *superview, id delegate, CGRect rect, UIFont *font, NSTextAlignment textAlignment, UIColor *textColor);

/// 实例化UITextView 带边框圆角设置
UITextView *InsertTextViewWithBorderAndCorRadius(UIView *superview, id delegate, CGRect rect, UIFont *font, NSTextAlignment textAlignment, float borderWidth, UIColor *borderColor, UIColor *textColor, float cornerRadius);

#pragma mark - UISwitch

/// 实例化UISwitch
UISwitch *InsertSwitch(UIView *superview, CGRect rect, id target, SEL action);

#pragma mark - UIImageView

/// 实例化UIImageView
UIImageView *InsertImageView(UIView *superview, CGRect rect, UIImage *image);

#pragma mark - UIView

/// 实例化UIView
UIView *InsertView(UIView *superview, CGRect rect, UIColor *bgroundColor, CGFloat borderwidth, UIColor *bordercolor, CGFloat corRadius);

/// 实例化UIView 带边框
UIView *InsertViewWithBorder(UIView *superview, CGRect rect, UIColor *bgroundColor, CGFloat borderWidth, UIColor *borderColor);

/// 实例化UIView 带圆角
UIView *InsertViewWithCorRadius(UIView *superview, CGRect rect, UIColor *bgroundColor, CGFloat corRadius);

/// 设置view的layer属性
void ViewReloadLayer(UIView *view, CGFloat radius, UIColor *bordercolor, CGFloat borderwidth);

#pragma mark - UIPickerView

/// 实例化UIPickerView
UIPickerView *InsertPickerView(UIView *superview, CGRect rect);

#pragma mark - UIBarButtonItem

UIBarButtonItem *InsetBarButtonItemWithTitle(NSString *title, int tag, UIBarButtonItemStyle style, id target, SEL action);

UIBarButtonItem *InsetBarButtonItemWithImage(UIImage *image, int tag, UIBarButtonItemStyle style, id target, SEL action);

UIBarButtonItem *InsertBarButtonItemWithButton(CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIFont *titleFont, UIColor *titleColorNormal, UIColor *titleColorHighlight, UIColor *titleColorSelected, UIEdgeInsets titleEdge, UIImage *imageNormal, UIImage *imageHighlight, UIImage *imageSelected, UIEdgeInsets imageEdge, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action);

#pragma mark - UIProgressView

UIProgressView *InsertProgressView(UIView *superview, CGRect rect, UIProgressViewStyle style, CGFloat progressValue, UIColor *progressColor, UIColor *trackColor);

#pragma mark - UIActivityIndicatorView

UIActivityIndicatorView *InsertActivityIndicatorView(UIView *superview, CGRect rect, UIColor *bgroundColor, UIColor *styleColor, UIActivityIndicatorViewStyle style);

#pragma mark - UIActionSheet

UIActionSheet *InsertActionSheet(UIView *showView, id delegate, UIActionSheetStyle style, NSString *title, NSString *canael, NSString *destructive);

UIActionSheet *InsertActionSheetWithMoreButton(UIView *showView, id delegate, UIActionSheetStyle style, NSString *title, NSString *canael, NSString *destructive, NSString *titleFirst, NSString *titleSecond);

#pragma mark - UISearchBar

UISearchBar *InsertSearchBar(UIView *superview, CGRect rect, id delegate, NSString *placeholder, UISearchBarStyle style, UIColor *tintColor, UIColor *barColor, UIImage *bgroundImage);

#pragma mark - UIPageControl

UIPageControl *InsertPageControl(UIView *superview, CGRect rect, NSInteger pageCounts, NSInteger currentPage, UIColor *pageColor, UIColor *currentPageColor);

#pragma mark - UISlider

/// 创建UISlider
UISlider *InsertSlider(UIView *superview, CGRect rect, id target, SEL action);

/// 创建UISlider（自定义最大最小值）
UISlider *InsertSliderWithValue(UIView *superview, CGRect rect, id target, SEL action, CGFloat minVlaue, CGFloat maxValue);

/// 创建UISlider（自定义最大最小值，及颜色显示）
UISlider *InsertSliderWithValueAndColor(UIView *superview, CGRect rect, id target, SEL action, CGFloat minVlaue, CGFloat maxValue, UIColor *minColor, UIColor *maxColor, UIColor *thumbTintColor);

/// 创建UISlider（自定义最大最小值，及颜色，图标显示）
UISlider *InsertSliderWithValueAndColorAndImage(id superview, CGRect rect, id target, SEL action, CGFloat minVlaue, CGFloat maxValue, UIColor *minColor, UIColor *maxColor, UIColor *thumbTintColor, UIImage *minImage, UIImage *maxImage);

#pragma mark - UISegmentedControl

/// 创建UISegmentedControl
UISegmentedControl *InsertSegment(UIView *superview, NSArray *titleArray, CGRect rect, id target, SEL action);

/// 创建UISegmentedControl（设置颜色）
UISegmentedControl *InsertSegmentWithColor(UIView *superview, NSArray *titleArray, CGRect rect, id target, SEL action, UIColor *tintColor);

/// 创建UISegmentedControl（设置颜色及被始化被选择索引）
UISegmentedControl *InsertSegmentWithSelectedIndexAndColor(UIView *superview, NSArray *titleArray, CGRect rect, id target, SEL action, NSInteger selectedIndex, UIColor *tintColor);

#pragma mark - UIImagePickerController

UIImagePickerController *InsertImagePicker(UIImagePickerControllerSourceType style, id delegate, UIImage *navImage);

/****************************************************************/

#pragma mark - 视图或视图控制器的操作
/// 视图上添加子视图控制器
void AddSubController(UIView *view, UIViewController *ctrl, BOOL animation);

/// 移除父视图控制器中的子视图控制器
void RemoveSubController(UIViewController *ctrl, BOOL animation);

/// 移除父视图中的子视图
void RemoveAllSubviews(UIView *view);

/****************************************************************/

#pragma mark - 设置时间定时器

/// 实例化timer
NSTimer *InsetTimer(NSTimeInterval timeElapsed, id userInfo, BOOL isRepeat, id target, SEL action);

void TimerStart(NSTimer *timer);
void TimerStop(NSTimer *timer);
void TimerKill(NSTimer *timer);


@end

/*
 使用方法
 
 1 导入头文件
 #import "UIInitMethod.h"
 
 2 初始化使用UI控件
 // 创建view
 UIView *view = InsertView(self.window, CGRectMake(10.0, 60.0, 60.0, 60.0), [UIColor orangeColor]);
 ResetlayerWithView(view, 20.0, [UIColor greenColor], 5.0);
 
 // 创建带边框的view
 InsertViewWithBorder(self.window, CGRectMake(30.0, 130.0, 60.0, 60.0), [UIColor greenColor], 0.5, [UIColor purpleColor]);
 
 // 创建带边框及圆角的view
 InsertViewWithBorderAndCorRadius(self.window, CGRectMake(60.0, 200.0, 60.0, 60.0), [UIColor brownColor], 1.2, [UIColor redColor], 10.0);
 
 */
