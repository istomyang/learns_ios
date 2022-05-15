//
//  LICGContextView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
// 关于如何创建上下文，更多看官方：https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_context/dq_context.html#//apple_ref/doc/uid/TP30001066-CH203-SW9

#import "LICGContextView.h"

@implementation LICGContextView

- (instancetype)init {
    self = [super initWithLongPress:YES withSize:nil withBGColor:nil];
    return self;
}

/*
 1. The view’s drawRect: method is called when the view is visible onscreen and its contents need updating.
 2. Before calling your custom drawRect: method, the view object automatically configures its drawing environment
 so that your code can start drawing immediately.
 3. As part of this configuration, the UIView object creates a graphics context (a CGContextRef opaque type) for
 the current drawing environment.
 4. You obtain this graphics context in your drawRect: method by calling the UIKit function UIGraphicsGetCurrentContext.
 
 5. The default coordinate system used throughout UIKit is different from the coordinate system used by Quartz. In UIKit,
 the origin is in the upper-left corner, with the positive-y value pointing downward. The UIView object modifies the CTM
 of the Quartz graphics context to match the UIKit conventions by translating the origin to the upper left corner of the
 view and inverting the y-axis by multiplying it by -1. For more information on modified-coordinate systems and the
 implications in your own drawing code, see Quartz 2D Coordinate Systems.
 【意思：CG的坐标系在UIKit中已经变换过了。】
 6. MacOS 请看：https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_context/dq_context.html#//apple_ref/doc/uid/TP30001066-CH203-SW9
 */
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*
     1. 颜色如果透明，会产生重合，变成混合后的颜色。
     */
    CGContextSetRGBFillColor (context, 1, 0, 0, 1); // 设置填充颜色
    CGContextFillRect (context, CGRectMake (0, 0, 200, 100 )); // 构造矩形
    CGContextSetRGBFillColor (context, 0, 0, 1, .5);
    CGContextFillRect (context, CGRectMake (0, 0, 100, 200));
}

#pragma mark - 创建PDF的上下文
- (CGContextRef)createPDFContextWithPath:(CFStringRef)path andMediaBox:(CGRect *)mediaBox {
    CGContextRef ret = NULL;
    CFURLRef url = NULL;
    
    // You pass NULL as the first parameter to use the default allocator.
    // You also need to specify a path style, which for this example is a POSIX-style pathname
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, false);
    if (url != NULL) {
        // The rectangle (CGRect) was passed to the function and is the default
        // page media bounding box for the PDF.
        ret = CGPDFContextCreateWithURL(url, mediaBox, NULL);
        
        // Releases the CFURL object
        CFRelease(url);
    }
    
    return ret;
}

#pragma mark - 另一种方式创建的上下文
- (CGContextRef)createPDFContext2WithPath:(CFStringRef)path andMediaBox:(CGRect *)mediaBox {
    CGContextRef ret = NULL;
    CFURLRef url = NULL;
    CGDataConsumerRef consumer = NULL;
    
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, false);
    
    if (url != NULL) {
        consumer = CGDataConsumerCreateWithURL(url);
        if (consumer != NULL) {
            ret = CGPDFContextCreate(consumer, mediaBox, NULL);
            CGDataConsumerRelease(consumer);
        }
        
        CFRelease(url);
    }
    
    return ret;
}

#pragma mark - 绘制PDF
- (void)drawPDF {
    CGRect mediaBox = CGRectMake(0, 0, 200, 200);
    CGContextRef myPDFContext = [self createPDFContextWithPath:CFSTR("test.pdf") andMediaBox:&mediaBox];
    
    CFStringRef myKeys[1];
    CFTypeRef myValues[1];
    myKeys[0] = kCGPDFContextMediaBox;
    myValues[0] = (CFTypeRef) CFDataCreate(NULL,(const UInt8 *)&mediaBox, sizeof (CGRect));
    
    // Sets up a dictionary with the page options. In this example, only the media box is specified.
    // You don’t have to pass the same rectangle you used to set up the PDF graphics context.
    // The media box you add here supersedes the rectangle you pass to set up the PDF graphics contex
    CFDictionaryRef pageDictionary = CFDictionaryCreate(NULL, (const void **) myKeys,
                                                        (const void **) myValues, 1,
                                                        &kCFTypeDictionaryKeyCallBacks,
                                                        & kCFTypeDictionaryValueCallBacks);
    
    CGPDFContextBeginPage(myPDFContext, pageDictionary);
    
    // ********** Your drawing code here **********
    
    CGContextSetRGBFillColor (myPDFContext, 1, 0, 0, 1);
    CGContextFillRect (myPDFContext, CGRectMake (0, 0, 200, 100 ));
    CGContextSetRGBFillColor (myPDFContext, 0, 0, 1, .5);
    CGContextFillRect (myPDFContext, CGRectMake (0, 0, 100, 200 ));
    
    CGPDFContextEndPage(myPDFContext);
    
    CFRelease(pageDictionary);
    CFRelease(myValues[0]);
    CGContextRelease(myPDFContext);
}

#pragma mark - 创建Bitmap上下文
- (CGContextRef)createBitmapContextWithSize:(CGSize)size {
    
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Declares a variable to represent the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and alpha.
    bitmapBytesPerRow   = size.width * 4;
    bitmapByteCount     = bitmapBytesPerRow * size.height; // bit长度
    
    // 阅读官网 Supported Pixel Formats
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    bitmapData = calloc( bitmapByteCount, sizeof(uint8_t) );
    
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     size.width,
                                     size.height,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast // 表示alpha分量被存储在每个像素的最后一个字节中
                                     );
    
    // 抗锯齿，参见官网 Anti-Aliasing
    CGContextSetShouldAntialias(context, YES);
    
    if (context== NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

#pragma mark - 绘制Bitmap
-(void)drawBitmapWithContext:(CGContextRef)myContext {
    CGRect size;
    CGContextRef myBitmapContext;
    CGImageRef myImage;
    
    size = CGRectMake(0, 0, 300, 300);
    myBitmapContext = [self createBitmapContextWithSize:CGSizeMake(200, 200)];
    
    // ********** Your drawing code here **********
    CGContextSetRGBFillColor (myBitmapContext, 1, 0, 0, 1);
    CGContextFillRect (myBitmapContext, CGRectMake (0, 0, 200, 100 ));
    CGContextSetRGBFillColor (myBitmapContext, 0, 0, 1, .5);
    CGContextFillRect (myBitmapContext, CGRectMake (0, 0, 100, 200 ));
    
    myImage = CGBitmapContextCreateImage(myBitmapContext);
    CGContextDrawImage(myContext, size, myImage);
    char *bitmapData = CGBitmapContextGetData(myBitmapContext);
    CGContextRelease (myBitmapContext);
    if (bitmapData) free(bitmapData);
    CGImageRelease(myImage);
}

@end
