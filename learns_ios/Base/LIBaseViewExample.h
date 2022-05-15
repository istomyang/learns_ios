//
//  LIBaseViewExample.h
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "LIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

// 一个View共享，传递使用的类型
typedef NS_ENUM(NSUInteger, Types) {
    TypesSimpleTextAtPoint = 0,
    TypesSimpleText,
};

@interface LIBaseViewExample : LIBaseView

- (instancetype)initWithTypes:(Types)type;

@end

NS_ASSUME_NONNULL_END
