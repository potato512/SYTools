//
//  UITableViewCell+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITableViewCell+SYCategory.h"
#import <objc/runtime.h>
#import "UIImage+SYCategory.h"

static NSString *const keyLineTop = @"lineTopView";
static NSString *const keyLineBottom = @"lineBottomView";

static CGFloat const heightLine = 0.5; // 默认分割线高度

@implementation UITableViewCell (SYCategory)

/// 设置分割线
- (void)cellLineShow:(CGFloat)offX color:(UIColor *)lineColor type:(CellLineShowType)type
{
    // 底端分割线
    UIImageView *lineBottom = objc_getAssociatedObject(self, &keyLineBottom);
    if (!lineBottom)
    {
        lineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, (CGRectGetHeight(self.bounds) - heightLine), CGRectGetWidth(self.bounds), heightLine)];
        [self.contentView addSubview:lineBottom];
        
        objc_setAssociatedObject(self, &keyLineBottom, lineBottom, OBJC_ASSOCIATION_RETAIN);
    }
    
    CGRect rectButtom = lineBottom.frame;
    rectButtom.origin.x = offX;
    lineBottom.frame = rectButtom;
    
    lineBottom.backgroundColor = lineColor;
    lineBottom.image = [UIImage imageWithColor:lineColor size:CGSizeMake(1.0, 1.0)];
    
    // 顶端分割线
    UIImageView *lineTop = objc_getAssociatedObject(self, &keyLineTop);
    if (!lineTop)
    {
        lineTop = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), heightLine)];
        [self.contentView addSubview:lineTop];
        
        objc_setAssociatedObject(self, &keyLineTop, lineTop, OBJC_ASSOCIATION_RETAIN);
    }
    
    CGRect rectTop = lineTop.frame;
    rectTop.origin.x = offX;
    lineTop.frame = rectTop;
    
    lineTop.backgroundColor = lineColor;
    lineTop.image = [UIImage imageWithColor:lineColor size:CGSizeMake(1.0, 1.0)];
    
    switch (type)
    {
        case CellLineShowNone:
        {
            lineBottom.hidden = YES;
            lineTop.hidden = YES;
        }
            break;
        case CellLineShowAll:
        {
            lineBottom.hidden = NO;
            lineTop.hidden = NO;
        }
            break;
        case CellLineShowButtom:
        {
            lineBottom.hidden = NO;
            lineTop.hidden = YES;
        }
            break;
        case CellLineShowTop:
        {
            lineBottom.hidden = YES;
            lineTop.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}


/// 设置系统分割线缩进样式
- (void)cellSeparatorInset:(UIEdgeInsets)edge
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

#pragma mark - setter/getter

- (void)setLineViewButtom:(UIImageView *)lineViewButtom
{
    objc_setAssociatedObject(self, @selector(lineViewButtom), lineViewButtom, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)lineViewButtom
{
    UIImageView *line = objc_getAssociatedObject(self, @selector(lineViewButtom));
    return line;
}

- (void)setLineViewTop:(UIImageView *)lineViewTop
{
    objc_setAssociatedObject(self, @selector(lineViewTop), lineViewTop, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)lineViewTop
{
    UIImageView *line = objc_getAssociatedObject(self, @selector(lineViewTop));
    return line;
}


@end
