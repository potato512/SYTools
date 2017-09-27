//
//  SYCommon_FilePath.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：文件路径

#ifndef Common_FilePath_h
#define Common_FilePath_h

/********************** 路径 ****************************/

/// home沙盒主目录路径
#define GetFilePathHome     NSHomeDirectory()

/// temp临时目录
#define GetFilePathTemp     NSTemporaryDirectory()

/// document文档目录
#define GetFilePathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/// cache缓存目录
#define GetFilePathCache    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/// library目录
#define GetFilePathLibrary  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]


/// home主目录自定义文件路径
#define GetFilePathHomeWithName(name)     [GetFilePathHome stringByAppendingPathComponent:name]

/// temp临时目录自定义文件路径
#define GetFilePathTempWithName(name)     [GetFilePathTemp stringByAppendingPathComponent:name]

/// document文档目录自定义文件路径
#define GetFilePathDocumentWithName(name) [GetFilePathDocument stringByAppendingPathComponent:name]

/// cache缓存目录自定义文件路径
#define GetFilePathCacheWithName(name)    [GetFilePathCache stringByAppendingPathComponent:name]

/// library目录自定义文件路径
#define GetFilePathLibraryWithName(name)  [GetFilePathLibrary stringByAppendingPathComponent:name]



/// 获取当前程序包中资源路径
#define GetFilePathFromBundleNameType(fileName,fileType) [[NSBundle mainBundle] pathForResource:fileName ofType:fileType]


/********************** 路径 ****************************/

#endif /* Common_FilePath_h */
