//
//  MJDIYRefreshFooter.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/7/29.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "MJDIYRefreshFooter.h"

@implementation MJDIYRefreshFooter

- (void)prepare
{
    [super prepare];
    
    // Set title
    [self setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    
    /*
    // Set font
    self.stateLabel.font = [UIFont systemFontOfSize:15];
     
    // Set textColor
    self.stateLabel.textColor = [UIColor redColor];
    */
}

@end
