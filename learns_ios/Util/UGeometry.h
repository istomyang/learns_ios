//
//  UGeometry.h
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "Import.h"

#ifndef UGeometry_h
#define UGeometry_h

#pragma mark - Conversion 转换

/// 角度 -> 弧度
CGFloat U_DegreesFromRadians(CGFloat radians);

/// 弧度 -> 角度
CGFloat U_RadiansFromDegrees(CGFloat degrees);

#pragma mark - Clamp 夹逼

/// 一维数值夹逼
CGFloat U_Clamp(CGFloat a, CGFloat min, CGFloat max);

/// 二维点位夹逼
CGPoint U_ClampToRect(CGPoint pt, CGRect rect);

#pragma mark - General Geometry 一般几何学

/// 获取Rect中心点
CGPoint U_PointRectGetCenter(CGRect rect);

/// 点与点的直线距离
CGFloat U_PointDistanceFromPoint(CGPoint p1, CGPoint p2);

/// 获取Rect中X轴百分比和Y轴百分比的点，加上Rect原始点坐标。CGPointMake(rect.origin.x + dx, rect.origin.y + dy)
CGPoint U_PointRectGetPointAtPercents(CGRect rect, CGFloat xPercent, CGFloat yPercent);

#pragma mark - Rectangle Construction Rect构造

/// 全信息构造Rect
CGRect U_MakeRectOriginSize(CGPoint origin, CGSize size);

/// 构造一个0起始点的Rect
CGRect U_MakeRectSize(CGSize size);

/// 两点创建一个Rect
CGRect U_MakeRectTwoPoints(CGPoint p1, CGPoint p2);

/// 构造一个0尺寸的Rect
CGRect U_MakeRectOrigin(CGPoint origin);

/// 中点和尺寸构造一个Rect
CGRect U_MakeRectAroundCenter(CGPoint center, CGSize size);

/// 如果把rect置于mainRect中央，返回rect的结果
CGRect U_MakeRectCenteredInRect(CGRect rect, CGRect mainRect);

#pragma mark - Point Location 点位算术

/// 点与点相加
CGPoint U_PointAddPoint(CGPoint p1, CGPoint p2);

/// 点与点相减
CGPoint U_PointSubtractPoint(CGPoint p1, CGPoint p2);

#pragma mark - Cardinal Points Rect点位

/// 左上角点
CGPoint U_PointRectGetTopLeft(CGRect rect);

/// 右上角点
CGPoint U_PointRectGetTopRight(CGRect rect);

/// 左下角点
CGPoint U_PointRectGetBottomLeft(CGRect rect);

/// 右下角点
CGPoint U_PointRectGetBottomRight(CGRect rect);

/// 正上角点
CGPoint U_PointRectGetMidTop(CGRect rect);

/// 正下角点
CGPoint U_PointRectGetMidBottom(CGRect rect);

/// 左中点
CGPoint U_PointRectGetMidLeft(CGRect rect);

/// 右中点
CGPoint U_PointRectGetMidRight(CGRect rect);

#pragma mark - Aspect and Fitting 适应

/// Size按因子缩放
CGSize U_SizeScaleByFactor(CGSize aSize, CGFloat factor);

/// 比较两个Rect，得到缩放因子
CGSize U_FactorRectGetScale(CGRect sourceRect, CGRect destRect);

/// 比例因子，填满窗口，牺牲全貌
CGFloat U_FactorAspectScaleFill(CGSize sourceSize, CGRect destRect);

/// 比例因子，填满全貌，会有留白
CGFloat U_FactorAspectScaleFit(CGSize sourceSize, CGRect destRect);

/// 中心缩放，最大展现全貌
CGRect U_MakeRectByFitting(CGRect sourceRect, CGRect destinationRect);

/// 中心缩放，填满显示窗口
CGRect U_MakeRectByFilling(CGRect sourceRect, CGRect destinationRect);

/// 插入的Inset，尺寸的百分比
CGRect U_MakeRectInsetByPercent(CGRect rect, CGFloat percent);

#pragma mark - Transforms 变换

/// 变换的X轴缩放比例
CGFloat U_TransformGetXScale(CGAffineTransform t);

/// 变换的Y轴缩放比例
CGFloat U_TransformGetYScale(CGAffineTransform t);

/// 变换的旋转角度
CGFloat U_TransformGetRotation(CGAffineTransform t);


#endif /* UGeometry_h */
