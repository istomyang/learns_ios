//
//  UIVC+U.h
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "Import.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (U)

/// 考虑导航栏的内容区域中心点
@property(nonatomic, readonly) CGPoint centerPointNavBar;

/// 考虑导航栏内容区域Frame
@property(nonatomic, readonly) CGRect contentFrame;

/// 考虑导航栏，左上角点位置
@property(nonatomic, readonly) CGPoint contentStartPoint;

@end

NS_ASSUME_NONNULL_END
