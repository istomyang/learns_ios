//
//  LICGPathView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGPathView.h"

// Tips: 可以直接用Path绘制，然后转换为 cgPath

// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/dq_paths.html#//apple_ref/doc/uid/TP30001066-CH211-TPXREF101

@implementation LICGPathView
- (void)drawRect:(CGRect)rect {
    
}

#pragma mark - Hey Path
-(void)createPathWithCtx:(CGContextRef)context andSize:(CGRect)rect {
    // Before you begin a new path, call the function CGContextBeginPath.
    CGContextBeginPath(context); // 开启一个path
    
    // Lines, arcs, and curves are drawn starting at the current point.
    // An empty path has no current point.
    // you must call CGContextMoveToPoint to set the starting point.
    CGContextMoveToPoint(context, 0, 0);
    
    
    // When you want to close the current subpath within a path, call the function CGContextClosePath
    // to connect a segment to the starting point of the subpath. Subsequent path calls begin a new
    // subpath, even if you do not explicitly set a new starting point.
    CGContextClosePath(context);
    
    // After you paint a path, it is flushed from the graphics context.
    // 使用 CGPathRef and CGMutablePathRef 保存Path
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    CGMutablePathRef mutablePath = CGPathCreateMutableCopy(path);
    
    //    CGPathCreateMutable, which replacesCGContextBeginPath
    //    CGPathMoveToPoint, which replaces CGContextMoveToPoint
    //    CGPathAddLineToPoint, which replaces CGContextAddLineToPoint
    //    CGPathAddCurveToPoint, which replaces CGContextAddCurveToPoint
    //    CGPathAddEllipseInRect, which replaces CGContextAddEllipseInRect
    //    CGPathAddArc, which replaces CGContextAddArc
    //    CGPathAddRect, which replaces CGContextAddRect
    //    CGPathCloseSubpath, which replaces CGContextClosePath
    CGPathMoveToPoint(mutablePath, NULL, 0, 0);
    
    CGPathCloseSubpath(mutablePath);
    
    CGPathRelease(path);
}

@end
