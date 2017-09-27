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

/**
 *  加载网页（URL网址）
 *
 *  @param URL 网址
 */
- (void)loadRequestWithURL:(NSURL *)url;

/**
 *  加载网页（NSString网址）
 *
 *  @param urlStr 网址
 */
- (void)loadRequestWithURLStr:(NSString *)urlStr;

/**
 *  加载本地网页（NSString）
 *
 *  @param html 网页字符串
 */
- (void)loadRequestWithHTML:(NSString *)html;

/// 响应回调
- (void)webViewStart:(void (^)(void))startBlock finish:(void (^)(void))finishBlock failue:(void (^)(void))failueBlock;

@end
