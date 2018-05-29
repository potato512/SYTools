//
//  NSObject+SYKVO.h
//  zhangshaoyu
//
//  Created by herman on 2017/4/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SYKVO)

/// 监听响应，同时进行回调响应
//- (void)observerComplete:(void (^)(id object))handle;

/// 监听响应，同时进行回调响应
- (void)observerForKeyPath:(NSString *)keyPath complete:(void (^)(NSString *key, id object, NSDictionary *change))complete;

/// 编辑控件输入响应（object为text）
- (void)observerTextEditComplete:(void (^)(id object))complete;

@end
