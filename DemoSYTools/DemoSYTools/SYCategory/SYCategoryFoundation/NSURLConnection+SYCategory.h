//
//  NSURLConnection+SYCategory.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/11/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (SYCategory) <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/// 异步请求（请求、进度、接收数据、成功、失败）
+ (NSURLConnection *)sendAsynchronousRequest:(NSURLRequest *)request
                           didUpdateProgress:(void (^)(NSInteger progress))progress
                              didReceiveData:(void (^)(NSData *data))data
                          didReceiveResponse:(void (^)(NSHTTPURLResponse *HTTPResponse))success
                            didFailWithError:(void (^)(NSError *error))fail;
@end
