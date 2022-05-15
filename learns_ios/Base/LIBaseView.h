//
//  LIBaseView.h
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LIBaseView : UIView

/// 长按、居中的尺寸、背景颜色（默认的白色）
-(instancetype)initWithLongPress:(BOOL)enabledLP withSize:(CGSize * _Nullable)size withBGColor:(UIColor * _Nullable)color;

@end

NS_ASSUME_NONNULL_END
