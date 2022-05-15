//
//  LICGPatternView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGPatternView.h"

@implementation LICGPatternView

// 回掉函数
typedef void (*CGPatternDrawPatternCallback) (
                                              // 指向与模式关联的私有数据的通用指针。该参数是可选的；你可以通过NULL。
                                              void *info,
                                              // 用于绘制图案单元的图形上下文。
                                              CGContextRef context
                                              );

// 在编写绘图代码时，您需要牢记图案大小。在这里，大小被声明为全局。
#define H_PATTERN_SIZE 16
#define V_PATTERN_SIZE 18

void MyDrawColoredPattern (void *info, CGContextRef myContext)
{
    CGFloat subunit = 5; // the pattern cell itself is 16 by 18
    
    CGRect  myRect1 = {{0,0}, {subunit, subunit}},
    myRect2 = {{subunit, subunit}, {subunit, subunit}},
    myRect3 = {{0,subunit}, {subunit, subunit}},
    myRect4 = {{subunit,0}, {subunit, subunit}};
    
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 0.5);
    CGContextFillRect (myContext, myRect1);
    CGContextSetRGBFillColor (myContext, 1, 0, 0, 0.5);
    CGContextFillRect (myContext, myRect2);
    CGContextSetRGBFillColor (myContext, 0, 1, 0, 0.5);
    CGContextFillRect (myContext, myRect3);
    CGContextSetRGBFillColor (myContext, .5, 0, .5, 0.5);
    CGContextFillRect (myContext, myRect4);
}


- (void)drawRect:(CGRect)rect {
    
}

- (void)paintColorPatternWithContext:(CGContextRef)myContext andRect:(CGRect)rect {
    CGPatternRef    pattern;
    CGColorSpaceRef patternSpace;
    CGFloat         alpha = 1;
    
    
    // struct CGPatternCallbacks
    // {
    //    unsigned int version;
    //    CGPatternDrawPatternCallback drawPattern;
    //    CGPatternReleaseInfoCallback releaseInfo;
    // };
    static const  CGPatternCallbacks callbacks = {
        0, // You set the version field to 0
        
        // The drawPattern field is a pointer to your drawing callback
        &MyDrawColoredPattern,
        
        // The releaseInfo field is a pointer to a callback that’s invoked when the CGPattern object is released,
        // to release storage for the info parameter you passed to your drawing callback. If you didn’t pass any
        // data in this parameter, you set this field to NULL.
        NULL
    };
    
    CGContextSaveGState (myContext);
    
    // passing NULL as the base color space
    patternSpace = CGColorSpaceCreatePattern (NULL);
    CGContextSetFillColorSpace (myContext, patternSpace);
    CGColorSpaceRelease (patternSpace);
    
    pattern = CGPatternCreate (
                               // The info parameter is a pointer to data you want to pass to your drawing callback.
                               // This is the same pointer discussed in MyDrawColoredPattern.
                               NULL,
                               
                               // You specify the size of the pattern cell in the bounds parameter.
                               CGRectMake (0, 0, H_PATTERN_SIZE, V_PATTERN_SIZE),
                               
                               // The matrix parameter is where you specify the pattern matrix, which maps the pattern
                               // coordinate system to the default coordinate system of the graphics context.
                               // Use the identity matrix if you want to draw the pattern using the same coordinate
                               // system as the graphics context.
                               CGAffineTransformMake (1, 0, 0, 1, 0, 0),
                               
                               // The xStep and yStep parameters specify the horizontal and vertical spacing between
                               // cells in the pattern coordinate system.
                               H_PATTERN_SIZE,
                               V_PATTERN_SIZE,
                               
                               // The tiling parameter can be one of three values:
                               // + kCGPatternTilingNoDistortion
                               // + kCGPatternTilingConstantSpacingMinimalDistortion
                               // + kCGPatternTilingConstantSpacing
                               // https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_patterns/dq_patterns.html#//apple_ref/doc/uid/TP30001066-CH206-BBCDHCEH
                               kCGPatternTilingConstantSpacing,
                               
                               // The isColored parameter specifies whether the pattern cell is a colored pattern (true)
                               // or a stencil pattern (false).
                               // If you pass true here, your drawing pattern callback specifies the pattern color,
                               // and you must set the pattern color space to the colored pattern color space
                               true,
                               
                               // The last parameter you pass to the function CGPatternCreate is a pointer to a
                               // CGPatternCallbacks data structure.
                               &callbacks);
    
    // Sets the fill pattern, passing the context, the CGPattern object you just created, and a pointer to the alpha value
    // that specifies an opacity for Quartz to apply to the pattern.
    CGContextSetFillPattern (myContext, pattern, &alpha);
    
    CGPatternRelease (pattern);
    
    // Fills a rectangle that is the size of the window passed to the paintPatternWithContext routine.
    // Quartz fills the rectangle using the pattern you just set up.
    CGContextFillRect (myContext, rect);
    
    CGContextRestoreGState (myContext);
}

#define PSIZE 16

// 画星星
static void MyDrawStencilStar (void *info, CGContextRef myContext)
{
    int k;
    double r, theta;
 
    r = 0.8 * PSIZE / 2;
    theta = 2 * M_PI * (2.0 / 5.0); // 144 degrees
 
    CGContextTranslateCTM (myContext, PSIZE/2, PSIZE/2);
 
    CGContextMoveToPoint(myContext, 0, r);
    for (k = 1; k < 5; k++) {
        CGContextAddLineToPoint (myContext,
                    r * sin(k * theta),
                    r * cos(k * theta));
    }
    CGContextClosePath(myContext);
    CGContextFillPath(myContext);
}

- (void)paintStencilPatternWithContext:(CGContextRef)myContext andRect:(CGRect)rect {
    
    CGPatternRef pattern;
    CGColorSpaceRef baseSpace;
    CGColorSpaceRef patternSpace;
    
    // Declares an array to hold a color value and sets the value (which will be in RGB color space) to opaque green.
    static const CGFloat color[4] = { 0, 1, 0, 1 };
    
    // Declares and fills a callbacks structure, passing 0 as the version and a pointer to a drawing callback function.
    // This example does not provide a release info callback, so that field is set to NULL.
    static const CGPatternCallbacks callbacks = {0, &MyDrawStencilStar, NULL};
    
    baseSpace = CGColorSpaceCreateDeviceRGB ();
    patternSpace = CGColorSpaceCreatePattern (baseSpace); // 因为颜色空间是隔离开的
    CGContextSetFillColorSpace (myContext, patternSpace);
    CGColorSpaceRelease (patternSpace);
    CGColorSpaceRelease (baseSpace);
    
    
    pattern = CGPatternCreate(NULL, CGRectMake(0, 0, PSIZE, PSIZE),
                              CGAffineTransformIdentity, PSIZE, PSIZE,
                              kCGPatternTilingConstantSpacing,
                              false, &callbacks); // 注意 isColored 是false，其他同颜色模式
    
    // 设置填充图案
    CGContextSetFillPattern (myContext, pattern, color);
    
    CGPatternRelease (pattern);
    CGContextFillRect (myContext,CGRectMake (0,0,PSIZE*20,PSIZE*20));
}
@end
