//
//  UDrawing.m
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "UDrawing.h"
#import "Util.h"
#import "UGeometry.h"

UIImage *U_ImageWithBlock(DrawingBlock block, CGSize size)
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    if (block) block((CGRect){.size = size});
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 开启一个新的绘制状态
void U_PushDraw(DrawingStateBlock block)
{
    if (!block) return; // nothing to do
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) LogE(@"No context to draw into");
    
    CGContextSaveGState(context);
    block();
    CGContextRestoreGState(context);
}

/// 获得UIkit上下文尺寸
CGSize U_GetSizeUIKitContext(void)
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) return CGSizeZero;
    CGSize size = CGSizeMake(CGBitmapContextGetWidth(context), CGBitmapContextGetHeight(context));
    CGFloat scale = [UIScreen mainScreen].scale;
    return CGSizeMake(size.width / scale, size.height / scale);
}

/// 垂直翻转
void U_FlipContextVertically(CGSize size)
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        LogE(@"Error: No context to flip");
        return;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    // TODO: 有空亲自比较区别
    transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
    transform = CGAffineTransformTranslate(transform, 0.0f, -size.height);
    CGContextConcatCTM(context, transform);
}

#pragma mark - Path：几何

/// 返回图形路径的边界框。
CGRect U_PathGetBoundingBox(UIBezierPath *path)
{
    return CGPathGetPathBoundingBox(path.CGPath);
}

/// 按Path的中心点变换矩阵
void U_ApplyCenteredPathTransform(UIBezierPath *path, CGAffineTransform transform)
{
    // 拿到Path中心点
    CGPoint center = U_PointRectGetCenter(U_PathGetBoundingBox(path));
    CGAffineTransform t = CGAffineTransformIdentity;
    
    t = CGAffineTransformTranslate(t, center.x, center.y);
    t = CGAffineTransformConcat(transform, t);
    t = CGAffineTransformTranslate(t, -center.x, -center.y);
    [path applyTransform:t];
}

/// 按Path的中心点移动到点
void U_MovePathCenterToPoint(UIBezierPath *path, CGPoint destPoint)
{
    CGRect bounds = U_PathGetBoundingBox(path);
    CGPoint p1 = bounds.origin;
    CGPoint p2 = destPoint;
    
    CGSize offset = CGSizeMake(p2.x - p1.x, p2.y - p1.y);
    offset.width -= bounds.size.width / 2.0f;
    offset.height -= bounds.size.height / 2.0f;
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(offset.width, offset.height); // 移动原点
    U_ApplyCenteredPathTransform(path, t);
}

/// Path的尺寸Fit一下
void U_PathFitToRect(UIBezierPath *path, CGRect destRect)
{
    CGRect bounds = U_PathGetBoundingBox(path);
    CGRect fitRect = U_MakeRectByFitting(bounds, destRect);
    CGFloat scale = U_FactorAspectScaleFit(bounds.size, destRect);
    
    CGPoint newCenter = U_PointRectGetCenter(fitRect);
    U_MovePathCenterToPoint(path, newCenter);
    
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    U_ApplyCenteredPathTransform(path, t);
}

#pragma mark - Path：工具

/// 按Rect裁剪。
void U_ClipToRect(CGRect rect)
{
    [[UIBezierPath bezierPathWithRect:rect] addClip];
}

/// 按Rect填充颜色
void U_FillRect(CGRect rect, UIColor *color)
{
    [color setFill];
    [[UIBezierPath bezierPathWithRect:rect] fill];
}
