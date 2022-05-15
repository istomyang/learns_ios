//
//  LIGCPDFView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LIGCPDFView.h"

@implementation LIGCPDFView

// 打开并渲染一页PDF
-(void)drawPDF:(CGContextRef)context withName:(NSString *)fileName {
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    size_t count;
    CGPDFPageRef page;
    
    path = (__bridge CFStringRef)fileName;
    url = CFURLCreateWithFileSystemPath (NULL, path,
                                         kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    
    // 从 CFURL 对象创建 CGPDFDocument 对象。
    document = CGPDFDocumentCreateWithURL (url);
    CFRelease(url);
    
    // 获取 PDF 中的页数，以便代码中的下一条语句可以确保文档至少有一页
    count = CGPDFDocumentGetNumberOfPages (document);
    if (count == 0) {
        NSLog(@"Docuemnt is Empty!");
    } else {
        // 返回第一页内容，可以自定义
        page = CGPDFDocumentGetPage (document, 0);
        // 绘制页面
        CGContextDrawPDFPage (context, page);
    }
    
    CGPDFDocumentRelease (document);
}

// 对PDF的页面应用Transform
-(void)doTransformInPageWithContext:(CGContextRef)context
                           withPage:(CGPDFPageRef)page
                            withBox:(CGPDFBox)box
                           withRect:(CGRect)rect
                       withRotation:(CGFloat)rotation
            withPreserveAspectRatio:(BOOL)preserveAspectRatio
{
    CGAffineTransform m;
    
    m = CGPDFPageGetDrawingTransform (page, box, rect, rotation, preserveAspectRatio);
    CGContextSaveGState (context);
    
    // 应用变换
    CGContextConcatCTM (context, m);
    
    // 将图形上下文剪辑到box参数指定的矩形。该函数CGPDFPageGetBoxRect获取与您提供的常量相关联的页面边界框（媒体、裁剪、
    // 出血、修剪和艺术框） - kCGPDFMediaBox、kCGPDFCropBox、kCGPDFBleedBox、kCGPDFTrimBox或kCGPDFArtBox。
    CGContextClipToRect (context,CGPDFPageGetBoxRect (page, box));
    
    CGContextDrawPDFPage (context, page);
    CGContextRestoreGState (context);
}

-(void)createPDFWithRect:(CGRect)pageRect withName:(NSString *)filename {
    CGContextRef pdfContext;
    CFStringRef path;
    CFURLRef url;
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    
    path = (__bridge CFStringRef)filename;
    url = CFURLCreateWithFileSystemPath (NULL, path,kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    
    // 创建一个空的 CFDictionary 对象来保存元数据。
    myDictionary = CFDictionaryCreateMutable(NULL, 0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    
    
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
    
    // 设置密码
    CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, CFSTR("password"));
    
    // 创建 PDF 图形上下文，传递三个参数
    // 1. 指定 PDF 数据位置的 CFURL 对象。
    // 2. 指向定义 PDF 页面默认大小和位置的矩形的指针。矩形的原点通常是 (0, 0)。Quartz 使用这个矩形作为页面媒体框的默认边界。
    //    如果通过NULL，Quartz 使用 8.5 x 11 英寸（612 x 792 点）的默认页面大小。
    // 3. 属性
    pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
    CFRelease(myDictionary);
    CFRelease(url);
    
    // 创建一个 CFDictionary 对象来保存 PDF 页面的页面框。此示例设置媒体框。
    pageDictionary = CFDictionaryCreateMutable(NULL, 0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    
    boxData = CFDataCreate(NULL,(const UInt8 *)&pageRect, sizeof (CGRect));
    
    // 媒体框。
    CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
    
    // 表示页面的开始。当您使用支持多页的图形上下文（例如 PDF）时，您可以调用该函数
    // CGPDFContextBeginPage来CGPDFContextEndPage描绘输出中的页面边界。每一页都必须用对 和 的调用括
    // CGPDFContextBeginPage起来CGPDFContextEndPage。Quartz 忽略在基于页面的上下文中在页面边界之外执行的所有绘图操作。
    CGPDFContextBeginPage (pdfContext, pageDictionary);
    
    // 内容绘制到 PDF 上下文。你在这里提供你的绘图程序。
    CGContextSetRGBFillColor (pdfContext, 1, 0, 0, 1);
    CGContextFillRect (pdfContext, CGRectMake (0, 0, 200, 100 ));
    
    // 在基于页面的图形上下文中发出页面结束信号。
    CGPDFContextEndPage (pdfContext);

    CGContextRelease (pdfContext);
    CFRelease(pageDictionary);
    CFRelease(boxData);
}
@end
