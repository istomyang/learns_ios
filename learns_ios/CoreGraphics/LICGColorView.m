//
//  LICGColorView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGColorView.h"

@implementation LICGColorView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 完全透明，显式清除图形上下文的 alpha 通道
    // 在为图标创建透明蒙版或使窗口的背景透明时。
    CGContextClearRect(context, rect);
    
    // 全局 alpha
    // Quartz 会将 alpha 颜色分量乘以全局 alpha 值
    CGContextSetAlpha(context, 0.2);
    
    // 创建与设备无关的色彩空间，与特定设备无关的色彩空间
    const CGFloat white[3] = { 0, 0.5, 1 };  // 调色需要的值
    const CGFloat black[3] = { 0, 0.5, 1 };
    const CGFloat gamma[3] = { 0, 0.5, 1 };
    const CGFloat matrix[9] = { 0, 0.5, 1, 0, 0.5, 1, 0, 0.5, 1};
    CGColorSpaceRef spaceRef = CGColorSpaceCreateCalibratedRGB(white, black, gamma, matrix);
    CGColorSpaceRelease(spaceRef); // 记得释放
    
    // 创建通用色彩空间（灰度）
    CGColorSpaceRef spaceGeneralRef = CGColorSpaceCreateWithName(kCGColorSpaceGenericGray);
    CGColorSpaceRelease(spaceGeneralRef);
    
    // 创建设备色彩空间
    // 一些 Quartz 例程需要具有设备颜色空间的图像。例如，如果您调用CGImageCreateWithMask并指定一个图像作为掩码，则该图像必须使用设备灰色颜色空间进行定义。
    CGColorSpaceRef spaceDeviceRef = CGColorSpaceCreateDeviceGray();
    CGColorSpaceRelease(spaceDeviceRef);
    
    // 创建索引和图案颜色空间，见官方文档：https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_color/dq_color.html#//apple_ref/doc/uid/TP30001066-CH205-TPXREF116
    
    // https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_color/dq_color.html#//apple_ref/doc/uid/TP30001066-CH205-BBCGJBGG
    
    // 描边
    CGContextSetRGBFillColor (context, 1, 0, 0, 1);
    
    // 填充
    CGContextSetRGBStrokeColor (context, 1, 0, 0, 1);
    
    // TODO: 设置渲染意图????
}

@end
