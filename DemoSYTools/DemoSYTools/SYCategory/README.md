# SYCategory
自定义UIKit、Foundation的类别，以适应在研发过程中常使用到的功能，提高开发效率。

[UIKit类别]
 * UILabel：自适应宽高、修改内容（指定文字颜色，大小，间距）
 * UIView：原点坐标设置、显示标签（内容，字体大小/颜色，对齐方式）、手势功能、缩放、旋转、翻转
 * UIButton：图标对齐方式、倒计时功能、block响应回调
 * UISlider：block响应回调
 * UISwitch：block响应回调
 * UIColor：十六进制颜色、随机颜色
 * UIImage：纯色图片、图片拉升、截图、压缩、裁剪、位图处理、滤镜、相册图片、保存
 * UIGestureRecognizer：block响应回调
 * UIViewController：根视图判断、导航栏标题、导航栏视图、导航栏返回按钮、导航栏右按钮
 * UINavigationController：导航栏样式
 * UIAlertView：block响应回调
 * UIActionSheet：block响应回调
 * UITextField：输入限制
 * UITextView：输入限制
 * UIImagePickerController：block响应回调

[Foundation类别]
 * NSString：其他对象的互换、数字/金额等的处理、特殊字符的限制
 * NSFileManager：文件操作、目录操作
 * NSAttributedString：副文本字符串处理
 * NSNumber：
 * NSObject：图片类型判断、文本字符宽高计算、结束编辑处理
 * NSArray：异常判断、排序、元素操作
 * NSDictionary：异常判断
 * NSTimer：
 * NSURLConnection：请求block回调处理
 * NSDate：日期处理
 * NSNotificationCenter：
 * NSUserDefaults：
 * NSPredicate：正则判断


# 修改完善
* 20180305
  * 版本号：1.2.0
  * 添加类扩展NSPredicate

* 20180207
  * 版本号：1.1.9
  * NSString添加类别
    * NSString+SYUUID
    * NSString+SYHtml
    * NSString+SYNetwork

* 20180130
  * 版本号：1.1.8
  * NSAttributedString添加方法处理html
  * 添加NSString类别，处理html

~~~ javascript
/// html源码转NSAttributedString
- (NSAttributedString *)attributedHtml:(NSString *)html;
~~~ 

~~~ javascript
/// html包含图片
- (BOOL)htmlContantImage;

/// html中图片大小自适应屏幕大小
- (NSString *)htmlStringImageAutoSize;

/// 修改html中图片大小的js代码
- (NSString *)htmlStringJSImageSizeWidth:(float)width;

/// 修改html的文字大小
- (NSString *)htmlStringFontSize:(int)fontsize;

/// 过滤html中的图片数组
- (NSArray *)htmlStringFilterImages;
~~~


* 20180108
  * 版本号：1.1.7
  * NSAttributed下划线/删除线在iOS10.3.1显示异常处理

* 20171226
  * 版本号：1.1.6
  * UIView添加类别（设置状态视图）
  * NSString添加UUID方法
  * UIImagePickerController添加设置导航栏属性、图片编辑方法
  * UITextView屏蔽dealloc方法（避免iOS8.x版本闪退）
  * UITextField屏蔽dealloc方法（避免iOS8.x版本闪退）


* 20171110
  * 版本号：1.1.5
  * view添加字符设置方法：分行、自适应字体大小
  * view添加设置背景图方法

* 20171017
  * 版本号：1.1.4
  * SYCategoryFoundation
    * NSNotificationCenter异常

* 20170828
  * 版本号：1.1.3
  * SYCategoryFoundation
    * NSAttributedString修改异常
    * NSMutableArray添加方法
    * NSMutableDictionary添加方法
    * NSMutableString添加方法


~~~ javascript
/// 添加元素（安全的）
- (NSMutableArray *)addObjectSafety:(id)object;

/// 添加元素到指定位置（安全的）
- (NSMutableArray *)insertObjectSafety:(id)object atIndex:(NSInteger)index;

/// 用指定的元素替换指定位置的元素（安全的）
- (NSMutableArray *)replaceObjectSafety:(id)object atIndex:(NSInteger)index;

/// 添加数组中的所有元素（安全的）
- (NSMutableArray *)addObjectsFromArraySafety:(NSArray *)array;
~~~

~~~ javascript
/// 添加指定元素object（安全的）
- (NSMutableDictionary *)setObjectSafety:(id)object forKey:(NSString *)key;

/// 添加指定元素value（安全的）
- (NSMutableDictionary *)setValueSafety:(id)object forKey:(NSString *)key;
~~~

~~~ javascript
/// 重置字符串（安全的）
- (NSMutableString *)setStringSafety:(NSString *)string;

/// 添加字符串（安全的）
- (NSMutableString *)appendStringSafety:(NSString *)string;

/// 插入字符串（安全的）
- (NSMutableString *)indsertStringSafety:(NSString *)string atIndex:(NSInteger)index;

/// 替换字符串（安全的）
- (NSMutableString *)replaceStringSafety:(NSString *)currentString withString:(NSString *)replaceString;
~~~

* 20170824
  * 版本号：1.1.2
  * SYCategoryFoundation
    * NSNumber添加数字转换方法

~~~ javascript
/// 阿拉伯数字转罗马大写（如：1为一）
- (NSString *)numberConvertedUpperRoman;

/// 阿拉伯数字转中文大写（如：1为壹）
- (NSString *)numberConvertedCNCapital;
~~~

* 20170823
  * 版本号：1.1.1
  * SYCategoryFoundation
    * NSDate添加时间差集方法

~~~ javascript
/// 获取任意时间两个时间差集（keySecond秒、keyMinute分、keyHour时、keyDay日、keyMonth月、keyYear年）
+ (NSDictionary *)getTimeDistanceWithTimeInterval:(NSTimeInterval)time endTimeInterval:(NSTimeInterval)endTime;

/// 获取任意时间两个时间差集（keySecond秒、keyMinute分、keyHour时、keyDay日、keyMonth月、keyYear年）
+ (NSDictionary *)getTimeDistanceWithTimeInterval:(NSTimeInterval)time;
~~~

* 20170822
  * 版本号：1.1.0
  * SYCategoryUIKit
    * UIView添加shapeLayer设置边框属性

~~~ javascript
/// 设置UI视图的shape边框属性（圆角、边框颜色、边框大小，是否虚线）
- (void)shapeLayerWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width isDotted:(BOOL)isDotted;

/// 设置视图的shape边框属性-圆角
@property (nonatomic, assign) CGFloat shapeCornerRadius;

/// 设置视图的shape边框属性-边框颜色
@property (nonatomic, strong) UIColor *shapeBorderColor;

/// 设置视图的shape边框属性-边框大小
@property (nonatomic, assign) CGFloat shapeBorderWidth;

/// 设置视图的shape边框属性-是否虚线
@property (nonatomic, assign) BOOL shapeBorderDotted;
~~~

* 20170803
  * NSAttributedString异常修改
  * 版本号：1.0.2

* 20170802
  * NSDate类别功能完善
  * UIView添加视图拖动属性
  * 版本号：1.0.1

* 20170726
  * 版本号：1.0.0
  * 通知功能完善

* 20170704
  * 添加链式编程属性：
    * UIView/UILabel/UITextField/UITextView/UISlider/UISwitch/UIImageView
    * UIViewController
    * NSMutableArray/NSMutableDictionary/NSAttributedString/NSFileManager/NSString/NSMutableString


* 20170702
  * 添加类别文件：UIDocument+SYCategory（待完善）、NSFileManager+iCloud（待完善）、NSStream+SYCategory（待完善）
  * 完善类型方法：NSFileManger+SYCategory

~~~ javascript
/**
*  指定文件路径的当前层级的文件夹
*
*  @param filePath 文件路径
*
*  @return NSArray
*/
+ (NSArray *)getDirectorysWithFilePath:(NSString *)filePath;

/**
*  指定文件路径的所有层级的文件，子文件
*
*  @param filePath 文件路径
*
*  @return NSArray
*/
+ (NSArray *)getFilesWithFilePath:(NSString *)filePath;
~~~

* 20170701
  * 添加类别文件：NSFileHandle+SYCategory
  * 完善类别方法：NSFileManager+SYCategory

* 20170628
  * UIImage方法修改

~~~ javascript
// 废除：获取图片，根据图片url（如：url = http://.../xxx.jpg）
+ (UIImage *)imageWithUrl:(NSString *)url;

/// 新增：获取图片，根据图片url-缓存功能（如：url = http://.../xxx.jpg）
+ (void)imageWithUrl:(NSString *)url complete:(void ((^)(UIImage *image)))complete;
~~~

* 20170627 
  * UIImage添加纯色生成图片方法
~~~ javascript
/// 生成指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;
~~~

* 20170608
  * NSAttributedString+SYCategory bug修改，并添加返回值
  * UILabel+SYCategory bug修改

* 20170518
  * UIView+SYCategory修改完善

* 20170510
  * NSTimer完善方法

~~~ javascript
/// 倒计时-添加延时执行时间
+ (void)timerGCDWithTimeInterval:(NSTimeInterval)time maxTimerInterval:(NSInteger)maxTime afterTime:(NSTimeInterval)afterTime handle:(void (^)(NSInteger remainTime))handle;
~~~

* 20170423
  * NSObject添加响应回调方法

~~~ javascript
/// 监听响应，同时进行回调响应
- (void)observerForKeyPath:(NSString *)keyPath complete:(void (^)(NSString *key, id object, NSDictionary *change))complete;

/// 编辑控件输入响应（object为text）
- (void)observerTextEditComplete:(void (^)(id object))complete;
~~~

* 20170421
  * NSTimer添加实例化方法（回调响应 & 子线程模式）

~~~ javascript
/// 实例化NSTimer（无须处理强引用 & 回调响应）
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)time userInfo:(id)userInfo repeats:(BOOL)isRepeat handle:(void (^)(NSTimer *timer))handle;

/// 倒计时
+ (void)timerCountdownWithTimeInterval:(NSTimeInterval)time maxTimerInterval:(NSInteger)maxTime handle:(void (^)(NSInteger remainTime))handle;
~~~

* 20170420
  * NSObject添加KVO类别方法（回调响应）
  * NSNotificationCenter添加方法（回调响应）

~~~ javascript
/// 监听响应，同时进行回调响应
- (void)observerComplete:(void (^)(id object))handle;
~~~

~~~ javascript
/**
*  发送通知
*  add by zhangshaoyu, 2017-04-20
*  @param name 通知名称
*  @param dict 通知携带参数
*/
- (void)postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)dict;

/**
*  接收通知
*  add by zhangshaoyu, 2017-04-20
*  @param name   通知名称
*  @param target 响应对象
*  @param action 响应方法
*/
- (void)receiveNotificationWithName:(NSString *)name target:(id)target selector:(SEL)action;

/**
*  接收通知并执行回调
*  add by zhangshaoyu, 2017-04-20
*  @param name   通知名称
*  @param handle 响应回调
*/
- (void)receiveNotificationWithName:(NSString *)name handle:(void (^)(NSNotification *notification))handle;

/**
*  移除通知
*  add by zhangshaoyu, 2017-04-20
*  @param name   通知名称
*  @param target 响应对象
*/
- (void)removeNotificationWithName:(NSString *)name target:(id)target;
~~~

* 20170419
  * NSNotificationCenter添加方法（回调响应）

~~~ javascript
/**
*  发送通知
*  add by zhangshaoyu, 2017-04-20
*  @param name 通知名称
*  @param dict 通知携带参数
*/
- (void)postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)dict;

/**
*  接收通知
*  add by zhangshaoyu, 2017-04-20
*  @param name   通知名称
*  @param target 响应对象
*  @param action 响应方法
*/
- (void)receiveNotificationWithName:(NSString *)name target:(id)target selector:(SEL)action;

/**
*  接收通知并执行回调
*  add by zhangshaoyu, 2017-04-20
*  @param name   通知名称
*  @param handle 响应回调
*/
- (void)receiveNotificationWithName:(NSString *)name handle:(void (^)(NSNotification *notification))handle;

/**
*  移除通知
*  add by zhangshaoyu, 2017-04-20
*  @param name   通知名称
*  @param target 响应对象
*/
- (void)removeNotificationWithName:(NSString *)name target:(id)target;
~~~

* 20170414
  * NSString修改异常

* 20170413
  * UITextField添加属性
  * UITextView添加属性
  * 修改输入字符限制（中文联想导致异常），只能输入指定字符，不能输入指定字符。
  * NSString添加方法

~~~ javascript
/// 限制输入指定字符（不需要结合通知使用）
@property (nonatomic, strong) NSString *allowedText;
~~~

~~~ javascript
/// 限制输入指定字符（不需要结合通知使用）
@property (nonatomic, strong) NSString *allowedText;
~~~

~~~ javascript
/// 是否包含子字符串
- (BOOL)isContantSubtext:(NSString *)text;
~~~

* 20170412
  * UITableView添加方法
  * NSString添加方法

~~~ javascript
/// 动态滚动到指定位置
- (void)scrollAtIndex:(NSInteger)section row:(NSInteger)row position:(UITableViewScrollPosition)position;
~~~ 

~~~ javascript
/// 是否包含指定的字符
- (BOOL)isContantSomeCharacters:(NSString *)characters;

/// 字符等级强弱度识别（1弱；2中；3强）
- (NSInteger)textStrengthGrade;

/// 是否是指定的字符类型
- (BOOL)isContantWithText:(NSString *)text;

/// 字符串是大小写英文
- (BOOL)isENNString;

/// 字符串是大写英文
- (BOOL)isUppercaseNSString;

/// 字符串是小写英文
- (BOOL)isLowercaseNSString;

/// 判断当前字符类型（NO中文字符；YES英文字符）
- (BOOL)isENCharacter;

/**
*  限制不能输入指定字符回调
*
*  @param text    限制不能输入的字符串
*  @param regular 回调
*/
- (void)regularWithText:(NSString *)text limitedHandle:(void (^)(NSInteger))regular;

/**
*  限制只能输入指定字符回调
*
*  @param text    限制只能输入的字符串
*  @param regular 回调
*/
- (void)regularWithText:(NSString *)text allowedHandle:(void (^)(NSInteger))regular;

/**
*  限制输入指定字符回调
*
*  @param text    限制指定字符串
*  @param islimit 是限制输入，还是允许输入
*  @param regular 回调
*/
- (void)regularWithText:(NSString *)text limited:(BOOL)islimit handle:(void (^)(NSInteger index))regular;
~~~


