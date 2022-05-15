//
//  UGeometry.m
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "UGeometry.h"

#pragma mark - Conversion 转换

/// 角度 -> 弧度
CGFloat U_DegreesFromRadians(CGFloat radians)
{
    return radians * 180.0f / M_PI;
}

/// 弧度 -> 角度
CGFloat U_RadiansFromDegrees(CGFloat degrees)
{
    return degrees * M_PI / 180.0f;
}

#pragma mark - Clamp 夹逼

/// 一维数值夹逼
CGFloat U_Clamp(CGFloat a, CGFloat min, CGFloat max)
{
    return fmin(fmax(min, a), max);
}

/// 二维点位夹逼
CGPoint U_ClampToRect(CGPoint pt, CGRect rect)
{
    CGFloat x = U_Clamp(pt.x, CGRectGetMinX(rect), CGRectGetMaxX(rect));
    CGFloat y = U_Clamp(pt.y, CGRectGetMinY(rect), CGRectGetMaxY(rect));
    return CGPointMake(x, y);
}

#pragma mark - General Geometry 一般几何学

/// 获取Rect中心点
CGPoint U_PointRectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

/// 点与点的直线距离
CGFloat U_PointDistanceFromPoint(CGPoint p1, CGPoint p2)
{
    CGFloat dx = p2.x - p1.x;
    CGFloat dy = p2.y - p1.y;
    
    return sqrt(dx*dx + dy*dy);
}

/// 获取Rect中X轴百分比和Y轴百分比的点，加上Rect原始点坐标。CGPointMake(rect.origin.x + dx, rect.origin.y + dy)
CGPoint U_PointRectGetPointAtPercents(CGRect rect, CGFloat xPercent, CGFloat yPercent)
{
    CGFloat dx = xPercent * rect.size.width;
    CGFloat dy = yPercent * rect.size.height;
    return CGPointMake(rect.origin.x + dx, rect.origin.y + dy);
}

#pragma mark - Rectangle Construction Rect构造

/// 全信息构造Rect
CGRect U_MakeRectOriginSize(CGPoint origin, CGSize size)
{
    return (CGRect){.origin = origin, .size = size};
}

/// 构造一个0起始点的Rect
CGRect U_MakeRectSize(CGSize size)
{
    return (CGRect){.size = size};
}

/// 两点创建一个Rect
CGRect U_MakeRectTwoPoints(CGPoint p1, CGPoint p2)
{
    CGRect rect = CGRectMake(p1.x, p1.y, p2.x - p1.x, p2.y - p1.y);
    return CGRectStandardize(rect);
}

/// 构造一个0尺寸的Rect
CGRect U_MakeRectOrigin(CGPoint origin)
{
    return (CGRect){.origin = origin};
}

/// 中点和尺寸构造一个Rect
CGRect U_MakeRectAroundCenter(CGPoint center, CGSize size)
{
    CGFloat halfWidth = size.width / 2.0f;
    CGFloat halfHeight = size.height / 2.0f;
    
    return CGRectMake(center.x - halfWidth, center.y - halfHeight, size.width, size.height);
}

/// 如果把rect置于mainRect中央，返回rect的结果
CGRect U_MakeRectCenteredInRect(CGRect rect, CGRect mainRect)
{
    CGFloat dx = CGRectGetMidX(mainRect)-CGRectGetMidX(rect);
    CGFloat dy = CGRectGetMidY(mainRect)-CGRectGetMidY(rect);
    return CGRectOffset(rect, dx, dy);
}

#pragma mark - Point Location 点位算术

/// 点与点相加
CGPoint U_PointAddPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

/// 点与点相减
CGPoint U_PointSubtractPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

#pragma mark - Cardinal Points Rect点位

/// 左上角点
CGPoint U_PointRectGetTopLeft(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMinX(rect),
                       CGRectGetMinY(rect)
                       );
}

/// 右上角点
CGPoint U_PointRectGetTopRight(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMaxX(rect),
                       CGRectGetMinY(rect)
                       );
}

/// 左下角点
CGPoint U_PointRectGetBottomLeft(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMinX(rect),
                       CGRectGetMaxY(rect)
                       );
}

/// 右下角点
CGPoint U_PointRectGetBottomRight(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMaxX(rect),
                       CGRectGetMaxY(rect)
                       );
}

/// 正上角点
CGPoint U_PointRectGetMidTop(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMidX(rect),
                       CGRectGetMinY(rect)
                       );
}

/// 正下角点
CGPoint U_PointRectGetMidBottom(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMidX(rect),
                       CGRectGetMaxY(rect)
                       );
}

/// 左中点
CGPoint U_PointRectGetMidLeft(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMinX(rect),
                       CGRectGetMidY(rect)
                       );
}

/// 右中点
CGPoint U_PointRectGetMidRight(CGRect rect)
{
    return CGPointMake(
                       CGRectGetMaxX(rect),
                       CGRectGetMidY(rect)
                       );
}

#pragma mark - Aspect and Fitting 适应

/// Size按因子缩放
CGSize U_SizeScaleByFactor(CGSize aSize, CGFloat factor)
{
    return CGSizeMake(aSize.width * factor, aSize.height * factor);
}

/// 比较两个Rect，得到缩放因子
CGSize U_FactorRectGetScale(CGRect sourceRect, CGRect destRect)
{
    CGSize sourceSize = sourceRect.size;
    CGSize destSize = destRect.size;
    
    CGFloat scaleW = destSize.width / sourceSize.width;
    CGFloat scaleH = destSize.height / sourceSize.height;
    
    return CGSizeMake(scaleW, scaleH);
}

/// 比例因子，填满窗口，牺牲全貌
CGFloat U_FactorAspectScaleFill(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
    CGFloat scaleH = destSize.height / sourceSize.height;
    return fmax(scaleW, scaleH);
}

/// 比例因子，填满全貌，会有留白
CGFloat U_FactorAspectScaleFit(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
    CGFloat scaleH = destSize.height / sourceSize.height;
    return fmin(scaleW, scaleH);
}

/// 中心缩放，最大展现全貌
CGRect U_MakeRectByFitting(CGRect sourceRect, CGRect destinationRect)
{
    CGFloat aspect = U_FactorAspectScaleFit(sourceRect.size, destinationRect);
    CGSize targetSize = U_SizeScaleByFactor(sourceRect.size, aspect);
    return U_MakeRectAroundCenter(U_PointRectGetCenter(destinationRect), targetSize);
}

/// 中心缩放，填满显示窗口
CGRect U_MakeRectByFilling(CGRect sourceRect, CGRect destinationRect)
{
    CGFloat aspect = U_FactorAspectScaleFill(sourceRect.size, destinationRect);
    CGSize targetSize = U_SizeScaleByFactor(sourceRect.size, aspect);
    return U_MakeRectAroundCenter(U_PointRectGetCenter(destinationRect), targetSize);
}

/// 插入的Inset，尺寸的百分比
CGRect U_MakeRectInsetByPercent(CGRect rect, CGFloat percent)
{
    CGFloat wInset = rect.size.width * (percent / 2.0f);
    CGFloat hInset = rect.size.height * (percent / 2.0f);
    return CGRectInset(rect, wInset, hInset);
}

#pragma mark - Transforms 变换

/// 变换的X轴缩放比例
CGFloat U_TransformGetXScale(CGAffineTransform t)
{
    return sqrt(t.a * t.a + t.c * t.c);
}

/// 变换的Y轴缩放比例
CGFloat U_TransformGetYScale(CGAffineTransform t)
{
    return sqrt(t.b * t.b + t.d * t.d);
}

/// 变换的旋转角度
CGFloat U_TransformGetRotation(CGAffineTransform t)
{
    return atan2f(t.b, t.a);
}
