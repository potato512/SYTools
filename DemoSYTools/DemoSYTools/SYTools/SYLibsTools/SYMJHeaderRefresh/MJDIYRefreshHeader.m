//
//  MJDIYRefreshHeader.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/20.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "MJDIYRefreshHeader.h"

@interface MJDIYRefreshHeader()

@property (weak, nonatomic) UIImageView *logo;

@end

@implementation MJDIYRefreshHeader

#pragma mark - 重写方法

#pragma mark 在这里做一些初始化配置（比如添加子控件）

/*
- (void)prepare
{
    [super prepare];

    // 设置普通状态的动画图片
    NSArray *imagesNormal = @[kImageWithName(@"animation_Refresh001")];
    [self setImages:imagesNormal forState:MJRefreshStateIdle];
    
    NSArray *refreshingImages = @[kImageWithName(@"animation_Refresh001"), kImageWithName(@"animation_Refresh002"), kImageWithName(@"animation_Refresh003"), kImageWithName(@"animation_Refresh004"), kImageWithName(@"animation_Refresh005"), kImageWithName(@"animation_Refresh006"), kImageWithName(@"animation_Refresh007"), kImageWithName(@"animation_Refresh008")];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    self.stateLabel.hidden = YES;
}
*/

- (void)prepare
{
    [super prepare];
    
    // Set title
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    
    /*
     // Set font
     self.stateLabel.font = [UIFont systemFontOfSize:15];
     self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
     
     // Set textColor
     self.stateLabel.textColor = [UIColor redColor];
     self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
     */
}

@end
