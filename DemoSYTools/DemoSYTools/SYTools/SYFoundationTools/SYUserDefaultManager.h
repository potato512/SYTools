//
//  SYUserDefaultManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-7-17.
//  功能描述：使用NSUserDefault进入基本数据存储操作
//

#import <Foundation/Foundation.h>

@interface SYUserDefaultManager : NSObject

/************************************************************************/

/// 示例 保存值
+ (void)SaveValueDemo:(BOOL)isFirst;

/// 示例 获取值
+ (BOOL)GetValueDemo;

/// 示例 删除值
+ (void)DeleteValueDemo;

/************************************************************************/




/************************************************************************/



@end
