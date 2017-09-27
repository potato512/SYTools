//
//  MJDIYRefreshHeader.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/20.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

//#import <MJRefresh/MJRefresh.h>
//
//@interface MJDIYRefreshHeader : MJRefreshGifHeader
//
//@end

#import <MJRefresh/MJRefreshNormalHeader.h>

@interface MJDIYRefreshHeader : MJRefreshNormalHeader

@end

/*
 使用
 __weak UIViewController *selfWeak = self;
 self.mainTableView.mj_header = [MJDIYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshClick)];
 // 或
 self.mainTableView.mj_header = [MJDIYRefreshHeader headerWithRefreshingBlock:^{
    [selfWeak refreshClick];
 }];
 */
