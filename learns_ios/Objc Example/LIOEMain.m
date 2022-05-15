//
//  LIOEMain.m
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

#import "LIOEMain.h"

@implementation LIOEMain

#pragma mark - 单例写法
+ (instancetype)shared {
    static dispatch_once_t once;
    static LIOEMain * intance;
    dispatch_once(&once, ^{
        intance = [[LIOEMain alloc] init];
    });
    return intance;
}

#pragma mark - available写法
+ (BOOL)available_example OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0) {
    if (@available(iOS 10, macOS 10.12, *)) {
        // ios10, macOS 10.12 以上版本
    } else {
        // 以下版本
    }
    return false;
}

@end
