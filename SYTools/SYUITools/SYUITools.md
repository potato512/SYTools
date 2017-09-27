# SYTools/SYUITools
UI工具集，基于第三方框架和SYCategory类封装实现。

# 20170425
* SYGuideScrollView添加动画时间属性
~~~ javascript
/// 消失动画时间（默认0.3秒）add by zhangshaoyu 20170425
@property (nonatomic, assign) NSTimeInterval animationTime;
~~~
* 新增数量编辑控件SYNumberEditView

# 20170424
* SYTypeButton修改bug
  * 导航动画线初始化时显示bug

# 20170422
* SYNetworkEnvironment修复bug
* SYWebView添加方法
~~~ javascript
/**
*  加载网页（URL网址）
*
*  @param URL 网址
*/
- (void)loadRequestWithURL:(NSURL *)url;

/**
*  加载网页（NSString网址）
*
*  @param urlStr 网址
*/
- (void)loadRequestWithURLStr:(NSString *)urlStr;

/**
*  加载本地网页（NSString）
*
*  @param html 网页字符串
*/
- (void)loadRequestWithHTML:(NSString *)html;
~~~
* SYTypeButton添加属性及修改默认选项逻辑
  * 默认选项逻辑：只处理选项状态，不响应事件交互。
~~~ javascript
/// 选中后字体大小（默认12。设置标题后设置）
@property (nonatomic, strong) UIFont *titleFontSelected;
~~~

# 20170421
* SYUIInitMethod方法完善按钮实例化方法
  * UIButton添加高亮图标属性
  * UIBarButtonItem添加高亮图标属性


# 20170407
 * SYGiudeView
 * SYImageBrowse
 * SYIToast
 * SYNetworkEnvironment
 * SYNetworkStatusView
 * SYPopupTableView
 * SYProgressWebView
 * SYTypeButton
 * SYUIInitMethod
 * SYAutoSizeCGRect
 * SYCountDownButton
 * SYTableView
 * SYCollectionView
 * SYTextField
 * SYTextView
 * SYWebView
