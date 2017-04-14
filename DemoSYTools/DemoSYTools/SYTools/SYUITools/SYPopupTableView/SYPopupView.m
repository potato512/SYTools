//
//  SYPopupView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/8.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "SYPopupView.h"

static NSString *const identifierCell = @"UITableViewCell";

static NSInteger const tagIconImage = 1000;
static NSInteger const tagTitleLabel = 2000;

#define heightCell (44.0 * SYAutoSizeScalesY)
#define widthTable (100.0 * SYAutoSizeScalesX)
#define sizeImage  (20.0 * SYAutoSizeScalesY)

@interface SYPopupView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIImageView *accessoryImageView;

@property (nonatomic, strong) NSIndexPath *previousIndexPath;

@property (nonatomic, assign) CGRect rectSelf;
@property (nonatomic, assign) CGFloat heightTotal;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation SYPopupView

- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        self.rectSelf = frame;
        
        if (view)
        {
            [view addSubview:self];
        }
        
        [self setUI];
    }
    
    return self;
}

#pragma mark - 视图

- (void)setUI
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
}

#pragma mark - 响应

- (void)tapClick
{
    if (self.hiddenClick)
    {
        self.hiddenClick();
    }
    [self hidden];
}

- (void)show
{
    if (self.superview)
    {
        if (self.isShow)
        {
            [self hidden];
        }
        else
        {
            self.isShow = YES;
            
            [self showSubView];
        }
    }
}

- (void)hidden
{
    if (self.superview)
    {
        if (self.isShow)
        {
            self.isShow = NO;
            
            [self hiddenSubView];
        }
    }
}

- (void)showSubView
{
    if (PopviewTypeRight == self.showType)
    {
        self.bgImageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - 30.0), 50.0, 0.0, 0.0);
        self.mainTableView.frame = self.bgImageView.bounds;
        self.mainTableView.top += 5.0;
    }
    else if (PopviewTypeFullScreen == self.showType)
    {
        self.frame = CGRectMake(0.0, self.rectSelf.origin.y, self.rectSelf.size.width, 0.0);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (PopviewTypeRight == self.showType)
        {
            self.bgImageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - widthTable), 50.0, widthTable, (self.heightTotal + 5.0));
            self.mainTableView.frame = self.bgImageView.bounds;
            self.mainTableView.top += 5.0;
        }
        else
        {
            self.frame = CGRectMake(0.0, self.rectSelf.origin.y, self.rectSelf.size.width, self.rectSelf.size.height);
            self.mainTableView.frame = self.bounds;
        }
        
        if (PopviewTypeFullScreenCenter == self.showType)
        {
            [_mainTableView tableViewCellSeparatorInset:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
        }
        [self.mainTableView reloadData];
    }];
}

- (void)hiddenSubView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        if (PopviewTypeRight == self.showType)
        {
            self.bgImageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - 30.0), 50.0, 0.0, 0.0);
            self.mainTableView.frame = self.bgImageView.bounds;
            self.mainTableView.top += 5.0;
        }
        else
        {
            self.frame = CGRectMake(0.0, self.rectSelf.origin.y, self.rectSelf.size.width, 0.0);
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 代理方法

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    
    return  YES;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        
        if (PopviewTypeFullScreenCenter == self.showType)
        {
            [cell cellSeparatorInset:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
            
            CGFloat originX = (CGRectGetWidth(self.rectSelf) - sizeImage - 60.0 - 10.0) / 2;
            // 图标、标题居中对齐，且使用自定义子视图
            UIImageView *iconImageView = InsertImageView(cell.contentView, CGRectMake(originX, (heightCell - sizeImage) / 2, sizeImage, sizeImage), nil);
            iconImageView.contentMode = UIViewContentModeScaleAspectFit;
            iconImageView.tag = tagIconImage;
            
            UILabel *titleLabel = InsertLabel(cell.contentView, CGRectMake((originX + sizeImage + 10.0), 0.0, 60.0, heightCell), NSTextAlignmentLeft, nil, self.titleFont, self.titleColorNormal, NO);
            titleLabel.tag = tagTitleLabel;
            
            titleLabel.textColor = self.titleColorNormal;
        }
        else
        {
            if (self.showType == PopviewTypeRight)
            {
                cell.backgroundColor = kColorClear;
                
//                cell.backgroundView = InsertImageView(nil, cell.bounds, kColorButtonNormal);
//                cell.selectedBackgroundView = InsertImageView(nil, cell.bounds, kColorButtonHighlight);
                
                InsertImageView(cell.contentView, CGRectMake(0.0, (heightCell - kSeparatorLineHeight), CGRectGetWidth(cell.bounds), kSeparatorLineHeight), kImageWithColor(kColorDarkgray));
            }
            
            cell.textLabel.font = self.titleFont;
            cell.textLabel.textColor = self.titleColorNormal;
        }
    }
    
    
    NSString *text = self.titlesArray[indexPath.row];
    
    if (PopviewTypeFullScreenCenter == self.showType)
    {
        NSDictionary *imageDict = self.imagesArray[indexPath.row];
        UIImage *imageNormal = imageDict[keyImagePopviewCellNormal];
        UIImage *imageSelected = imageDict[keyImagePopviewCellSelected];
        
        UIImageView *iconImageView = (UIImageView *)[cell.contentView viewWithTag:tagIconImage];
        iconImageView.image = imageNormal;
        
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:tagTitleLabel];
        titleLabel.text = text;
        titleLabel.textColor = self.titleColorNormal;
        
        if (self.isShowSelected && self.previousIndexPath)
        {
            if ([self.previousIndexPath isEqual:indexPath])
            {
                iconImageView.image = imageSelected;
                titleLabel.textColor = self.titleColorSelected;
            }
        }
    }
    else
    {
        UIImage *image = self.imagesArray[indexPath.row];
        cell.imageView.image = image;
        cell.textLabel.text = text;
        
        cell.textLabel.textColor = self.titleColorNormal;
        cell.accessoryView = nil;
        if (self.isShowSelected && self.previousIndexPath)
        {
            if ([self.previousIndexPath isEqual:indexPath])
            {
                cell.textLabel.textColor = self.titleColorSelected;
                if (self.accessoryImage)
                {
                    cell.accessoryView = self.accessoryImageView;
                }
            }
        }
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedClick)
    {
        NSInteger index = indexPath.row;
        NSString *text = self.titlesArray[index];
        
        self.selectedClick(index, text);
    }
    
    if (self.isShowSelected)
    {
        UITableViewCell *previousCell = [tableView cellForRowAtIndexPath:self.previousIndexPath];
        previousCell.textLabel.textColor = self.titleColorNormal;
        
        UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
        currentCell.textLabel.textColor = self.titleColorSelected;
   
        if (self.accessoryImage)
        {
            previousCell.accessoryView = nil;
            currentCell.accessoryView = self.accessoryImageView;
        }
        
        self.previousIndexPath = indexPath;
    }

    [self hidden];
}

#pragma mark - setter/getter

#pragma mark getter

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = InsertImageView(self, CGRectMake((CGRectGetWidth(self.bounds) - widthTable), 50.0, widthTable, (self.heightTotal + 5.0)), [[UIImage imageNamed:@"backgroundPopImage"] stretchableImageWithLeftCapWidth:5 topCapHeight:10]);
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _bgImageView;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView)
    {
        _mainTableView = InsertTableView(nil, CGRectZero, self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
        
        _mainTableView.backgroundColor = kColorClear;
        _mainTableView.tableFooterView = InsertView(nil, CGRectZero, nil, 0.0, nil, 0.0);
    }
    
    return _mainTableView;
}

- (UIImageView *)accessoryImageView
{
    if (!_accessoryImageView)
    {
        _accessoryImageView = InsertImageView(nil, CGRectMake(0.0, 0.0, sizeImage, sizeImage), self.accessoryImage);
    }
    
    return _accessoryImageView;
}

#pragma mark setter

- (void)setShowType:(PopviewType)showType
{
    _showType = showType;
}

- (void)setTitlesArray:(NSArray *)titlesArray
{
    _titlesArray = titlesArray;
    
    NSInteger count = _titlesArray.count;
    if (0 == count)
    {
        self.mainTableView.hidden = YES;
    }
    else
    {
        self.mainTableView.hidden = NO;
        
        self.heightTotal = heightCell * count;
        
        if (PopviewTypeRight == self.showType)
        {
            self.backgroundColor = kColorClear;

            [self.bgImageView addSubview:self.mainTableView];
            
            self.mainTableView.frame = self.bgImageView.bounds;
            self.mainTableView.top += 5.0;
            
            self.mainTableView.scrollEnabled = NO;
            self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        else
        {
            self.backgroundColor = UIColorHex_Alpha(0x000000, 0.8);
            
            [self addSubview:self.mainTableView];
            self.mainTableView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.rectSelf), CGRectGetHeight(self.rectSelf));
            
            self.mainTableView.backgroundView = nil;
            self.mainTableView.scrollEnabled = YES;
            self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        
        [self.mainTableView reloadData];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    _selectedIndex = (0 > _selectedIndex ? 0 : _selectedIndex);
    _selectedIndex = (self.titlesArray.count <= _selectedIndex ? (self.titlesArray.count - 1) : _selectedIndex);
    
    self.previousIndexPath = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
}

@end
