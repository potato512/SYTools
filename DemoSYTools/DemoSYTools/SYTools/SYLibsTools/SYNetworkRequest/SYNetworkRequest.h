//
//  SYNetworkRequest.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/7/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>


/// 请求数据样式（XML，或JSON，或其他；默认其他）
typedef NS_ENUM(NSInteger, RequestContentType)
{
    /// 请求数据样式-XML
    RequestContentTypeXML = 1,
    
    /// 请求数据样式-JSON
    RequestContentTypeJSON = 2,
    
    /// 请求数据样式-其他
    RequestContentTypeOther = 3
};

/// 响应数据样式（XML，或JSON，或其他；默认JSON）
typedef NS_ENUM(NSInteger, ResponseContentType)
{
    /// 响应数据样式-XML
    ResponseContentTypeXML = 1,
    
    /// 响应数据样式-JSON
    ResponseContentTypeJSON = 2,
    
    /// 响应数据样式-其他
    ResponseContentTypeOther = 3
};

/// 请求类型（POST、GET）
typedef NS_ENUM(NSInteger, RequestHttpType)
{
    /// 请求样式-post
    RequestHttpTypePOST = 1,
    
    /// 请求样式-get
    RequestHttpTypeGET = 2,
};

@interface SYNetworkRequest : NSObject

/**
 *  启动设置服务器
 *
 *  @param host API服务器
 */
+ (void)startWithServiceHost:(NSString *)host;


/**
 *  网络监测（APP启动时设置）
 */
+ (void)networkMonitoring;

/// 单例
+ (SYNetworkRequest *)shareRequest;

/// 请求AFHTTPSessionManager
@property (nonatomic, strong, readonly) AFHTTPSessionManager *httpSessionManager;
/// 响应数据样式（XML，或JSON，或其他；默认JSON）
@property (nonatomic, assign) ResponseContentType responseType;
/// 请求数据样式（XML，或JSON，或其他；默认其他）
@property (nonatomic, assign) RequestContentType requestType;


/// 请求AFUrlSessionManager
@property (nonatomic, strong, readonly) AFURLSessionManager *usrlSessionManager;

/**
 *  网络判断
 *
 *  @return 是否有网
 */
+ (BOOL)isReachable;

#pragma mark - AFHTTPSessionManager

/**
 *  网络请求——有效
 *
 *  @param url              API接口url
 *  @param dict             API请求参数
 *  @param isHTTPBody       参数格式（httpBody，或其他）
 *  @param type             请求样式（POST/GET）
 *  @param uploadProgress   请求上传回调(NSProgress * _Nonnull uploadProgress)
 *  @param downloadProgress 请求下载回调(NSProgress * _Nonnull downloadProgress)
 *  @param complete         请求结果回调(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
- (NSURLSessionDataTask *)requestWithUrl:(NSString *)url parameters:(NSDictionary *)dict parametersType:(BOOL)isHTTPBody httpType:(NSString *)type uploadProgress:(void (^)(NSProgress * uploadProgress))uploadProgress downloadProgress:(void (^)(NSProgress * downloadProgress))downloadProgress complete:(void (^)(NSURLResponse * response, id responseObject, NSError * error))complete;

- (NSURLSessionDataTask *)requestPOSTWithUrl:(NSString *)url
                                      params:(NSDictionary *)params
                                    complete:(void (^)(id responseObject))complete;

#pragma mark - AFURLSessionManager

#pragma mark 信息请求

- (NSURLSessionDataTask *)requestWithType:(RequestHttpType)type url:(NSString *)url parameters:(NSDictionary *)dict completionHandle:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion;

- (NSURLSessionDataTask *)requestPostWithUrl:(NSString *)url parameters:(NSDictionary *)dict completionHandle:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion;

- (NSURLSessionDataTask *)requestGetWithUrl:(NSString *)url completionHandle:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion;

#pragma mark 文件上传

#pragma mark 文件下载


@end
