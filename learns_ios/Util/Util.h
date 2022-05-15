//
//  Util.h
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "Import.h"

#ifndef Util_h
#define Util_h

#pragma mark - 配置

// 如果是发布版本，注释下一行
#define TEST

// SDK版本判断
#ifndef __IPHONE_10_0
#warning "This project uses features only available in iOS SDK 10.0 and later."
#endif

#pragma mark - 函数(ALL)

// UIKit
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

// 数学
#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))


#pragma mark - 函数(DEBUG)
#ifdef TEST
/// 日志函数
#define Log(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__]);
#define LogI(...) NSLog(@"Info: %@", [NSString stringWithFormat:__VA_ARGS__]);
#define LogE(...) NSLog(@"Error: %@", [NSString stringWithFormat:__VA_ARGS__]);
#else
#define Log(...)
#define LogI(...)
#define LogE(...)
#endif


#pragma mark - 工具函数

UIColor *U_RandomColor(void);





#endif /* Util_h */
