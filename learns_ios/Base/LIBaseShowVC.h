//
//  LIBaseShowVC.h
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import <UIKit/UIKit.h>
#import "LI.h"
#import "LIBaseVC.h"

typedef void (^SetUI)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LIBaseShowVC : LIBaseVC

/// 子类重写init，调用此初始化方法。
-(instancetype)initWithCells:(NSDictionary<NSString *, SetUI> *)newCells andTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
