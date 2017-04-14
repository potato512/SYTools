//
//  SYUIInitMethod.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-5-21.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "SYUIInitMethod.h"

@implementation SYUIInitMethod

/****************************************************************/

#pragma mark - UIAlertView

UIAlertView *InsertAlert(UIAlertViewStyle style, NSString *title, NSString *message, NSInteger tag, id delegate, NSString *cancel, NSString *ok)
{
	UIAlertView *alertview = [[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancel otherButtonTitles:ok, nil] autorelease];
    alertview.alertViewStyle = style;
    alertview.tag = tag;
	[alertview show];
    
    return alertview;
}

UIAlertView *InsertAlertWithActivityIndicatior(NSString *message, NSInteger tag, id delegate, NSString *cancel)
{
	UIAlertView *alertview = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:delegate cancelButtonTitle:cancel otherButtonTitles:nil] autorelease];
    alertview.tag = tag;
    [alertview show];
	
	// Adjust the indicator so it is up a few pixels from the bottom of the alert
	int x = alertview.bounds.size.width / 2;
	int y = alertview.bounds.size.height - 50.0;
    if (x == 0 || y == -50)
    {
        return nil;
    }
	
    __autoreleasing	UIActivityIndicatorView *indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    indicator.center = CGPointMake(x, y);
	[indicator startAnimating];
    
	[alertview addSubview:indicator];
    
	return alertview;
}

UIAlertView *InsertAlertWithTextField(NSString *title, NSString *cancel, NSString *ok, NSString *set, NSInteger tag, id delegate, SEL selector)
{
	__strong UIAlertView *alertview = [[[UIAlertView alloc] initWithTitle:title message:@"\r\r" delegate:delegate cancelButtonTitle:cancel otherButtonTitles:ok, nil] autorelease];
    alertview.tag = tag;
    [alertview show];
	
	int x = alertview.bounds.size.width;
	int y = alertview.bounds.size.height;
    if (x == 0 || y == 0)
    {
        alertview = nil;
        return nil;
    }
    
	UITextField *myTextField = [[[UITextField alloc] initWithFrame:CGRectMake(x * 0.04, y - 110, x * 0.91, 25)] autorelease];
	myTextField.text = set;
    [myTextField addTarget:delegate action:selector forControlEvents:UIControlEventEditingDidEndOnExit];
	//[alert setTransform:myTransform];
	myTextField.tag = 100;
	[myTextField setBackgroundColor:[UIColor whiteColor]];
    
	[alertview addSubview:myTextField];
    
	return alertview;
}

UIAlertController *InsertAlertController(id target, UIAlertControllerStyle type, NSString *title, NSString *message, NSArray *titlesAction, AlertControllerClick buttonClick)
{
    __autoreleasing UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:type];

    [titlesAction enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (buttonClick)
            {
                int indexButton = (int)idx;
                NSString *titleButton = obj;
                buttonClick(indexButton, titleButton);
            }
        }];
        [alertController addAction:action];
    }];
    
    if (target && [target isKindOfClass:[UIViewController class]])
    {
        [target presentViewController:alertController animated:YES completion:nil];
    }
    
    
    return alertController;
}

#pragma mark - UIDatePicker

UIDatePicker *InsertDatePicker(UIView *view, NSInteger tag, id delegate, UIInterfaceOrientation orientation)
{
	NSString *title = UIDeviceOrientationIsLandscape(orientation) ? @"\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n";
	
	UIActionSheet *actionsheet = [[[UIActionSheet alloc] initWithTitle:title
                                                              delegate:delegate
                                                     cancelButtonTitle:nil
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:nil] autorelease];
    actionsheet.tag = tag;
    [actionsheet showInView:view];
	
    UIDatePicker *datePicker = [[[UIDatePicker alloc] initWithFrame:actionsheet.bounds] autorelease];
	[actionsheet addSubview:datePicker];
	
    return datePicker;
}

#pragma mark - UIScrollView

UIScrollView *InsertScrollView(UIView *superView, CGRect rect, int tag, id<UIScrollViewDelegate> delegate)
{
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:rect] autorelease];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.tag = tag;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = delegate;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    if (superView)
    {
        [superView addSubview:scrollView];
    }
    
    return scrollView;
}

#pragma mark - UILabel

UILabel *InsertLabel(UIView *superView, CGRect rect, NSTextAlignment align, NSString *text, UIFont *textFont, UIColor *textColor, BOOL resize)
{
    return InsertLabelWithShadow(superView, rect, align, text, textFont, textColor, resize, NO, nil, CGSizeMake(0.0, 0.0));
}

UILabel *InsertLabelWithShadow(UIView *superView, CGRect rect, NSTextAlignment align, NSString *text, UIFont *textFont, UIColor *textColor, BOOL resize, BOOL shadow, UIColor *shadowColor, CGSize shadowOffset)
{
    UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = align;
    label.textColor = textColor;
    label.font = textFont;
    label.text = text;
    label.numberOfLines = 1;
    
    if (superView)
    {
        [superView addSubview:label];
    }
    
    // 自适应大小
    if (resize && nil != text)
    {
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        CGSize size = CGSizeMake(rect.size.width, 9999.9);
        CGSize labelsize = [text sizeWithFont:textFont constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        label.frame = CGRectMake(rect.origin.x, rect.origin.y, labelsize.width, labelsize.height);
    }
    
    if (shadow)
    {
        if (shadowColor)
        {
            label.shadowColor = shadowColor;
        }
        label.shadowOffset = shadowOffset;
    }
	
    return label;
}

void LabelReloadSize(UILabel *label, SYAutoSizelabelType autoType)
{
    if (label)
    {
        [label setNumberOfLines:0];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        CGSize size = CGSizeMake(label.frame.size.width, 9999.9);
        CGSize labelsize = [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:label.lineBreakMode];
        if (SYAutoSizelabelHorizontal == autoType)
        {
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, labelsize.width, label.frame.size.height);
        }
        else if (SYAutoSizelabelAll == autoType)
        {
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, labelsize.width, labelsize.height);
        }
    }
}

#pragma mark - UIWebView

UIWebView *InsertWebView(UIView *superView,CGRect rect, id<UIWebViewDelegate>delegate, int tag)
{
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:rect] autorelease];
    webView.tag = tag;
    [webView setOpaque:NO];
    webView.backgroundColor = [UIColor clearColor];
    webView.delegate = delegate;
    webView.scalesPageToFit = NO;
    webView.scrollView.scrollEnabled = NO;
    
    if (superView)
    {
        [superView addSubview:webView];
    }
    
    return webView;
}

void WebViewRequest(UIWebView *web, NSString *strURL)
{
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:url] autorelease];
    
    [web loadRequest:request];
}

void WebViewRequestWithCookie(UIWebView *web, NSString *strURL, NSString *cookies)
{
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [request addValue:cookies forHTTPHeaderField:@"Cookie"];
    
    [web loadRequest:request];
}

#pragma mark - UIbutton

UIButton *InsertButton(UIView *superView, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIColor *titleColorNormal, UIColor *titleColorHighlight, UIColor *titleColorSelected, UIFont *titleFont, UIEdgeInsets titleEdge, UIImage *imageNormal, UIImage *imageSelected, UIEdgeInsets imageEdge, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action)
{
	UIButton *button = [[[UIButton alloc] init] autorelease];
    button.backgroundColor = [UIColor clearColor];
    button.frame = rect;
    [button setTag:tag];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.selected = selected;
    
    if (titleNormal)
    {
        [button setTitle:titleNormal forState:UIControlStateNormal];
    }
    if (titleSelected)
    {
        [button setTitle:titleSelected forState:UIControlStateSelected];
    }
    if (titleColorNormal)
    {
        [button setTitleColor:titleColorNormal forState:UIControlStateNormal];
    }
    if (titleColorHighlight)
    {
        [button setTitleColor:titleColorHighlight forState:UIControlStateHighlighted];
    }
    if (titleColorSelected)
    {
        [button setTitleColor:titleColorSelected forState:UIControlStateSelected];
    }
    if (titleFont)
    {
        button.titleLabel.font = titleFont;
    }
    button.titleEdgeInsets = titleEdge;
    
    if (imageNormal)
    {
        [button setImage:imageNormal forState:UIControlStateNormal];
    }
    if (imageSelected)
    {
        [button setImage:imageSelected forState:UIControlStateSelected];
    }
    button.imageEdgeInsets = imageEdge;
    
    if (bgImageNormal)
    {
        [button setBackgroundImage:bgImageNormal forState:UIControlStateNormal];
    }
    if (bgImageHighlight)
    {
        [button setBackgroundImage:bgImageHighlight forState:UIControlStateHighlighted];
    }
    if (bgImageSelected)
    {
        [button setBackgroundImage:bgImageSelected forState:UIControlStateSelected];
    }
	
    if (superView)
    {
        [superView addSubview:button];
    }
    
    return button;
}

UIButton *InsertButtonWithTitle(UIView *superView, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIColor *titleColorNormal, UIColor *titleColorHighlight, UIColor *titleColorSelected, UIFont *titleFont, id target, SEL action)
{
    return InsertButton(superView, rect, tag, titleNormal, titleSelected, titleColorNormal, titleColorHighlight, titleColorSelected, titleFont, UIEdgeInsetsZero, nil, nil, UIEdgeInsetsZero, nil, nil, nil, NO, target, action);
}

UIButton *InsertButtonWithTitleAndImage(UIView *superView, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIEdgeInsets titleEdge, UIFont *font, UIColor *colorNormal, UIColor *colorHighlight, UIColor *colorSelected, UIImage *imageNormal, UIImage *imageSelected, UIEdgeInsets imageEdge, id target, SEL action)
{
    return InsertButton(superView, rect, tag, titleNormal, titleSelected, colorNormal, colorHighlight, colorSelected, font, UIEdgeInsetsZero, imageNormal, imageSelected, UIEdgeInsetsZero, nil, nil, nil, NO, target, action);
}

UIButton *InsertButtonWithTitleAndBgroundImage(UIView *superview, CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIEdgeInsets titleEdge, UIFont *font, UIColor *colorNormal, UIColor *colorHighlight, UIColor *colorSelected, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action)
{
    return InsertButton(superview, rect, tag, titleNormal, titleSelected, colorNormal, colorHighlight, colorSelected, font, titleEdge, nil, nil, UIEdgeInsetsZero, bgImageNormal, bgImageHighlight, bgImageSelected, selected, target, action);
}

UIButton *InsertButtonWithBgroundImage(UIView *superview, CGRect rect, int tag, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action)
{
    return InsertButton(superview, rect, tag, nil, nil, nil, nil, nil, nil, UIEdgeInsetsZero, nil, nil, UIEdgeInsetsZero, bgImageNormal, bgImageHighlight, bgImageSelected, selected, target, action);
}

UIButton *InsertButtonWithImage(UIView *superview, CGRect rect, UIImage *imageNormal, UIImage *imageSelected, BOOL selected, int tag, id target, SEL action)
{
    return InsertButton(superview, rect, tag, nil, nil, nil, nil, nil, nil, UIEdgeInsetsZero, imageNormal, imageSelected, UIEdgeInsetsZero, nil, nil, nil, selected, target, action);
}

#pragma mark - UITableView

UITableView *InsertTableView(UIView *superView, CGRect rect, id<UITableViewDataSource> dataSoure, id<UITableViewDelegate> delegate, UITableViewStyle style, UITableViewCellSeparatorStyle cellStyle)
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:style];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [[UIView alloc] init];
    
    if (dataSoure)
    {
        tableView.dataSource = dataSoure;
    }
    if (delegate)
    {
        tableView.delegate = delegate;
    }
    tableView.separatorStyle = cellStyle;
    tableView.backgroundView = nil;
    
    if (superView)
    {
        [superView addSubview:tableView];
    }
    
    return [tableView autorelease];
}

#pragma mark - UITextField

UITextField *InsertTextField(UIView *superview, id delegate, CGRect rect, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, float borderwidth, UIColor *bordercolor, UIColor *textFieldColor, float cornerRadius, BOOL isSecureText, UIKeyboardType keyboardType, UIReturnKeyType returnkeyType)
{
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.backgroundColor = [UIColor clearColor];
    textField.delegate = delegate;
    textField.placeholder = placeholder;
    textField.textAlignment = textAlignment;
    textField.contentVerticalAlignment = contentVerticalAlignment;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textField.secureTextEntry = isSecureText;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnkeyType;
    
    if (font)
    {
        textField.font = font;
    }
    if (textFieldColor)
    {
        textField.textColor = textFieldColor;
    }
    
    if (bordercolor && 0.0 < borderwidth)
    {
        textField.layer.borderWidth = borderwidth;
        textField.layer.borderColor = bordercolor.CGColor;
    }
    if (0.0 < cornerRadius)
    {
        textField.layer.cornerRadius = cornerRadius;
        textField.clipsToBounds = YES;
        textField.layer.masksToBounds = YES;
    }
    
    if (superview)
    {
        [superview addSubview:textField];
    }
    
    return [textField autorelease];
}

UITextField *InsertTextFieldWithTextColor(UIView *superview, id delegate, CGRect rect, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, UIColor *textFieldColor)
{
    return InsertTextField(superview, delegate, rect, placeholder, font, textAlignment, contentVerticalAlignment, 0.0, nil, textFieldColor, 0.0, NO, UIKeyboardTypeDefault, UIReturnKeyDefault);
}

UITextField *InsertTextFieldWithBorderAndCorRadius(UIView *superview, id delegate, CGRect rect, NSString *placeholder, UIFont *font, NSTextAlignment textAlignment, UIControlContentVerticalAlignment contentVerticalAlignment, float borderWidth, UIColor *borderColor, UIColor *textFieldColor, float cornerRadius)
{
    return InsertTextField(superview, delegate, rect, placeholder, font, textAlignment, contentVerticalAlignment, borderWidth, borderColor, textFieldColor, cornerRadius, NO, UIKeyboardTypeDefault, UIReturnKeyDefault);
}

#pragma mark - UITextView

UITextView *InsertTextView(UIView *superview, id delegate, CGRect rect, UIFont *font, NSTextAlignment textAlignment, float borderWidth, UIColor *borderColor, UIColor *textColor, float cornerRadius, UIKeyboardType keyboardType, UIReturnKeyType returnkeyType)
{
    UITextView *textView = [[UITextView alloc] initWithFrame:rect];
    textView.backgroundColor = [UIColor clearColor];
    textView.delegate = delegate;
    textView.font = font;
    textView.textAlignment = textAlignment;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textView.keyboardType = keyboardType;
    textView.returnKeyType = returnkeyType;
    
    if (font)
    {
        textView.font = font;
    }
    if (textColor)
    {
        textView.textColor = textColor;
    }
    
    if (borderColor && 0.0 < borderWidth)
    {
        textView.layer.borderWidth = borderWidth;
        textView.layer.borderColor = borderColor.CGColor;
    }
    
    if (0.0 < cornerRadius)
    {
        textView.layer.cornerRadius = cornerRadius;
        textView.clipsToBounds = YES;
        textView.layer.masksToBounds = YES;
    }
    
    if (superview)
    {
        [superview addSubview:textView];
    }
    
    return [textView autorelease];
}

UITextView *InsertTextViewWithTextColor(UIView *superview, id delegate, CGRect rect, UIFont *font, NSTextAlignment textAlignment, UIColor *textColor)
{
    return InsertTextView(superview, delegate, rect, font, textAlignment, 0.0, nil, textColor, 0.0, UIKeyboardTypeDefault, UIReturnKeyDefault);
}

UITextView *InsertTextViewWithBorderAndCorRadius(UIView *superview, id delegate, CGRect rect, UIFont *font, NSTextAlignment textAlignment, float borderWidth, UIColor *borderColor, UIColor *textColor, float cornerRadius)
{
    return InsertTextView(superview, delegate, rect, font, textAlignment, borderWidth, borderColor, textColor, cornerRadius, UIKeyboardTypeDefault, UIReturnKeyDefault);
}

#pragma mark - UISwitch

UISwitch *InsertSwitch(UIView *superview, CGRect rect, id target, SEL action)
{
	UISwitch *switchView = [[UISwitch alloc] initWithFrame:rect];
    [switchView addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    if (superview)
    {
        [superview addSubview:switchView];
    }
    
	return [switchView autorelease];
}

#pragma mark - UIImageView

UIImageView *InsertImageView(UIView *superview, CGRect rect, UIImage *image)
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.backgroundColor = [UIColor clearColor];
    
    if (image)
    {
        [imageView setImage:image];
    }
    
    imageView.userInteractionEnabled = YES;
    
    if (superview)
    {
        [superview addSubview:imageView];
    }
    
    return [imageView autorelease];
}

#pragma mark - UIView

UIView *InsertView(UIView *superview, CGRect rect, UIColor *bgroundColor, CGFloat borderwidth, UIColor *bordercolor, CGFloat corRadius)
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = bgroundColor;
    
    if (superview)
    {
        [superview addSubview:view];
    }
    
    if (bordercolor && 0.0 < borderwidth)
    {
        view.layer.borderWidth = borderwidth;
        view.layer.borderColor = bordercolor.CGColor;
    }
    
    if (0.0 < corRadius)
    {
        view.layer.cornerRadius = corRadius;
        view.layer.masksToBounds = YES;
        view.clipsToBounds = YES;
    }
    
    return [view autorelease];
}

UIView *InsertViewWithBorder(UIView *superview, CGRect rect, UIColor *bgroundColor, CGFloat borderWidth, UIColor *borderColor)
{
    return InsertView(superview, rect, bgroundColor, borderWidth, borderColor, 0.0);
}

UIView *InsertViewWithCorRadius(UIView *superview, CGRect rect, UIColor *bgroundColor, CGFloat corRadius)
{
    return InsertView(superview, rect, bgroundColor, 0.0, nil, corRadius);
}

// 设置view的边框属性
void ViewReloadLayer(UIView *view, CGFloat radius, UIColor *bordercolor, CGFloat borderwidth)
{
    if (view)
    {
        if (radius > 0.0)
        {
            view.layer.cornerRadius = radius;
            view.clipsToBounds = YES;
            view.layer.masksToBounds = YES;
        }
        
        if (bordercolor && borderwidth > 0.0)
        {
            view.layer.borderColor = bordercolor.CGColor;
            view.layer.borderWidth = borderwidth;
        }
    }
}

#pragma mark - UIPickerView

UIPickerView *InsertPickerView(UIView *superview, CGRect rect)
{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:rect];
    pickerView.showsSelectionIndicator = YES;
    
    if (superview)
    {
        [superview addSubview:pickerView];
    }
    
    return [pickerView autorelease];
}

#pragma mark - UIBarButtonItem

UIBarButtonItem *InsetBarButtonItemWithTitle(NSString *title, int tag, UIBarButtonItemStyle style, id target, SEL action)
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:style target:target action:action];
    buttonItem.tag = tag;
    
    return buttonItem;
}

UIBarButtonItem *InsetBarButtonItemWithImage(UIImage *image, int tag, UIBarButtonItemStyle style, id target, SEL action)
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithImage:image style:style target:target action:action];
    buttonItem.tag = tag;
    
    return buttonItem;
}

UIBarButtonItem *InsertBarButtonItemWithButton(CGRect rect, int tag, NSString *titleNormal, NSString *titleSelected, UIFont *titleFont, UIColor *titleColorNormal, UIColor *titleColorHighlight, UIColor *titleColorSelected, UIEdgeInsets titleEdge, UIImage *imageNormal, UIImage *imageSelected, UIEdgeInsets imageEdge, UIImage *bgImageNormal, UIImage *bgImageHighlight, UIImage *bgImageSelected, BOOL selected, id target, SEL action)
{
    UIButton *button = InsertButton(nil, rect, tag, titleNormal, titleSelected, titleColorNormal, titleColorHighlight, titleColorSelected, titleFont, titleEdge, imageNormal, imageSelected, imageEdge, bgImageNormal, bgImageHighlight, bgImageSelected, selected, target, action);
    
    UIBarButtonItem *barButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    
    return barButtonItem;
}

#pragma mark - UIProgressView

UIProgressView *InsertProgressView(UIView *superview, CGRect rect, UIProgressViewStyle style, CGFloat progressValue, UIColor *progressColor, UIColor *trackColor)
{
    UIProgressView *progressView = [[[UIProgressView alloc] initWithFrame:rect] autorelease];
    
    if (superview)
    {
        [superview addSubview:progressView];
    }
    
    progressView.backgroundColor = [UIColor clearColor];
    progressView.progressViewStyle = style;
    progressView.progress = progressValue;
    
    if (progressColor && [progressView respondsToSelector:@selector(setProgressTintColor:)])
    {
        progressView.progressTintColor = progressColor;
    }
    
    if (trackColor && [progressView respondsToSelector:@selector(setTrackTintColor:)])
    {
        progressView.trackTintColor = trackColor;
    }
    
    return progressView;
}

#pragma mark - UIActivityIndicatorView

UIActivityIndicatorView *InsertActivityIndicatorView(UIView *superview, CGRect rect, UIColor *bgroundColor, UIColor *styleColor, UIActivityIndicatorViewStyle style)
{
    UIActivityIndicatorView *activityView = [[[UIActivityIndicatorView alloc] initWithFrame:rect] autorelease];
    
    // 添加到父视图
    if (superview)
    {
        [superview addSubview:activityView];
    }
    
    // 背景颜色
    activityView.backgroundColor = (bgroundColor ? bgroundColor : [UIColor clearColor]);
    
    // 类型
    activityView.activityIndicatorViewStyle = style;
    
    // 转圈圈图标颜色（iOS5.0以下才支持颜色设置）
    if (styleColor && [activityView respondsToSelector:@selector(setColor:)])
    {
        activityView.color = styleColor;
    }
    
    return activityView;
}

#pragma mark - UIActionSheet

UIActionSheet *InsertActionSheet(UIView *showView, id delegate, UIActionSheetStyle style, NSString *title, NSString *canael, NSString *destructive)
{
    return InsertActionSheetWithMoreButton(showView, delegate, style, title, canael, destructive, nil, nil);
}

UIActionSheet *InsertActionSheetWithMoreButton(UIView *showView, id delegate, UIActionSheetStyle style, NSString *title, NSString *canael, NSString *destructive, NSString *titleFirst, NSString *titleSecond)
{
    
    UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:canael destructiveButtonTitle:destructive otherButtonTitles: titleFirst, titleSecond, nil] autorelease];
    
    if (showView)
    {
        [actionSheet showInView:showView];
    }
    
    actionSheet.actionSheetStyle = style;
    
    return actionSheet;
}

#pragma mark - UISearchBar

// 搜索视图
UISearchBar *InsertSearchBar(UIView *superview, CGRect rect, id delegate, NSString *placeholder, UISearchBarStyle style, UIColor *tintColor, UIColor *barColor, UIImage *bgroundImage)
{
    UISearchBar *searchBar = [[[UISearchBar alloc] initWithFrame:rect] autorelease];
    
    if (superview)
    {
        [superview addSubview:searchBar];
    }
    
    searchBar.delegate = delegate;
    searchBar.placeholder = placeholder;
    
    if ([searchBar respondsToSelector:@selector(setSearchBarStyle:)])
    {
        searchBar.searchBarStyle = style;
    }
    
    if (tintColor)
    {
        searchBar.tintColor = tintColor;
    }
    
    if (barColor && [searchBar respondsToSelector:@selector(setBarTintColor:)])
    {
        searchBar.barTintColor = barColor;
    }
    
    if (bgroundImage && [searchBar respondsToSelector:@selector(setBackgroundImage:)])
    {
        searchBar.backgroundImage = bgroundImage;
    }
    
    return searchBar;
}

#pragma mark - UIPageControl

UIPageControl *InsertPageControl(UIView *superview, CGRect rect, NSInteger pageCounts, NSInteger currentPage, UIColor *pageColor, UIColor *currentPageColor)
{
    UIPageControl *pageControl = [[[UIPageControl alloc] initWithFrame:rect] autorelease];
    pageControl.backgroundColor = [UIColor clearColor];
    
    if (superview)
    {
        [superview addSubview:pageControl];
    }

    pageControl.numberOfPages = pageCounts;
    pageControl.currentPage = currentPage;
    
    if (pageColor && [pageControl respondsToSelector:@selector(setPageIndicatorTintColor:)])
    {
        pageControl.pageIndicatorTintColor = pageColor;
    }
    
    if (currentPageColor && [pageControl respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)])
    {
        pageControl.currentPageIndicatorTintColor = currentPageColor;
    }
    
    return pageControl;
}

#pragma mark - UISlider

// 创建UISlider
UISlider *InsertSlider(UIView *superview, CGRect rect, id target, SEL action)
{
    return InsertSliderWithValue(superview, rect, target, action, 0.0, 0.0);
}

// 创建UISlider（自定义最大最小值）
UISlider *InsertSliderWithValue(UIView *superview, CGRect rect, id target, SEL action, CGFloat minVlaue, CGFloat maxValue)
{
    return InsertSliderWithValueAndColor(superview, rect, target, action, minVlaue, maxValue, nil, nil, nil);
}

// 创建UISlider（自定义最大最小值，及颜色显示）
UISlider *InsertSliderWithValueAndColor(UIView *superview, CGRect rect, id target, SEL action, CGFloat minVlaue, CGFloat maxValue, UIColor *minColor, UIColor *maxColor, UIColor *thumbTintColor)
{
    return InsertSliderWithValueAndColorAndImage(superview, rect, target, action, minVlaue, maxValue, minColor, maxColor, thumbTintColor, nil, nil);
}

// 创建UISlider（自定义最大最小值，及颜色，图标显示）
UISlider *InsertSliderWithValueAndColorAndImage(UIView *superview, CGRect rect, id target, SEL action, CGFloat minVlaue, CGFloat maxValue, UIColor *minColor, UIColor *maxColor, UIColor *thumbTintColor, UIImage *minImage, UIImage *maxImage)
{
    UISlider *sliderView = [[[UISlider alloc] initWithFrame:rect] autorelease];
    
    if (superview)
    {
        [superview addSubview:sliderView];
    }
    
    sliderView.backgroundColor = [UIColor clearColor];
    
    if (minVlaue != maxValue)
    {
        sliderView.minimumValue = minVlaue;
        sliderView.maximumValue = maxValue;
    }
    
    if (minColor && [sliderView respondsToSelector:@selector(setMinimumTrackTintColor:)])
    {
        sliderView.minimumTrackTintColor = minColor;
    }
    
    if (maxColor && [sliderView respondsToSelector:@selector(setMaximumTrackTintColor:)])
    {
        sliderView.maximumTrackTintColor = maxColor;
    }
    
    if (thumbTintColor && [sliderView respondsToSelector:@selector(setThumbTintColor:)])
    {
        sliderView.thumbTintColor = thumbTintColor;
    }
    
    if (minImage && [sliderView respondsToSelector:@selector(setMinimumValueImage:)])
    {
        sliderView.minimumValueImage = minImage;
    }
    
    if (maxImage && [sliderView respondsToSelector:@selector(setMaximumValueImage:)])
    {
        sliderView.maximumValueImage = maxImage;
    }
    
    [sliderView addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    return sliderView;
}

#pragma mark - UISegmentedControl

// 创建UISegmentedControl
UISegmentedControl *InsertSegment(UIView *superview, NSArray *titleArray, CGRect rect, id target, SEL action)
{
    return InsertSegmentWithColor(superview, titleArray, rect, target, action, nil);
}

// 创建UISegmentedControl（设置颜色）
UISegmentedControl *InsertSegmentWithColor(UIView *superview, NSArray *titleArray, CGRect rect, id target, SEL action, UIColor *tintColor)
{
    return InsertSegmentWithSelectedIndexAndColor(superview, titleArray, rect, target, action, 0, tintColor);
}

// 创建UISegmentedControl（设置颜色及被始化被选择索引）
UISegmentedControl *InsertSegmentWithSelectedIndexAndColor(UIView *superview, NSArray *titleArray, CGRect rect, id target, SEL action, NSInteger selectedIndex, UIColor *tintColor)
{
    UISegmentedControl *segmentControl = [[[UISegmentedControl alloc] initWithItems:titleArray] autorelease];
    
    if (superview)
    {
        [superview addSubview:segmentControl];
    }
    
    segmentControl.backgroundColor = [UIColor clearColor];
    segmentControl.frame = rect;
    segmentControl.momentary = YES;
    
    if (tintColor && [segmentControl respondsToSelector:@selector(setTintColor:)])
    {
        segmentControl.tintColor = tintColor;
    }
    
    segmentControl.selectedSegmentIndex = selectedIndex;
    
    [segmentControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    return segmentControl;
}

#pragma mark - UIImagePickerController

UIImagePickerController *InsertImagePicker(UIImagePickerControllerSourceType style, id delegate, UIImage *navImage)
{
    UIImagePickerController *imagePickController = [[[UIImagePickerController alloc] init] autorelease];
    imagePickController.sourceType = style;
    imagePickController.delegate = delegate;
    
    if (navImage && [imagePickController respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [imagePickController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    }
    
    return imagePickController;
}

#pragma mark - 父视图或父视图控制器的操作

void AddSubController(UIView *view, UIViewController *ctrl, BOOL animation)
{
    [ctrl viewWillAppear:animation];
    [view addSubview:ctrl.view];
    [ctrl viewDidAppear:animation];
}

void RemoveSubController(UIViewController *ctrl, BOOL animation)
{
    [ctrl viewWillDisappear:animation];
    [ctrl.view removeFromSuperview];
    [ctrl viewDidDisappear:animation];
}

void RemoveAllSubviews(UIView *view)
{
    for (NSInteger i = view.subviews.count; i > 0; i--)
    {
        UIView *subView = [view.subviews objectAtIndex:(i - 1)];
        [subView removeFromSuperview];
    }
}

#pragma mark - 设置时间定时器

NSTimer *InsetTimer(NSTimeInterval timeElapsed, id userInfo, BOOL isRepeat, id target, SEL action)
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeElapsed target:target selector:action userInfo:userInfo repeats:isRepeat];
    // 非必要设置，实际已设置为 NSDefaultRunLoopMode 模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer setFireDate:[NSDate distantFuture]];

    return timer;
}

void TimerStart(NSTimer *timer)
{
    [timer setFireDate:[NSDate distantPast]];
}

void TimerStop(NSTimer *timer)
{
    [timer setFireDate:[NSDate distantFuture]];
}

void TimerKill(NSTimer *timer)
{
    if ([timer isValid])
    {
        [timer invalidate];
    }
}


@end
