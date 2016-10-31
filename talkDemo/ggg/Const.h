#import "UIColor+HexColor.h"

/*=================================常规===============================================*/

//data转字典
#define JSON_TO_DICT(data)  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]

//AppDelegate
#define AppDelegatee (ETAppDelegate*)[UIApplication sharedApplication].delegate

//NSUserDefault
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

// 加载本名的Nib文件
#define SELF_NIB ([[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject])

/*=================================尺寸(适配)===============================================*/
// 当前视图控制器的视图的size
#define VIEW_SIZE (self.view.frame.size)

// 屏幕宽度和高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 自动适配宽度,width为原始iPhone4/5的宽度
#define AUTO_MATE_WIDTH(width) ((width) * SCREEN_WIDTH / 320.0)
// 自动适配高度,width为原始iPhone4/5的高度
#define AUTO_MATE_HEIGHT(height) ((height) * SCREEN_HEIGHT / 568.0)

/*=================================UI===============================================*/
// 自定义字体
#define MyFont(theSize) ([UIFont fontWithName:@"MicrosoftYaHei" size:theSize])
//字体
#define systemFont(font) ([UIFont systemFontOfSize:font])
#define boldSystemFont(font) ([UIFont boldSystemFontOfSize:font])
// 自动适配字体,fontsize为原始iPhone4/5的宽度
#define AUTO_MATE_FONTSIZE(fontsize) (SCREEN_WIDTH == 375 ? (fontsize) : (fontsize) - 1)

//颜色
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//16进制色
#define hexColor(colorV) [UIColor colorWithHexColorString:@#colorV]
#define hexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];
//主色调
#define mainColor hexColor(3A5899)
//背景色
#define backdropColor hexColor(f3f3f3)

//状态栏高度
#define STATUS_BAR_HEIGHT 20.0
//导航栏高度
#define NAVBAR_HEIGHT 44.0
//状态栏高度 + 导航栏高度
#define STATUS_NAV_HEIGHT 64.0
//tabBar高度
#define TABBAR_HEIGHT 49.0

/*=================================系统===============================================*/

/*
 iOS的版本号，一个叫做Version，一个叫做Build，这两个值都可以在Xcode 中选中target，点击“Summary”后看到。
 
 Version在plist文件中的key是“CFBundleShortVersionString”，和AppStore上的版本号保持一致，
 
 Build在plist中的key是“CFBundleVersion”，代表build的版本号，该值每次build（应该是版本更新）之后都应该增加1。
 
 这两个值都可以在程序中通过下面的代码获得：
 [[[NSBundle mainBundle] infoDictionary] valueForKey:@"key"];
 */
//当前App版本(Version,对外)
#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//当前App版本(Build,对内)
#define CurrentAppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define BundleID [[NSBundle mainBundle] bundleIdentifier]


//appStoreBundleID
#define AppStore [[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.etao.individual"]

//企业版本更新文件
#define CompanyVersionUpdateURLPlist @"https://app.edsmall.cn/etao/ETaoUpdate.plist"
//企业ap下载路径
#define CompanyDownloadURL @"https://app.edsmall.cn/e_tao.html"

//判断是否为模拟器
//#if TARGET_IPHONE_SIMULATOR
//#define iS_SIMULATOR 1
//#elif TARGET_OS_IPHONE
//#define iS_SIMULATOR 0
//#endif

// 判断是否iPhone4-5/iPhone6/plus
#define IS_IPHONE4_5 (SCREEN_WIDTH==320)
#define IS_IPHONE6 (SCREEN_WIDTH==375)
#define IS_IPHONE6_PLUS (SCREEN_WIDTH==414)

//ios系统版本
#define iOS_9x [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f

#define iOS_8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f)

#define iOS_7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
//系统版本
#define appCurrentDevice [[UIDevice currentDevice] systemVersion]
//手机型号仅能获取iPhone,不能获取具体的型号
#define appPhoneModel [[UIDevice currentDevice] model]
//app版本
#define appCurVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define appCurName @"EZG_APP"
//判断是否为模拟器
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

// -------------------- Debug Function --------------------------
//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif



///=============================================
/// @name Weak Object
///=============================================
#pragma mark - Weak Object

/**
 * @code
 * ESWeak(imageView, weakImageView);
 * [self testBlock:^(UIImage *image) {
 *         ESStrong(weakImageView, strongImageView);
 *         strongImageView.image = image;
 * }];
 *
 * // `ESWeak_(imageView)` will create a var named `weak_imageView`
 * ESWeak_(imageView);
 * [self testBlock:^(UIImage *image) {
 *         ESStrong_(imageView);
 * 	_imageView.image = image;
 * }];
 *
 * // weak `self` and strong `self`
 * ESWeakSelf;
 * [self testBlock:^(UIImage *image) {
 *         ESStrongSelf;
 *         _self.image = image;
 * }];
 * @endcode
 */

#define ESWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define ESStrong_DoNotCheckNil(weakVar, _var) __typeof(&*weakVar) _var = weakVar
#define ESStrong(weakVar, _var) ESStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;

#define ESWeak_(var) ESWeak(var, weak_##var);
#define ESStrong_(var) ESStrong(weak_##var, _##var);

/** defines a weak `self` named `__weakSelf` */
#define ESWeakSelf      ESWeak(self, __weakSelf);
/** defines a strong `self` named `_self` from `__weakSelf` */
#define ESStrongSelf    ESStrong(__weakSelf, _self);

