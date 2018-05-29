//
//  NSFileManager+iCloud.m
//  zhangshaoyu
//
//  Created by herman on 2017/7/2.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSFileManager+iCloud.h"
#import "NSFileManager+SYCategory.h"

#define FileManager [NSFileManager defaultManager]

@implementation NSFileManager (iCloud)

/**
 *  /// 将文件放到iCloud里面
 *
 *  @param filePath   文件路径
 *  @param identifier 设备标识
 *  @param complete   响应回调
 */
+ (void)uploadiCloudWithFilePath:(NSString *)filePath identifier:(NSString *)identifier complete:(void (^)(BOOL isSuccess))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        
        // 这里的 identifier 应该设置为 entitlements 的第一个元素；当你使用这段代码的时候需要把 identifier 设置为你自己的真实 identifier
        NSString *fileIdentifier = identifier;
        NSString *fileNamge = [NSFileManager getFileNameWithFilePath:filePath];
        
        NSURL *ubiquitousContainerURL = [FileManager URLForUbiquityContainerIdentifier:fileIdentifier];
        NSURL *ubiquitousFileURL = [ubiquitousContainerURL URLByAppendingPathComponent:fileNamge];
        
        NSError *error = nil;
        BOOL isResult = [FileManager setUbiquitous:YES
                                         itemAtURL:fileURL
                                    destinationURL:ubiquitousFileURL
                                             error:&error];
        if (complete)
        {
            complete(isResult);
        }
    });
}

/*
 负责任的iCloud App
 用户的iCloud空间有限，并且由所有应用共享。用户可以查看指定应用消耗的iCloud空间，可以选择删除应用相关联的文档和数据。因此，应用必须对自己存储在iCloud中的文件负责，下面是一些管理iCloud文档的建议：
 
 对存储iCloud文档采取一种好的策略。允许用户启用或禁用iCloud。
 从用户iCloud账户中删除一个文档，将从用户所有计算机和设备中删除该文档。确保用户明白这一点，并确认删除操作。如果你只是想刷新文档的本地拷贝，使用 NSFileManager 的 evictUbiquitousItemAtURL:error: 方法，而不是删除文件。
 存储文档到iCloud时，尽量将文档存储在"Documents"子目录中。用户可以单个删除Documents目录中的文档以释放空间，但是Documents目录之外的所有东西，都被当做数据，只能一次全部删除！
 永远不要存储缓存或其它应用的私有文件到用户的iCloud storage。用户的iCloud账户只应该用于存储用户相关的数据，以及应用无法重新生成的内容。
 对iCloud文件和应用Sandbox文件相同对待。保存文件应该由应用需求和保留用户数据的需求来驱动。你不应该修改应用更频繁或更慢地保存iCloud文件。iCloud会自动优化自己向服务器的传输，以确保最佳的性能。
 http://www.cocoachina.com/bbs/read.php?tid=86249&keyword=icloud
 
 
 
 
 操作iCloud中的文件和目录
 iCloud文件和目录和本地文件目录一样，应用使用相同的技术来管理文件和目录。你可以打开、创建、移动、复制、读取、写入、删除、以及其它操作。本地文件目录和iCloud文件目录的唯一区别是访问的URL不同。本地文件目录的URL相对于应用Sandbox，而iCloud文件目录的URL则相对于相应的iCloud容器目录。
 
 要移动一个文件或目录到iCloud：
 
 在应用Sandbox中创建本地文件或目录。使用的时候，必须由file presenter来管理文件或目录。如UIDocument
 使用  URLForUbiquityContainerIdentifier: 方法获取iCloud容器目录的URL
 使用容器目录URL来构建一个新的URL，指定文件或目录在iCloud中的存储位置
 调用 NSFileManager 的 setUbiquitous:itemAtURL:destinationURL:error: 方法移动文件或目录到iCloud。绝对不要在应用的主线程中调用这个方法，否则可能会长时间阻塞主线程，或者与应用所拥有的file presenter产生死锁。
 移动一个文件或目录到iCloud时，系统从应用Sandbox中复制该item到private本地存储，这样才能被iCloud daemon监测到。尽管文件此时已经不在应用Sandbox中，应用仍然对其拥有完全访问。虽然文件仍然有一份拷贝保留在当前设备的本地，文件同时还发送到了iCloud，这样就能分布到其它设备去。iCloud daemon处理了所有工作，确保本地拷贝与iCloud是相同的。因此从应用的角度来说，文件就是在iCloud中。
 
 你对iCloud中的文件和目录的所有修改都需要使用一个 file coordinator 对象。包括移动、删除、复制、重命名等操作。file coordinator确保iCloud daemon不会同时修改文件或目录，并确保你修改时能够及时地通知其它人。
 
 命名文件和目录时，尽量使用字母数字，避免使用特殊标点和其它特殊字符。同时你还应该假设文件名是大小写不敏感的（因为iCloud支持Windows）。最后尽量保持文件名简单，以确保这些文件能够在不同文件系统中正确地处理。
 
 选择一种响应版本冲突的策略
 iCloud文件的版本冲突不可避免，因此应用必须对冲突采取一种解决策略。当应用的两个实例同时修改一个文件并传输给iCloud时就会发生冲突。iCloud会保存所有冲突的版本，并通知应用的file presenter发生了冲突需要解决。
 
 App应该尽快地尝试解决版本冲突，当冲突发生时，其中一个文件被指定为current file，其它所有版本都是冲突版本。当前文件和冲突版本文件都由 NSFileVersion 对象来管理，可以通过类方法来获取。
 
 解决冲突：
 
 使用类方法 currentVersionOfItemAtURL: 获取当前文件版本
 使用类方法 unresolvedConflictVersionsOfItemAtURL: 获取所有冲突版本的数组
 对每个file version对象，执行以下任何动作来解决冲突：[list=1]
 如果实际可行的话，合并冲突文件修改的数据
 如果能够安全地执行而不丢失数据的话，忽略某个冲突版本
 提示用户选择保留哪个版本的文件（当前文件或冲突文件），这是最后的选择。
 更新当前文件：
 
 如果当前文件胜利（winner），不需要更新当前文件
 如果某个冲突版本胜利（winner），使用 coordinated write 操作，以冲突版本的文件内容覆盖当前文件
 如果用户选择保存冲突版本为另一个名字，以该冲突版本的内容创建一个新文件
 设置所有冲突版本对象的 resolved 属性为YES。设置这个属性会导致冲突版本对象（及相应的文件）从用户的iCloud storage中删除。如果使用UIDocument类，你通过 observing 文档状态变化通知，并检查  documentState 属性来判断是否发生冲突
 如果使用自定义 file presenter，每当报告有一个新版本时，你都应该检查它是否冲突版本。
 
 整合查找（Search）到应用基础架构
 和应用Sandbox不同，iCloud中的文件添加和删除，你的应用可能都不会直接知道。在这台设备上创建的文件，最终会出现在另一台设备中。如果应用不主动查找文件，那就不能及时地出现在用户界面中。因此应用需要使用 NSMetadataQuery 对象来查找iCloud容器目录中的文件或目录。
 
 当应用在前台时，你可以保留一个 metadata query 一直运行，来接收文件添加或删除的通知；应用进入后台时，就停止这个 metadata query 查询。
 
 
 只有 iCloud 启用，并且相应的容器目录已经创建时，metadata查询才会有返回结果。在运行时，确保使用 URLForUbiquityContainerIdentifier: 方法来检测iCloud已经启用，而且应用支持的容器目录也可用。这个方法在容器目录不存在时，会自动创建出来。
 
 
 Metadata 查找应用entitlement中设置的所有容器目录，并返回合并后的所有结果。如果你希望只查找一个容器目录，可以使 用 URLForUbiquityContainerIdentifier: 方法来获得该容器目录的URL，然后使用 NSFileManager 类来获取目录内容的静态列表。
 
 
 确定文件或目录的传输状态
 你写到iCloud容器目录的item会尽可能快地自动传输到iCloud服务器。但是由于网络和设备类型的原因，文件或目录可能不会立即下载到设备或上传到服务器。如果你需要确定文件的状态，可以使用 NSURL 的 getResourceValue:forKey:error: 方法，来获取以下属性的值：
 
 NSURLIsUbiquitousItemKey：表示item是否存储在iCloud
 NSURLUbiquitousItemIsDownloadedKey：表示当前版本是否已经下载并且可访问
 NSURLUbiquitousItemIsDownloadingKey：表示当前版本是否正在下载并且暂时不可用
 NSURLUbiquitousItemPercentDownloadedKey：对于正在下载的item，表示已经下载的修改的百分比。可以使用这个值来更新进度条。
 NSURLUbiquitousItemIsUploadedKey：表示本地的修改是否成功上传到iCloud服务器
 NSURLUbiquitousItemIsUploadingKey：表示本地的修改是否正在上传到服务器
 NSURLUbiquitousItemPercentUploadedKey：对于正在上传的item，表示当前已经上传的修改的百分比
 
 虽然iCloud服 务器会非常努力地拉取应用在本地做的修改，但是iOS设备通常却不会主动从服务器拉取修改，除非你试图访问该文件。如果你试图打开一个正在下载的文 件，iOS会阻塞发起打开请求的线程，直到文件被完全下载并且可用。因此如果你担心潜在的延迟，就根据需要检查文件的当前状态，同时更新用户界面，提示用 户当前文件正在下载，暂时不可用。
 
 
 使用尚未下载完成的文件
 iCloud中的文件发生改变时，iOS设备不会自动下载这些修改数据。相反iOS设备会下载文件的元数据，因此知道此时文件已经有修改。实际修改的数据只有以下情况发生时，才会被下载：
 
 应用试图打开或访问文件
 应用调用 startDownloadingUbiquitousItemAtURL:error: 方法，显式地下载文件修改
 如果应用打开尚未下载完成的文件，用于打开文件的 file coordinator 会阻塞你的应用，直到文件或修改被完全下载。如果文件或修改比较大，可能会导致很差的用户体验，因此试图打开一个文件之前，应该首先检查文件的下载状态。NSURL 类定义了iCloud item相关的属性，可以检查iCloud文件的状态
 
 
 检查文件是否已经下载完成：
 - (BOOL)downloadFileIfNotAvailable:(NSURL*)file {
 NSNumber*  isIniCloud = nil;
 
 if ([file getResourceValue:&isIniCloud forKey:NSURLIsUbiquitousItemKey error:nil]) {
 // If the item is in iCloud, see if it is downloaded.
 if ([isIniCloud boolValue]) {
 NSNumber*  isDownloaded = nil;
 if ([file getResourceValue:&isDownloaded forKey:NSURLUbiquitousItemIsDownloadedKey error:nil]) {
 if ([isDownloaded boolValue])
 return YES;
 
 // Download the file.
 NSFileManager*  fm = [NSFileManager defaultManager];
 [fm startDownloadingUbiquitousItemAtURL:file error:nil];
 return NO;
 }
 }
 }
 
 // Return YES as long as an explicit download was not started.
 return YES;
 }
 
 
 为iCloud调整用户界面
 所有为了iCloud所做的用户界面调整，都应该尽量不引人注意。当iCloud不可用时，你存储在iCloud中的文档和你存储在本地是完全一样的。唯一的区别是文件系统中的位置。因此大部分用户界面都应该保持一致。
 
 
 以下情况可能需要针对iCloud修改用户界面：
 
 当用户生成的文档在使用之前必须被下载。只有你提供了文档浏览器，才需要让用户来控制是否下载文档。应用使用的私有文件，应该在不可用时自动去服务器下载。你用来提示用户的信息应该尽量友好，并提供用户“开始文档下载”的选项。如果下载时间可能超过几秒钟，你需要显示一个当前下载进度。
 当出现必须由用户解决的版本冲突。如果应用需要用户协助，才能解决冲突，就应该友好地提示冲突信息，但千万不要显示警告，或其它任何破坏性的界面。
 当你希望提供用户选项，为应用启用或禁用iCloud时。如果应用包含一个Settings Bundle或者内部的参数设置，你可以提供一个参数，让用户选择是否使用iCloud。
 
 
 iCloud结合Database使用
 只有应用使用Core Data来管理数据库时，才能将SQLite数据库整合到iCloud。不支持使用SQLite接口访问iCloud中的live数据库，这样做很可能会毁坏你的数据库。
 
 
 但是只要你遵守一些额外的步骤，来设置Core Data结构，你就可以创建基于SQLite的Core Data，从而启用iCloud支持。当然，其它类型的Core Data Store（不基于SQLite），则无需修改可以直接支持iCloud。
 
 
 使用Core Data和SQLite store时，实际的数据库文件不会传输到iCloud服务器。相反，每个设备都维护自己的SQLite store拷贝，并通过将修改写入到日志文件来同步它的内容。设备与iCloud之间真正传输的是log file，在每个设备中，Core Data拿到log file的内容，然后使用这些内容来更新本地数据库。当然最终的效果就是每个本地数据库都拥有完全相同的修改。
 
 
 设置Core Data store来处理iCloud，只需要你执行很少的额外工作。但是具体的步骤取决于你使用Core Data store作为中央库（Central Library），还是为单个文档分别创建独立的Core Data Store。
 
 
 使用Core Data管理文档
 应 用管理Core Data store为单独的文档时，可使用 UIManagedDocument 对象来管理单个文档。UIManagedDocument 类自动在应用bundle中查找所有managed object model，并使用它们作为文档数据的基础（你也可以覆盖 managedObjectModel 属性自定义指定子类的object models）。由于大部分数据由managed object context处理，意味着你通常可以直接使用 UIManagedDocument 类而不需要继承子类。UIDocumemnt的自动保存行为，能够自动处理所有文档的保存工作。
 
 
 创建新文档时，执行以下步骤：
 
 创建 UIManagedDocument 对象
 文档的 persistentStoreOptions 属性是一个Dictionary，添加一个 NSPersistentStoreUbiquitousContentNameKey 键，值为你标识该文档的唯一名字。
 添加一些初始化数据到文档
 使用 saveToURL:forSaveOperation:completionHandler: 方法将文档保存到磁盘。保存文档时，你也可以直接将它保存到iCloud；或者先保存在本地目录，然后再移动到iCloud。保存到iCloud需使用 URLForUbiquityContainerIdentifier: 方法获得相对iCloud的URL；如果已经保存到本地，则可以使用 setUbiquitous:itemAtURL:destinationURL:error: 方法将其移到iCloud
 当 你创建一个新文档时，Core Data创建一个file package，包含文档的内容。这些内容有一个 DocumentMetadata.plist 文件，以及一个包含SQLite data store的目录。除了SQLite data store（保留在本地），file package中的任何东西都会被传输到iCloud服务器。
 
 
 打开iCloud中的现有文档时，执行以下步骤：
 
 使用 NSMetadataQuery 查找iCloud中的文档，Metadata查找会标识你iCloud中的所有Core Data文档。如果文档是其它设备创建，文档file package最初只有 DocumentMetadata.plist 一个文件。
 打开 DocumentMetadata.plist 文件，并获取 NSPersistentStoreUbiquitousContentNameKey 键的值
 创建 UIManagedDocument 对象
 添加 NSPersistentStoreUbiquitousContentNameKey 键到文档的 persistentStoreOptions 属性。这个键的值就是你在第2步中获取的值
 调用文档对象的 openWithCompletionHandler: 方法来打开文档
 应 用第一次打开其它设备创建的Core Data文档时，Core Data会自动检测到SQLite store不存在，并在本地创建一个。然后使用 NSPersistentStoreUbiquitousContentNameKey 键的值（你添加到属性的那个）来获取适当的transaction logs，并重新构建数据库的内容。从这时候开始，你就可以修改该文档并保存到iCloud。你所做的修改会保存到新的log file，这样其它设备就能将其整合到它们的SQLite store。
 
 
 当应用从iCloud中 接收到文档修改时，Core Data会自动将这些修改合并到文档的SQLite store，并给应用发 送 NSPersistentStoreDidImportUbiquitousContentChangesNotification 通知。应用必须注册这个通知，并使用它来刷新任何修改的记录。如果应用不刷新本地的数据拷贝，就会将老的修改重新写到iCloud，并产生一个冲突版本。通过及时地整合其它设备的修改，应用就能避免类似的冲突。
 
 
 删 除一个文档时，你必须同时删除文档的file package，以及包含文档transaction logs的目录。同时删除所有这些东西，要求你使用 NSFileCoordinator 对象来执行coordinated写入操作。文档的DocumentMetadata.plist 文件包含一个 NSPersistentStoreUbiquitousContentURLKey 键，它的值就是文档transaction logs目录的URL。
 
 
 使用Core Data管理中央库（Central Library）
 如果应用使 用Central Core Data store来管理数据，就应该将data store直接存放在应用Sandbox目录。使用一个Central data store的应用，通常只有一个persistent store coordinator对象和一个persistent store对象。因此，最简单的解决办法是将Core Data store保留在应用Sandbox，仅使用iCloud来同步修改。
 
 
 在本地创建SQLite store时，执行以下步骤：
 
 创 建data store时，调用 addPersistentStoreWithType:configuration:URL:options:error: 方法，并在传递的options Dictionary中包含 NSPersistentStoreUbiquitousContentNameKey 和 NSPersistentStoreUbiquitousContentURLKey 键。
 注册 NSPersistentStoreDidImportUbiquitousContentChangesNotification 通知，并使用它来更新所有的记录更新。
 因为你只有一个data store，你可以为 NSPersistentStoreUbiquitousContentNameKey 键指定任何名字。对于 NSPersistentStoreUbiquitousContentURLKey 键，应该指定为应用某个iCloud容 器目录中的某个目录URL。换句话说，这个URL应该基于 URLForUbiquityContainerIdentifier: 方法返回的URL构造而成。Core Data将修改写入到你指定的这个目录，其它设备则在这个目录中查找修改。当检测到修改时，Core Data会自动整合修改到本地的SQLite store，并通知你的应用。
 
 
 同样，你也必须及时地响应iCloud相关的修改通知。这些通知使应用能确保使用最新的数据，如果你使用老版本的数据，就可能覆盖其它设备的新数据，并产生冲突版本。
 
 
 为Core Data Transaction Logs指定自定义位置
 应用Core Data Store的修改使用transaction logs来保存，这些logs存储在用户iCloud账户的一个特殊目录中。应用的所有Core Data Stores全部使用同一个目录来保存transaction logs。默认情况下，这个目录的名字和应用bundle ID相同，并保存在应用默认iCloud容器目录中。如果你已经使用这个目录作为其它用途，你可以通过修改Core Data stores的选项来修改目录的名字。
 
 
 在 基于文档的应用中，要自定义transaction logs目录，必须修改每个 UIManagedDocument 对象的 persistentStoreOptions 属性Dictionary。在字典中增加 NSPersistentStoreUbiquitousContentURLKey 键，并设置值为你希望使用的自定义目录URL。这个URL需要首先使用 URLForUbiquityContainerIdentifier: 方法，并通过添加额外的路径来扩展URL。
 
 
 如果应用使用单一的Core Data store管理所有数据，在创建 persistent store时，调用 addPersistentStoreWithType:configuration:URL:options:error: 方法，并在options参数中增加  NSPersistentStoreUbiquitousContentURLKey 键，值也是你希望设置的目录URL。
 
 
 
 使用iCloud Key-Value Data Storage
 应用使用iCloud Key-Value data storage来存储参数、或小量的非关键配置数据。key-value data storage概念上类似于本地user defaults数据库，应用通常用来存储配置。区别在于iCloud数据在用户所有设备中你的所有应用实例间共享。
 
 
 使 用 NSUbiquitousKeyValueStore 类需要设置"com.apple.developer.ubiquity-kvstore-identifier" Entitlement，如果多个不同的应用配置相同的entitlement值，则这些应用都可以共享相同的key-value数据。
 
 
 使用 NSUbiquitousKeyValueStore 类写入数据到iCloud key-value store，这个类概念上也类似于 NSUserDefaults，用于保存和获取简单的数据类型：数字、字符串、日期、数组等等。
 
 
 应 用的key-value store的容量限制为64KB（而每个键的限制当前也是64KB）。因此应用只能使用key-value storage记录很少的数据，不能用于存储用户文档或其它大型数据archive。典型的例子是杂志应用，可以保存用户当前阅读的刊物和页数。这样用户 在其它设备打开相同应用时，就能回到之前阅读的位置。
 
 
 NSUbiquitousKeyValueStore 类绝对无法代替 NSUserDefaults 类，应用总是应该通过 NSUserDefaults 将所有配置数据保存在本地磁盘。然后再使用 NSUbiquitousKeyValueStore 将需要共享的数据上传到key-value store。这样确保iCloud不可用时，你仍然能够访问应用的配置数据。
 */

@end
