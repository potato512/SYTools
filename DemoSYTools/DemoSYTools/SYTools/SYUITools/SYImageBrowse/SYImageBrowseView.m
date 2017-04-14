//
//  SYImageView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/8.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYImageBrowseView.h"
#import "SYImageBrowseHelper.h"

@interface SYImageBrowseView ()

@end

@implementation SYImageBrowseView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        [self addTapGesture];
    }
    
    return self;
}

- (void)addTapGesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    self.userInteractionEnabled = self;
    [self addGestureRecognizer:tapRecognizer];
}

- (void)tapClick
{
    if (self.imageClick)
    {
        self.imageClick();
    }
}

/// 设置图片（网络图片/本地图片+默认图片）
- (void)setImage:(id)object defaultImage:(UIImage *)image
{
    SYImageType type = [SYImageBrowseHelper getSYImageType:object];
    switch (type)
    {
        case SYImageTypeImage:
        {
            self.image = object;
        }
            break;
        case SYImageTypeName:
        {
            UIImage *img = [UIImage imageNamed:object];
            self.image = img;
        }
            break;
        case SYImageTypeUrl:
        {
//            NSURL *imageUrl = [NSURL URLWithString:object];
//            [self sd_setImageWithURL:imageUrl placeholderImage:image];
        }
            break;
            
        default:
            break;
    }
}

@end
