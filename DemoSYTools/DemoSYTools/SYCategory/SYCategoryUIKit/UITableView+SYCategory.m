//
//  UITableView+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITableView+SYCategory.h"

@implementation UITableView (SYCategory)

/// 设置列表视图cell分割线缩进样式
- (void)tableViewCellSeparatorInset:(UIEdgeInsets)edge
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        self.separatorInset = edge;
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        self.layoutMargins = edge;
    }
}

// 隐藏无用的多余单元格
- (void)hiddenUselessTableViewCell
{
    self.tableFooterView = [[UIView alloc] init];
}

/// 刷新列表信息
+ (void)refreshTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message
{
    if (!dataSource || 0 == dataSource.count)
    {
        UILabel *footerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, tableview.frame.size.width, 70.0 * 1.5)];
        footerlabel.font = [UIFont systemFontOfSize:14.0];
        footerlabel.textColor = [UIColor lightGrayColor];
        footerlabel.backgroundColor = [UIColor whiteColor];
        footerlabel.text = message;

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, footerlabel.frame.size.height - 0.5, footerlabel.frame.size.width, 0.5)];
        [footerlabel addSubview:lineView];
        lineView.backgroundColor = [UIColor lightGrayColor];
    
        tableview.tableFooterView = footerlabel;
    }
    else
    {
        tableview.tableFooterView = nil;
        tableview.tableFooterView = [[UIView alloc] init];
    }
    
    [tableview reloadData];
}

- (void)scrollAtIndex:(NSInteger)section row:(NSInteger)row position:(UITableViewScrollPosition)position
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:position animated:YES];
}

@end
