//
//  SYNetworkRequest.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/7/25.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  https://github.com/AFNetworking/AFNetworking

#import "SYNetworkRequest.h"
#import "SYNetworkAFHTTPSessionManager.h"
#import <netinet/in.h>

static NSTimeInterval const APIServiceTimeout = 30.0;
static NSString *APIServiceHost;

/// 网络请求方式 GET
static NSString *const RequestGET = @"GET";
/// 网络请求方式 POST
static NSString *const RequestPOST = @"POST";

@interface SYNetworkRequest ()

@property (nonatomic, strong) NSURL *hostUrl;
@property (nonatomic, strong) AFHTTPSessionManager *managerHttp;
@property (nonatomic, strong) AFURLSessionManager *managerUrl;

@end

@implementation SYNetworkRequest

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        if (!self.hostUrl.host)
        {
            NSLog(@"<-------没有设置host，请先调用“startWithServiceHost:”设置host------->");
        }
        NSAssert(self.hostUrl.host != nil, @"self.hostUrl must be non-nil");
        NSParameterAssert(self.hostUrl.host);
        NSLog(@"<-------已调用“startWithServiceHost:”设置servicehost------->");
        
        // 初始化请求格式、返回格式
        self.responseType = ResponseContentTypeOther;
        self.requestType = RequestContentTypeOther;
    }
    
    return self;
}

+ (SYNetworkRequest *)shareRequest
{
    static SYNetworkRequest *network = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[self alloc] init];
    });
    
    return network;
}

/**
 *  启动设置服务器
 *
 *  @param host API服务器
 */
+ (void)startWithServiceHost:(NSString *)host
{
    APIServiceHost = host;
}

- (NSURL *)hostUrl
{
    if (!_hostUrl)
    {
        _hostUrl = [NSURL URLWithString:APIServiceHost];
    }
    
    return _hostUrl;
}

#pragma mark - 网络状态监测

/**
 *  网络监测（APP启动时设置）
 */
+ (void)networkMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 *  网络类型-WIFI
 *
 *  @return BOOL
 */
+ (BOOL)isWIFI
{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

/**
 *  网络类型-WWAN
 *
 *  @return BOOL
 */
+ (BOOL)isWWAN
{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN];
}



/**
 *  网络判断
 *
 *  @return 是否有网
 */
+ (BOOL)isReachable
{
//    return [[AFNetworkReachabilityManager sharedManager] isReachable];
    
    // 或
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error: Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = (flags & kSCNetworkFlagsReachable);
    BOOL needsConnection = (flags & kSCNetworkFlagsConnectionRequired);
    BOOL isValidNetwork = ((isReachable && !needsConnection) ? YES : NO);
    
    return isValidNetwork;
}

#pragma mark - 网络请求

#pragma mark 普通请求（GET/POST/PUT/DELETE/HEAD/PATCH）

/**
 *  网络请求（GET/POST/PUT/DELETE/HEAD/PATCH）
 *
 *  @param url              请求地址
 *  @param dict             请求参数
 *  @param methord          请求方式（GET/POST/PUT/DELETE/HEAD/PATCH）
 *  @param uploadProgress   上传进度回调
 *  @param downloadProgress 下载进度回调
 *  @param complete         请求结果回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)requestWithUrl:(NSString *)url
                              parameters:(NSDictionary *)dict
                                 methord:(NSString *)methord
                          uploadProgress:(void (^)(NSProgress *progress))uploadProgress
                        downloadProgress:(void (^)(NSProgress *progress))downloadProgress
                                complete:(void (^)(NSURLResponse *response, id responseObject,  NSError *error))complete
{
    NSString *methordType = [methord uppercaseString];
    NSURLSessionDataTask *dataTask = [self.managerHttp dataTaskWithHTTPMethod:methordType URLString:url parameters:dict uploadProgress:uploadProgress downloadProgress:downloadProgress success:^(NSURLSessionDataTask *task, id responseObject) {
        if (complete)
        {
            complete(task.response, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (complete)
        {
            complete(task.response, nil, error);
        }
    }];
    
    return dataTask;
}

#pragma mark 文件上传请求

/**
 *  网络请求-文件上传
 *
 *  @param url            请求地址
 *  @param dict           请求参数
 *  @param isStream       文件流上传方式
 *  @param filePath       文件路径
 *  @param name           上传标识名称，如：@"file"，或@"iconImg"
 *  @param fileName       文件名称，如：@"filename.jpg"
 *  @param fileType       文件类型，如：@"image/jpeg"
 *  @param uploadProgress 上传进度回调
 *  @param complete       请求结果回调
 *
 *  @return NSURLSessionUploadTask
 */
- (NSURLSessionUploadTask *)requestUploadWithUrl:(NSString *)url
                                      parameters:(NSDictionary *)dict
                                      streamType:(BOOL)isStream
                                        filePath:(NSString *)filePath
                                            name:(NSString *)name
                                        fileName:(NSString *)fileName
                                        fileType:(NSString *)fileType
                                  uploadProgress:(void (^)(NSProgress *progress))uploadProgress
                                        complete:(void (^)(NSURLResponse *response, id responseObject, NSError *error))complete
{
    NSURLSessionUploadTask *uploadTask = nil;
    if (isStream)
    {
        uploadTask = [self uploadStreamWithUrl:url filePath:filePath name:name fileName:fileName fileType:fileType parameters:dict uploadProgress:uploadProgress complete:complete];
    }
    else
    {
        uploadTask = [self uploadWithUrl:url parameters:dict filePath:filePath uploadProgress:uploadProgress complete:complete];
    }
    
    return uploadTask;
}

- (NSURLSessionUploadTask *)uploadWithUrl:(NSString *)url
                               parameters:(NSDictionary *)dict
                                 filePath:(NSString *)filePath
                           uploadProgress:(void (^)(NSProgress *progress))uploadProgress
                                 complete:(void (^)(NSURLResponse *response, id responseObject, NSError *error))complete
{
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
    NSURLSessionUploadTask *uploadTask = [self.managerHttp uploadTaskWithRequest:request fromFile:filePathUrl progress:^(NSProgress * _Nonnull progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (uploadProgress)
            {
                uploadProgress(progress);
            }
        });
    } completionHandler:complete];
    
    return uploadTask;
}

- (NSURLSessionUploadTask *)uploadStreamWithUrl:(NSString *)url
                                       filePath:(NSString *)filePath
                                           name:(NSString *)name
                                       fileName:(NSString *)fileName
                                       fileType:(NSString *)fileType
                                     parameters:(NSDictionary *)dict
                                 uploadProgress:(void (^)(NSProgress *progress))uploadProgress
                                       complete:(void (^)(NSURLResponse *response, id responseObject, NSError *error))complete
{
    NSMutableURLRequest *request = [self.managerHttp.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:name fileName:fileName mimeType:fileType error:nil];
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [self.managerHttp uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull progress) {
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
            if (uploadProgress)
            {
                uploadProgress(progress);
            }
        });
    } completionHandler:complete];
    
    return uploadTask;
}

#pragma mark 文件下载请求

/**
 *  网络请求-文件下载
 *
 *  @param url                   请求地址
 *  @param dict                  请求参数
 *  @param methord               请求方式（GET/POST/PUT/DELETE/HEAD/PATCH）
 *  @param downloadProgress      下载进度回调
 *  @param complete              下载结果回调
 *
 *  @return NSURLSessionDownloadTask
 */
- (NSURLSessionDownloadTask *)requestDownloadWithUrl:(NSString *)url
                                          parameters:(NSDictionary *)dict
                                             methord:(NSString *)methord
                                    downloadProgress:(void (^)(NSProgress *uploadProgress))downloadProgress
                                            complete:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))complete
{
    NSMutableURLRequest *request = [self.managerHttp.requestSerializer requestWithMethod:methord URLString:url parameters:dict error:nil];
    
    NSURLSessionDownloadTask *downloadTask = [self.managerHttp downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (downloadProgress)
            {
                downloadProgress(progress);
            }
        });
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *directoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [directoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:complete];
    
    return downloadTask;
}

#pragma mark - AFHTTPSessionManager

#pragma mark getter

- (AFHTTPSessionManager *)managerHttp
{
    if (_managerHttp == nil)
    {
        NSURL *baseUrl = self.hostUrl;
        if (![baseUrl.scheme isEqualToString:@"http"] && ![baseUrl.scheme isEqualToString:@"https"])
        {
            baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", APIServiceHost]];
        }
        
        _managerHttp = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        if ([baseUrl.scheme isEqualToString:@"https"])
        {
            _managerHttp.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        }
    }
    
    return _managerHttp;
}

#pragma mark setter

/*
// 请求格式
AFHTTPRequestSerializer            二进制格式
AFJSONRequestSerializer            JSON
AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)

// 返回格式
AFHTTPResponseSerializer           二进制格式
AFJSONResponseSerializer           JSON
AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
AFXMLDocumentResponseSerializer (Mac OS X)
AFPropertyListResponseSerializer   PList
AFImageResponseSerializer          Image
AFCompoundResponseSerializer       组合
*/

- (void)setRequestType:(RequestContentType)requestType
{
    _requestType = requestType;
    
    // 请求数据样式
    if (RequestContentTypeXML == requestType)
    {
        self.managerHttp.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    else if (RequestContentTypeJSON == requestType)
    {
        self.managerHttp.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.managerHttp.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        self.managerHttp.requestSerializer.timeoutInterval = APIServiceTimeout;
    }
    else if (RequestContentTypeOther == requestType)
    {
        // 默认
        self.managerHttp.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

- (void)setResponseType:(ResponseContentType)responseType
{
    _responseType = responseType;
    
    // 响应数据格式
    if (ResponseContentTypeXML == responseType)
    {
        // 返回格式-xml
        self.managerHttp.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    else if (ResponseContentTypeJSON == responseType)
    {
        // 返回格式-json 默认
        self.managerHttp.responseSerializer = [AFJSONResponseSerializer serializer];
        // self.managerHttp.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    else if (ResponseContentTypeOther == responseType)
    {
        // 返回格式-其他
        self.managerHttp.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}

/*
 #pragma mark methord
 
 - (NSURLSessionDataTask *)requestWithUrl:(NSString *)url parameters:(NSDictionary *)dict httpType:(NSString *)type complete:(void (^)(NSURLResponse *response, id responseObject, NSError *error))complete
 {
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 
 // 网络异常判断 开始修改时，判断网络情况
 //    BOOL isBadNet = GetNetworkStatusNotReachable;
 BOOL isBadNet = [manager.reachabilityManager isReachable];
 DLog(@"当前网络状态：%@", (isBadNet ? @"不可用" : @"可用"));
 if (isBadNet)
 {
 if (complete)
 {
 complete(nil, nil, nil);
 }
 
 return nil;
 }
 
 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
 NSString *requestUrl = url;
 NSDictionary *requestDict = dict;
 NSString *requestType = type; // @"POST" : @"GET"
 DLog(@"\n request\n url=%@\n para=%@\n type=%@", requestUrl, requestDict, requestType);
 
 NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestType URLString:requestUrl parameters:nil error:nil];
 // 设置请求body（参数dict转换成字符串json）
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
 NSString *bodyJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 NSData *bodyData = [bodyJson dataUsingEncoding:NSUTF8StringEncoding];
 DLog(@"bodyJson = %@", bodyJson);
 request.HTTPBody = bodyData;
 
 NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:complete];
 
 return dataTask;
 }
 
 
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
 
 - (NSURLSessionDataTask *)requestWithUrl:(NSString *)url parameters:(NSDictionary *)dict parametersType:(BOOL)isHTTPBody httpType:(NSString *)type uploadProgress:(void (^)(NSProgress * _Nonnull uploadProgress))uploadProgress downloadProgress:(void (^)(NSProgress * _Nonnull downloadProgress))downloadProgress complete:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))complete
 {
 // 请求地址
 NSString *requestURL = [[NSURL URLWithString:url relativeToURL:self.managerHttp.baseURL] absoluteString];
 // 请求参数
 NSDictionary *requestDict = dict;
 // 请求样式 "POST" ，或"GET"
 NSString *requestMethord = type; // (RequestHttpTypePOST == methordType ? @"POST" : @"GET");
 // 创建请求
 NSMutableURLRequest *request = nil;
 // 设置请求body（参数dict转换成字符串json）
 if (isHTTPBody)
 {
 request = [self.managerHttp.requestSerializer requestWithMethod:requestMethord URLString:requestURL parameters:nil error:nil];
 if (requestDict && 0 != requestDict.count)
 {
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
 NSString *bodyJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 NSData *bodyData = [bodyJson dataUsingEncoding:NSUTF8StringEncoding];
 DLog(@"\nbodyJson = %@", bodyJson);
 request.HTTPBody = bodyData;
 }
 }
 else
 {
 request = [self.managerHttp.requestSerializer requestWithMethod:requestMethord URLString:requestURL parameters:requestDict error:nil];
 }
 
 NSURLSessionDataTask *dataTask = [self.managerHttp dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:complete];
 
 return dataTask;
 }
 
 
 - (NSURLSessionDataTask *)requestPOSTWithUrl:(NSString *)url
 params:(NSDictionary *)params
 complete:(void (^)(id responseObject))complete
 {
 
 //    account=junjie.cai&password=E10ADC3949BA59ABBE56E057F20F883E
 //    bodyJson = {"account":"junjie.cai","password":"E10ADC3949BA59ABBE56E057F20F883E"}
 
 NSURLSessionDataTask *dataTask = [self.managerHttp POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
 
 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
 NSLog(@"responseObject = %@", responseObject);
 
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 
 }];
 
 return dataTask;
 }
 
 
 
 #pragma mark - AFURLSessionManager
 
 #pragma mark getter
 
 - (AFURLSessionManager *)managerUrl
 {
 if (_managerUrl == nil)
 {
 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
 _managerUrl = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
 }
 return _managerUrl;
 }
 
 #pragma mark 信息请求
 
 - (NSURLSessionDataTask *)requestWithType:(RequestHttpType)type url:(NSString *)url parameters:(NSDictionary *)dict completionHandle:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion
 {
 //    NSString *requestType = RequestPOST;
 //    if (RequestHttpTypeGET == type)
 //    {
 //        requestType = RequestGET;
 //    }
 //
 //    NSURLSessionDataTask *dataTask = [self.sessionManagerHttp POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
 //
 //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 //        if (completion)
 //        {
 //            completion(task.response, responseObject, nil);
 //        }
 //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 //        if (completion)
 //        {
 //            completion(task.response, nil, error);
 //        }
 //    }];
 
 // 请求地址
 NSString *requestURL = [[NSURL URLWithString:url relativeToURL:self.managerHttp.baseURL] absoluteString];
 // 创建请求
 NSURLRequest *request = [self.managerHttp.requestSerializer requestWithMethod:@"POST" URLString:requestURL parameters:dict error:nil];
 
 NSURLSessionDataTask *dataTask = [self.managerHttp dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completion];
 
 return dataTask;
 }
 
 - (NSURLSessionDataTask *)requestPostWithUrl:(NSString *)url parameters:(NSDictionary *)dict completionHandle:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion
 {
 NSURLSessionDataTask *dataTask = [self requestWithType:RequestHttpTypePOST url:url parameters:dict completionHandle:completion];
 return dataTask;
 }
 
 - (NSURLSessionDataTask *)requestGetWithUrl:(NSString *)url completionHandle:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completion
 {
 NSURLSessionDataTask *dataTask = [self requestWithType:RequestHttpTypeGET url:url parameters:nil completionHandle:completion];
 return dataTask;
 }
 
 #pragma mark 文件上传
 
 #pragma mark 文件下载
 */



@end
