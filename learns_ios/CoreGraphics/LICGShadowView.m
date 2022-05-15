//
//  LICGShadowView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGShadowView.h"

@implementation LICGShadowView

-(void)setShodowWithContext:(CGContextRef)myContext andRect:(CGSize)size {
    CGSize          myShadowOffset = CGSizeMake (-15,  20);
    CGFloat           myColorValues[] = {1, 0, 0, .6};
    CGColorRef      myColor;
    CGColorSpaceRef myColorSpace;
    CGFloat wd = size.width;
    CGFloat ht = size.height;
    
    // 保存当前的图形状态，以便您以后可以恢复它。
    CGContextSaveGState(myContext);
    
    // 传递图形上下文、偏移值和模糊值。
    // 默认：阴影是使用设置为 的 RGBA 值绘制的{0, 0, 0, 1.0/3.0}
    CGContextSetShadow (myContext, myShadowOffset, 5);
    
    // 第一个矩形
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3 + 75, ht/2 , wd/4, ht/4));
    
    myColorSpace = CGColorSpaceCreateDeviceRGB ();
    
    myColor = CGColorCreate (myColorSpace, myColorValues);
    
    // 设置彩色阴影
    // 颜色为NULL禁用阴影
    CGContextSetShadowWithColor (myContext, myShadowOffset, 5, myColor);
    
    // 第二个矩形
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3-75,ht/2-100,wd/4,ht/4));
    
    CGColorRelease (myColor);
    CGColorSpaceRelease (myColorSpace);
    
    // 恢复图形上下文
    CGContextRestoreGState(myContext);
}

@end
