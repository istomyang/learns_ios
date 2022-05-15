//
//  UDrawing.h
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "Import.h"

#ifndef UDrawing_h
#define UDrawing_h

typedef void (^DrawingBlock)(CGRect bounds);
typedef void (^DrawingStateBlock)(void);

/// 开启一个新的绘制状态
void U_PushDraw(DrawingStateBlock block);

/// 获得UIkit上下文尺寸
CGSize U_GetSizeUIKitContext(void);

/// 垂直翻转
void U_FlipContextVertically(CGSize size);

#pragma mark - Path

/// 返回图形路径的边界框。
CGRect U_PathGetBoundingBox(UIBezierPath *path);

/// 按Path的中心点变换矩阵
void U_ApplyCenteredPathTransform(UIBezierPath *path, CGAffineTransform transform);

/// 按Path的中心点移动到点
void U_MovePathCenterToPoint(UIBezierPath *path, CGPoint destPoint);

/// Path的尺寸Fit一下
void U_PathFitToRect(UIBezierPath *path, CGRect destRect);

#pragma mark - Path：工具

/// 按Rect裁剪。
void U_ClipToRect(CGRect rect);

/// 按Rect填充颜色
void U_FillRect(CGRect rect, UIColor *color);


#endif /* UDrawing_h */
