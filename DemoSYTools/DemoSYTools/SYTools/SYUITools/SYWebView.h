//
//  SYWebView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/11.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYWebView : UIWebView

/// 是否已加载
@property (nonatomic, assign) BOOL isLoaded;

/// 响应回调
- (void)webViewStart:(void (^)(void))startBlock finish:(void (^)(void))finishBlock failue:(void (^)(void))failueBlock;

@end
