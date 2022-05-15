//
//  LICGGradientView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGGradientView.h"

@implementation LICGGradientView

-(void)setGradientWithContext:(CGContextRef)myContext {
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    
    // 位置
    CGFloat locations[2] = { 0.0, 1.0 };
    
    // 颜色
    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,  // Start color
                              0.8, 0.8, 0.3, 1.0 }; // End color
    
    // 色彩空间
    myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    
    // 创建一个渐变对象
    myGradient = CGGradientCreateWithColorComponents (myColorspace,
                                                      components,
                                                      locations,
                                                      num_locations);
    
    CGColorSpaceRelease(myColorspace);
    
    // 轴向
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = 0.0;
    myEndPoint.x = 1.0;
    myEndPoint.y = 1.0;
    CGContextDrawLinearGradient (myContext, myGradient, myStartPoint, myEndPoint, 0);
    
    
    // 径向
    CGPoint myStartPoint2, myEndPoint2;
    CGFloat myStartRadius, myEndRadius;
    myStartPoint2.x = 0.15;
    myStartPoint2.y = 0.15;
    myEndPoint2.x = 0.5;
    myEndPoint2.y = 0.5;
    myStartRadius = 0.1;
    myEndRadius = 0.25;
    CGContextDrawRadialGradient (myContext, myGradient, myStartPoint2,
                             myStartRadius, myEndPoint2, myEndRadius,
                             kCGGradientDrawsAfterEndLocation);
}

-(void)setShadingWithContext:(CGContextRef)myContext {
//   TODO: https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html#//apple_ref/doc/uid/TP30001066-CH207-SW5
}

@end
