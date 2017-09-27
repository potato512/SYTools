//
//  SYUUID.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/4/7.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYUUID : NSObject

/**
 *  UUID（使用系统等级的 UIPasteboard 进行存储伪UDID值）
 *
 *  @return NSString
 */
+ (NSString *)UUID;

@end

/*
 UDID自iOS5.0及以后版本都被禁用了，所以现在用的可以说都是伪UDID值；
 而且使用值在每次调用时都会生成新值，这时候可以采用第一次生成值时保存到设备中，而不是保存到沙盒中（以避免应用被删除后，就没有这个值了）；
 通常保存方法是使用keychain，或是系统级的剪切板 Pasteboard（避免添加keychain库的麻烦，可使用Pasteboard）
 */
