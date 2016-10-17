//
//  WCDefines.h
//  FaZaiUser
//
//  Created by mmwang on 16/4/11.
//  Copyright © 2016年 浙江我财网络科技有限公司. All rights reserved.
//

#ifndef WCDefines_h
#define WCDefines_h

/** 设备信息 **/
#define DEVICE_USERNAME        [[UIDevice currentDevice] name]
#define DEVICE_SYSTEMNAME      [[UIDevice currentDevice] systemName]
#define DEVICE_VESION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DEVICE_IPHONEORPAD     [[UIDevice currentDevice ] userInterfaceIdiom]
#define DEVICE_ISIPAD          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** APP应用信息 **/
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define APP_VERSION            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_NAME               [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/** 系统控件默认高度 **/
#define STATUSBAR_HEIGHT        (20.f)
#define NAVGATIONBAR_HEIGHT     (44.f)
#define TABBAR_HEIGHT           (49.f)
#define ENKEYBOARD_HEIGHT       (216.f)
#define CHKEYBOARD_HEIGHT       (252.f)

/**设备屏幕宽度和高度**/
#define SCREENT_WIDTH   CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREENT_HEIGHT  CGRectGetHeight([[UIScreen mainScreen] bounds])

//用户记录是否第一次进入应用
#define FIRSTSTART @"FirstStart"

//视图背景颜色
#define VIEW_BACKGROUNDCOLOR [UIColor colorWithRed:248.0/255.0 green:248.0/255.0f blue:248.0/255.0f alpha:1.0]

//导航栏宏定义
#define NAV_TITLE_COLOR [UIColor whiteColor]
#define NAV_TITLE_FONT [UIFont systemFontOfSize:18.0]
#define NAV_BACKGROUND_COLOR [UIColor colorWithRed:245.0/255.0 green:129.0/255.0f blue:0.0/255.0f alpha:1.0]
#define NAV_LEFTBUTTON_ICON [UIImage imageNamed:@"nav_left"]

//TabBar宏定义
#define TABBAR_TITLE_COLOR [UIColor colorWithRed:119.0/255.0 green:119.0/255.0f blue:119.0/255.0f alpha:1.0]
#define TABBAR_SELECTED_TITLE_COLOR [UIColor colorWithRed:119.0/255.0 green:119.0/255.0f blue:119.0/255.0f alpha:1.0]
#define TABBAR__TITLEFONT [UIFont systemFontOfSize:10]
//Cache
#define USERLOGIN_CACHE @"UserLoginCache" //用户登录存储

/************************ 其他宏定义 ************************/
//单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;
#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}
#endif /* WCDefines_h */
