//
//  LIUDTextSimpleView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LIUDTextView.h"
#import "UIColor+U.h"
#import <CoreText/CoreText.h>

@implementation LIUDTextView
{
    Lesson lesson;
    CGRect rect; // View内的Frame
}

-(void)drawProxy {
    switch (lesson) {
        case LessonSimpleTextAtPoint:
            [self drawSimpleText:YES];
            break;
        case LessonSimpleTextAtRect:
            [self drawSimpleText:NO];
            break;
        case LessonAttrString:
            [self drawAttrString];
            break;
        case LessonAttrStringRange:
            [self drawAttrStringRange];
            break;
        case LessonFull:
            [self drawFull];
            break;
        case LessonTextAroundBezierPath:
            [self drawTextWithMatrix];
            break;
        default:
            break;
    }
}

#pragma mark - 围绕Path绘制文字
-(void)drawTextByPath {
    
//    U_FillRect(rect, [UIColor whiteColor]);
//
//    CGRect inset = U_MakeRectInsetByPercent(targetRect, 0.2f);
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//    U_PathFitToRect(path, inset);
//
//    NSMutableAttributedString *string = [self longString];
//    for (int i = 0; i < string.length; i++)
//    {
//        UIColor *c = [UIColor U_randomColor];
//        [string addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(i, 1)];
//    }
//
//    [[path bezierPathByReversingPath].CGPath drawAttributedString:string];

    
}

#pragma mark - CoreText：改变Matrix
-(void)drawTextWithMatrix {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, kScreenWidth, 200)];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"AAAAAAAA"];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGAffineTransform t = CGAffineTransformIdentity;
    t = CGAffineTransformRotate(t, U_RadiansFromDegrees(180));
    CGContextSetTextMatrix(context, t);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) string);
    CTFrameRef theFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, string.length), path.CGPath, NULL);
    
    CTFrameDraw(theFrame, context);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CTFrameDraw(theFrame, context);
}

#pragma mark - 在Path曲线内布局文字
-(void)drawTextInsidePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, kScreenWidth, 200)];
    U_PathFitToRect(path, CGRectMake(0, 0, kScreenWidth, 250));
    path.lineWidth = 2.0f;
    
    
    NSMutableAttributedString *string = [self longString];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) string);
    CTFrameRef theFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, string.length), path.CGPath, NULL);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    U_PushDraw(^{
        [path stroke];
    });
    
    U_PushDraw(^{
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CTFrameDraw(theFrame, UIGraphicsGetCurrentContext());
    });
    
    CFRelease(theFrame);
    CFRelease(framesetter);
}


#pragma mark - 完全的富文本操作
-(void)drawFull {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Hello World"];
    
    NSDictionary<NSAttributedStringKey, id> * attrs1 = @{
        // 字体
        NSFontAttributeName: [UIFont fontWithName:@"Futura" size:26.0f],
        
        // 前景色
        NSForegroundColorAttributeName: [UIColor greenColor],
        
        // 背景色
        NSBackgroundColorAttributeName: [UIColor blueColor],
        
        // 用一个UIColor指定stroke的颜色。但在很多区域还是和前景色相同，当你在指定画笔宽度属性后才会生效。
        // 仅当使用负数笔画宽度时，才会与前景色有区别
        NSStrokeColorAttributeName: [UIColor systemPinkColor],
        
        // 画笔宽度，正数会创建一个“空心”的样式，仅在字符图像的边缘进行描画。
        NSStrokeWidthAttributeName: @3.0
    };
    [attributedString setAttributes:attrs1 range:NSMakeRange(0, 2)];
    
    NSDictionary<NSAttributedStringKey, id> * attrs2 = @{
        // 字体
        NSFontAttributeName: [UIFont fontWithName:@"Futura" size:26.0f],
        
        // 前景色
        NSForegroundColorAttributeName: [UIColor greenColor],
        
        // 用一个UIColor指定stroke的颜色。但在很多区域还是和前景色相同，当你在指定画笔宽度属性后才会生效。
        // 仅当使用负数笔画宽度时，才会与前景色有区别
        NSStrokeColorAttributeName: [UIColor systemPinkColor],
        
        // 画笔宽度，负数会同时描边（使用stroke color）和填充（使用foreground color）文本
        NSStrokeWidthAttributeName: @-3.0,
        
        // 定义了项目是否使用删除线。使用0表示不使用删除线，1表示使用。
        NSStrikethroughStyleAttributeName: @1,
        
        // 指定删除线的颜色。
        NSStrikethroughColorAttributeName: [UIColor redColor],
        
        // 更多参见：
        // https://github.com/wangdicen/iOS-Drawing-Practical-UIKit-Soluations-Translation/blob/master/8-%E7%BB%98%E5%88%B6%E6%96%87%E6%9C%AC/8-%E7%BB%98%E5%88%B6%E6%96%87%E6%9C%AC.md#%E5%B1%9E%E6%80%A7%E7%A7%8D%E7%B1%BB
        
    };
    [attributedString setAttributes:attrs2 range:NSMakeRange(3, 5)];
    
    CGPoint drawingPoint = CGPointMake(10, 10);
    [attributedString drawAtPoint: drawingPoint];
}

#pragma mark - 可变的属性字符串
-(void)drawAttrStringRange {
    //Build mutable attributed string
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Hello World"];

    //Set the range for adding attributes
    NSInteger len = attributedString.length;
    NSRange r1 = NSMakeRange(0, 2);
    NSRange r2 = NSMakeRange(2, len - 2); // 可能屁股后面有个换行符？？？

    //Set font
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Futura" size:26.0f] range:r1];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Futura" size:36.0f] range:r2];

    //Set the Color
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:r1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:r2];
    
    CGPoint drawingPoint = CGPointMake(10, 10);

    //Draw the attributed string
    [attributedString drawAtPoint: drawingPoint];
}

#pragma mark - 属性字符串
-(void)drawAttrString {
    //Create an attributes dictionary
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

    //Set the font
    attributes[NSFontAttributeName] = [UIFont fontWithName:@"futura" size:36.0f];

    //Set the foreground color
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];

    //Build an attributed string with the dictionary
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithString:@"Hello World"
                                            attributes:attributes];
    
    CGPoint drawingPoint = CGPointMake(10, 10);

    //Draw the attributed string
    [attributedString drawAtPoint:drawingPoint];
}

#pragma mark - 简单文本
// TODO: 动态文本
// 字符串绘制提供两种API调用：点和矩阵。两者都适用于NSString和NSAttributedString类。经验是：
// 1. 像代码8-1提供的点方法，绘制一行——不管任何你定义的换行属性。渲染区域的宽度被视为无限大。
// 2. rect版本的绘制，必须绘制在你指定的边界内。任何超出边界的部分都会被裁剪。
-(void)drawSimpleText:(BOOL)atPoint {
    NSString *string = @"Hello World";
    UIFont *font = [UIFont fontWithName:@"Futura" size:36.0f];

    //Starting in iOS 7, all string drawing uses attributes
    NSDictionary *attributes = @{
        NSFontAttributeName:font,
        NSForegroundColorAttributeName:[UIColor grayColor]};

    if (atPoint) {
        CGPoint drawingPoint = CGPointMake(10, 10);
        [string drawAtPoint:drawingPoint withAttributes:attributes];
    } else {
        CGRect drawingRect = CGRectMake(0, 0, kScreenWidth, 100);
        [string drawInRect:drawingRect withAttributes:attributes];
    }
}

- (instancetype)initWithLesson:(Lesson)le {
    CGSize size = CGSizeMake(kScreenWidth, 300);
    self = [super initWithLongPress:YES withSize:&size withBGColor:nil];
    rect = U_MakeRectSize(size);
    lesson = le;
    return self;
}

-(void)drawRect:(CGRect)rect {
    [self drawProxy];
}

-(NSMutableAttributedString *)shortString {
    NSString *aliceString = @"Hey, World!";
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:aliceString];
    NSRange fullRange = NSMakeRange(0, string.length);
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Futura" size:14.0f] range:fullRange];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    [string addAttribute:NSParagraphStyleAttributeName value:style range:fullRange];
    return string;
}

-(NSMutableAttributedString *)longString {
    NSString *aliceString = @"Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, `and what is the use of a book,' thought Alice `without pictures or conversation?'\n\nSo she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.\n\nThere was nothing so very remarkable in that; nor did Alice think it so very much out of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be late!' (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge.";
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:aliceString];
    NSRange fullRange = NSMakeRange(0, string.length);
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Futura" size:14.0f] range:fullRange];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    [string addAttribute:NSParagraphStyleAttributeName value:style range:fullRange];
    return string;
}

@end
