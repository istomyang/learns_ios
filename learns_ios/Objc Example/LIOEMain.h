//
//  LIOEMain.h
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LIOEMain : NSObject

#pragma mark - available写法
+ (BOOL)available_example OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);

@end

NS_ASSUME_NONNULL_END
