//
//  LIHeyRuntime.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import <Foundation/Foundation.h>

// TODO: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtInteracting.html#//apple_ref/doc/uid/TP40008048-CH103-SW1

@interface OneClass: NSObject
- (void)sayHey;
@end

@interface LIHeyRuntime : NSObject

@end

@implementation LIHeyRuntime

- (void)f1 {
    Class class = NSClassFromString(@"OneClass");
    OneClass *oneClass = [[class alloc] init];
    [oneClass sayHey];
}

@end

@implementation OneClass
- (void)sayHey {
    NSLog(@"Hey, World!");
}
@end
