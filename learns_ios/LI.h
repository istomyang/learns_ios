//
//  LI.h
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#pragma mark - 导入公共库

#ifdef __OBJC__
    #import "AppDelegate.h"
    #import "Util/Export.h"

#endif

#pragma mark - 变量

static NSString * const kShowMenuNotification = @"ShowMenuNotificaion";

#pragma mark - 类型

typedef void (^SetUI)(void); // 集合中设置UI的类型

#define APPDELEGATE ((AppDelegate *)UIApplication.sharedApplication.delegate)
