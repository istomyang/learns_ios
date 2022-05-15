//
//  LIWeirdCodeShow.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import <Foundation/Foundation.h>

@interface  LIOWeirdCodeShow: NSObject

@end

// 奇怪的Objc写法
// https://blog.sunnyxx.com/2014/08/02/objc-weird-code/

@implementation LIOWeirdCodeShow

// MARK: 小括号内联复合表达式
- (void)f1
{
    [self f1_0:({
        NSString *str = @"";
        str; // 返回值
    })];
}

- (void)f1_0:(NSString *)str {
    NSLog(@"%@", str);
}

@end
