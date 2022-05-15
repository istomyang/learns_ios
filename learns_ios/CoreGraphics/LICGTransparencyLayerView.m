//
//  LICGTransparencyLayerView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGTransparencyLayerView.h"

@implementation LICGTransparencyLayerView

-(void)paintTransparentLayerWithContext:(CGContextRef)myContext {
    CGSize          myShadowOffset = CGSizeMake (10, -20);
    CGFloat         wd = 100;
    CGFloat         ht = 100;
 
    CGContextSetShadow (myContext, myShadowOffset, 10);
    
    // 1 表示透明层的开始。从这一点开始，绘制发生在这一层。
    CGContextBeginTransparencyLayer (myContext, NULL);
    
    // 画三个圆圈
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3+ 50,ht/2 ,wd/4,ht/4));
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3-50,ht/2-100,wd/4,ht/4));
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);
    CGContextFillRect (myContext, CGRectMake (wd/3,ht/2-50,wd/4,ht/4));
    
    // 2 表示透明层的结束，并表示 Quartz 应该将结果合成到上下文中。
    CGContextEndTransparencyLayer (myContext);
}

@end
