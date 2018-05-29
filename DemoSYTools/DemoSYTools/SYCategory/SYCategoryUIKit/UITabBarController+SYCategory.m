//
//  UITabBarController+SYCategory.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/4/6.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "UITabBarController+SYCategory.h"

@implementation UITabBarController (SYCategory)

// 初始化样式
+ (void)initializeTabBabController:(UIImage *)bgroundImage font:(UIFont *)textFont color:(UIColor *)textColor colorSelected:(UIColor *)textColorSelected
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = textFont;
    attrs[NSForegroundColorAttributeName] = textColor;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = textColorSelected;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    item.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    // tabbar样式设置
    [[UITabBar appearance] setTintColor:textColorSelected];
    [[UITabBar appearance] setBackgroundImage:bgroundImage];
}

// 添加子控制器
- (void)initWithViewController:(NSArray *)controllers titles:(NSArray *)titles imageNormal:(NSArray *)imageNorNames imageSelected:(NSArray *)imageSelNames
{
    NSAssert(controllers != nil, @"controllers must be not nil");
    NSAssert(titles != nil, @"titles must be not nil");
    NSAssert(imageNorNames != nil, @"imageNorNames must be not nil");
    NSAssert(imageSelNames != nil, @"imageSelNames must be not nil");
    if (controllers.count != titles.count || controllers.count != imageNorNames.count || controllers.count != imageSelNames.count)
    {
        NSLog(@"%s error：数量不相等。", __FUNCTION__);
        return;
    }
    
    for (int index = 0; index < controllers.count; index++)
    {
        UIViewController *controller = controllers[index];
        NSString *title = titles[index];
        NSString *imageNormal = imageNorNames[index];
        NSString *imageSelected = imageSelNames[index];
        
        controller.title = title;
        controller.tabBarItem.image = [UIImage imageNamed:imageNormal];
        controller.tabBarItem.selectedImage = [UIImage imageNamed:imageSelected];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [self addChildViewController:nav];
    }
}

- (void)initWithViewController:(NSArray *)controllers titles:(NSArray *)titles imageNormal:(NSArray *)imageNorNames imageSelected:(NSArray *)imageSelNames font:(UIFont *)textFont color:(UIColor *)textColor colorSelected:(UIColor *)textColorSelected image:(UIImage *)bgroundImage
{
    NSAssert(controllers != nil, @"controllers must be not nil");
    NSAssert(titles != nil, @"titles must be not nil");
    NSAssert(imageNorNames != nil, @"imageNorNames must be not nil");
    NSAssert(imageSelNames != nil, @"imageSelNames must be not nil");
    if (controllers.count != titles.count || controllers.count != imageNorNames.count || controllers.count != imageSelNames.count)
    {
        NSLog(@"%s error：数量不相等。", __FUNCTION__);
        return;
    }
    
    // 设置视图控制器
    NSInteger countController = controllers.count;
    NSMutableArray *navControllers = [[NSMutableArray alloc] initWithCapacity:countController];
    for (int index = 0; index < countController; index++)
    {
        UIViewController *controller = controllers[index];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [navControllers addObject:navController];
    }
    self.viewControllers = navControllers;
    
    // 设置 tabbar 标题、图标
    NSArray *items = self.tabBar.items;
    NSInteger countItem = items.count;
    for (int index = 0; index < countItem; index++)
    {
        NSString *title = titles[index];
        NSString *imageNUrl = imageNorNames[index];
        UIImage *imageN = [UIImage imageNamed:imageNUrl];
        NSString *imageSUrl = imageSelNames[index];
        UIImage *imageS = [UIImage imageNamed:imageSUrl];
        
        // 方法1
//        UITabBarItem *item = [items objectAtIndex:index];
//        // 标题设置（字体偏移、字体大小、字体颜色）
//        item.title = title;
//        item.titlePositionAdjustment = UIOffsetMake(0.0, -4.0);
//        [item setTitleTextAttributes:@{NSFontAttributeName: textFont} forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor} forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: textColorSelected} forState:UIControlStateSelected];
//        // 图标设置
//        item.image = imageN;
//        item.selectedImage = imageS;
        
        // 方法2
        UIViewController *controller = controllers[index];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:imageN selectedImage:imageS];
        [item setTitleTextAttributes:@{NSFontAttributeName: textFont} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: textColorSelected} forState:UIControlStateSelected];
        item.titlePositionAdjustment = UIOffsetMake(0.0, -4.0);
        controller.tabBarItem = item;
        
        // tabbar样式设置
        [[UITabBar appearance] setTintColor:textColorSelected];
        [[UITabBar appearance] setBackgroundImage:bgroundImage];
    }
}

@end
