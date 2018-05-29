//
//  UIActionSheet+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (SYCategory) <UIActionSheetDelegate>

/// 封装Block（title标题、message信息对UIActionSheet无效、cancelButtonTitle/otherButtonTitles按钮、dismisse/cancel响应方法、showInView）
+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
           cancelButtonTitle:(NSString *)cancelButtonTitle
           otherButtonTitles:(NSArray *)otherButtonTitles
                  controller:(UIViewController *)controller
                  showInView:(UIView *)view
                   onDismiss:(void (^)(int buttonIndex, NSString *buttonTitle))dismisse
                    onCancel:(void (^)(void))cancel;

@end
