//
//  LIGCBitmapImageView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LIGCBitmapImageView.h"

@implementation LIGCBitmapImageView

// Creating an Image From Part of a Larger Image
-(void)paintPartOfImageWithContext:(CGContextRef)context andRawImage:(CGImageRef)rawImage {
    CGRect myImageArea; // 局部区域
    CGImageRef mySubimage; // 原始图片
    CGRect myRect; // 后来显示区域
    
    myImageArea = CGRectMake (0, 0, 100, 100);
    
    // 裁剪出的局部图像
    mySubimage = CGImageCreateWithImageInRect (rawImage, myImageArea);
    
    myRect = CGRectMake(0, 0, 200, 200);
    
    // 在 myRect 中绘制出来。
    CGContextDrawImage(context, myRect, mySubimage);
}

-(void)getCGImageFromBitmap:(CGContextRef)bitmapContext {
    CGImageRef myImage;
    myImage = CGBitmapContextCreateImage (bitmapContext);
}

@end
