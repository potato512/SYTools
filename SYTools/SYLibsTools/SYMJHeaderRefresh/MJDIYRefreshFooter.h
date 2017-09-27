//
//  MJDIYRefreshFooter.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/7/29.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <MJRefresh/MJRefreshAutoNormalFooter.h>

@interface MJDIYRefreshFooter : MJRefreshAutoNormalFooter

@end

/*
 使用
 __weak UIViewController *selfWeak = self;
 self.mainTableView.mj_footer = [MJDIYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
 // 或
 self.mainTableView.mj_footer = [MJDIYRefreshFooter footerWithRefreshingBlock:^{
    [selfWeak loadMoreData];
 }];
*/