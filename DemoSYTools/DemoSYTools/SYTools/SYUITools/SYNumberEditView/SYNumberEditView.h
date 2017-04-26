//
//  SYNumberEditView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/4/25.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//  github：https://github.com/potato512/SYNumberEditView

#import <UIKit/UIKit.h>

@interface SYNumberEditView : UIView

/// 减少图标（默认无）
@property (nonatomic, strong) UIImage *reduceImageNormal;
/// 减少高亮图标（默认无）
@property (nonatomic, strong) UIImage *reduceImageHighlight;
/// 减少按钮标题（默认-）
@property (nonatomic, strong) NSString *reduceTitleNormal;
/// 减少按钮高亮标题（默认-）
@property (nonatomic, strong) NSString *reduceTitleHighlight;
/// 减少按钮字体大小（默认12）
@property (nonatomic, strong) UIFont *reduceFont;
/// 减少按钮字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *reduceTitleColorNormal;
/// 减少按钮字体高亮颜色（默认黑色）
@property (nonatomic, strong) UIColor *reduceTitleColorHighlight;

/// 增加图标（默认无）
@property (nonatomic, strong) UIImage *addImageNormal;
/// 增加高亮图标（默认无）
@property (nonatomic, strong) UIImage *addImageHighlight;
/// 增加按钮标题（默认+）
@property (nonatomic, strong) NSString *addTitleNormal;
/// 增加按钮高亮标题（默认+）
@property (nonatomic, strong) NSString *addTitleHighlight;
/// 增加按钮字体大小（默认12）
@property (nonatomic, strong) UIFont *addFont;
/// 增加按钮字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *addTitleColorNormal;
/// 增加按钮字体高亮颜色（默认黑色）
@property (nonatomic, strong) UIColor *addTitleColorHighlight;


/// 字体大小（默认12）
@property (nonatomic, strong) UIFont *textFont;
/// 字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *textColor;

/// 数量值（默认0）
@property (nonatomic, assign) NSInteger number;
/// 最大数量值（默认无限大）
@property (nonatomic, assign) NSInteger numberMax;

/// 数量回调
@property (nonatomic, copy) void (^numberEdit)(NSInteger number);

/// 是否显示边框（默认不显示）
@property (nonatomic, assign) BOOL borderShow;
/// 边框颜色（默认黑色）
@property (nonatomic, strong) UIColor *borderColor;
/// 边框大小（默认0.5，0.5~2.0）
@property (nonatomic, assign) CGFloat borderWidth;
/// 边框圆角
@property (nonatomic, assign) CGFloat borderCornerRadius;

/// 宽小于高的三倍时，自动适应
- (instancetype)initWithFrame:(CGRect)frame;

@end

/*
 使用示例
 步骤1 导入头文件
 #import "SYNumberEditView.h"
 
 步骤2 实例化使用
 SYNumberEditView *numberView = [[SYNumberEditView alloc] initWithFrame:CGRectMake(10.0, 10.0, 80.0, 30.0)];
 [self.view addSubview:numberView];
 numberView.tag = 1000;
 numberView.backgroundColor = [UIColor whiteColor];
 // 按钮
 numberView.reduceImageNormal = [UIImage imageNamed:@"reduceCircle_Normal"];
 numberView.reduceImageHighlight = [UIImage imageNamed:@"reduceCircle_Highlight"];
 numberView.addImageNormal = [UIImage imageNamed:@"addCircle_Normal"];
 numberView.addImageHighlight = [UIImage imageNamed:@"addCircle_Highlight"];
 // 字体
 numberView.textColor = [UIColor redColor];
 numberView.textFont = [UIFont boldSystemFontOfSize:14.0];
 // 数量
 numberView.numberMax = 20;
 numberView.numberEdit = ^(NSInteger number){
     NSLog(@"1 number = %@", @(number));
 };
 // 边框
 numberView.borderShow = YES;
 numberView.borderColor = [UIColor redColor];
 numberView.borderWidth = 2.0;
 numberView.borderCornerRadius = 5.0;
 
 
 */
