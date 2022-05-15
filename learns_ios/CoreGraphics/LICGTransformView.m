//
//  LICGTransformView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.

#import "LICGTransformView.h"
#include <math.h>

static inline double radians (double degree) {return degree * M_PI/180;}

@implementation LICGTransformView

// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/dq_affine.html#//apple_ref/doc/uid/TP30001066-CH204-SW1
- (void)drawRect:(CGRect)rect {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);
    CGContextFillRect (myContext, CGRectMake (0, 0, 200, 100 ));
    
    // 平移，坐标系遵循UIKit变换后的
    CGContextTranslateCTM (myContext, 100, 50);
    
    // 旋转角度
    CGContextRotateCTM (myContext, radians(-45));
    
    // 缩放
    CGContextScaleCTM (myContext, .5, .75);
    
    // 仿射变换
    
    CGAffineTransform transform;
    
    // 你可以使用其他创建函数 CGAffineTransformMake 等
    transform = CGAffineTransformIdentity;
    
    // 变换函数，一些列，自己查
    transform = CGAffineTransformTranslate(transform, 10, 10);
    transform = CGAffineTransformScale(transform, 0.2, 0.4);
    
    if (CGAffineTransformIsIdentity(transform)) {
        // 变换回来还是一样。
    } else {
        // 应用变换
        CGContextConcatCTM(myContext, transform);
    }
    
    // 用户空间与设备空间的转换
    // PDF打印就是设备空间之一。
    CGContextConvertRectToDeviceSpace(myContext, rect);
}

@end
