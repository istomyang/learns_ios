//
//  LIHeyObjc.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import <Foundation/Foundation.h> // 防止重复导入

// Objc学习
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210


typedef void (^SetUIBlock)(void); // 块签名

#pragma mark - Interface

@interface LIPerson : NSObject // 命名规范
@property NSString *a; // 可省略
@property(atomic, readwrite, strong) NSString *firstName; // 这是默认
@property(atomic, readwrite, assign) NSInteger age; // 这是默认
@property(nullable, nonatomic, readonly, strong) NSString *lastName;

-(void)sayHey;
-(void)sayHeyTo:(NSString *)name;
-(NSString *)sayHeyTo:(NSString *)name1 and:(NSString *)name2;
-(NSString *)sayHeyTo:(NSString *)name1 also:(NSString *)name2; // 同签名

+(instancetype)create; // 类方法
@end

@implementation LIPerson
-(instancetype)init:(NSString *)firstName and1:(NSString *)lastName andAge:(NSInteger)age {
    self = [super init];
    if (self) {
        _a = @"";
        _firstName = firstName;
        _lastName = lastName;
        _age = age;
    }
    return self;
}

-(void)sayHey {}
-(void)sayHeyTo:(NSString *)name {}
-(NSString *)sayHeyTo:(NSString *)name1 and:(NSString *)name2 { return @""; }
-(NSString *)sayHeyTo:(NSString *)name1 also:(NSString *)name2 { return @""; }

-(void)sayHeyInner {} // 非接口，内部的方法

+(instancetype)create {
    return [[self alloc] init];
}
@end

@interface LIRun : NSObject
@end
@implementation LIRun
-(void)f1 {
    LIPerson *p = [[LIPerson alloc] init:@"" and1:@"" andAge:10];
    [p sayHey];
}

-(void)f2 {
    
}
@end

#pragma mark - 枚举

typedef NS_ENUM(NSInteger, UITableViewCellSeparatorStyle) {
    UITableViewCellSeparatorStyleNone,
    UITableViewCellSeparatorStyleSingleLine,
    UITableViewCellSeparatorStyleSingleLineEtched API_DEPRECATED("Use UITableViewCellSeparatorStyleSingleLine for a single line separator.", ios(2.0, 11.0))
} API_UNAVAILABLE(tvos);

typedef NS_ENUM(NSInteger, UITableViewCellSelectionStyle) {
    UITableViewCellSelectionStyleNone,
    UITableViewCellSelectionStyleBlue,
    UITableViewCellSelectionStyleGray,
    UITableViewCellSelectionStyleDefault API_AVAILABLE(ios(7.0))
};

typedef NS_ENUM(NSInteger, UITableViewCellFocusStyle) {
    UITableViewCellFocusStyleDefault,
    UITableViewCellFocusStyleCustom
} API_AVAILABLE(ios(9.0));

typedef NS_ENUM(NSInteger, UITableViewCellEditingStyle) {
    UITableViewCellEditingStyleNone,
    UITableViewCellEditingStyleDelete,
    UITableViewCellEditingStyleInsert
};


typedef NS_OPTIONS(NSUInteger, Options) {
    Options1 = 1 << 0,
    Options2 = 1 << 1,
    Options3 = 1 << 2,
};

//NSUInteger a = Option1 | Option2;
