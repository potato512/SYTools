//
//  UIImageView+SYWebImageView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2017/7/5.
//  Copyright © 2017年 ibireme. All rights reserved.
//  网络图片处理-加载前、加载失败时的进度、图标、标题设置

#import <UIKit/UIKit.h>

@interface UIImageView (SYWebImageView)

/**
 *  网络图片设置
 *
 *  @param url              网络图片地址
 *  @param imagePlaceholder 加载时图标
 *  @param imageFailure     加载失败图标
 *  @param textLoading      加载时提示语
 *  @param textFailure      加载失败提示语
 *  @param showProgress     是否显示进度条
 *  @param showActivity     是否显示活动图
 *  @param reload           加载失败时是否可点击重新加载
 */
- (void)imageWithUrl:(NSString *)url imagePlaceholder:(UIImage *)imagePlaceholder imageFailure:(UIImage *)imageFailure textLoading:(NSString *)textLoading textFailure:(NSString *)textFailure showProgress:(BOOL)showProgress showActivity:(BOOL)showActivity reloadWhileFailure:(BOOL)reload;

@end
