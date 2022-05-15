//
//  LICGLayerView.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LICGLayerView.h"

@implementation LICGLayerView

// 美国国旗🇺🇸
-(void)paintWithContext:(CGContextRef)context withRect:(CGRect)contextRect {
    int          i, j,
    num_six_star_rows = 5,
    num_five_star_rows = 4;
    CGFloat      start_x = 5.0, // 为第一颗星的水平位置声明一个变量。
                 start_y = 108.0, // 为第一颗星的垂直位置声明一个变量。
    red_stripe_spacing = 34.0, // 为标志上的红色条纹之间的间距声明一个变量。
    h_spacing = 26.0,// 声明标志上星星之间水平间距的变量。
    v_spacing = 22.0;
    
    CGContextRef myLayerContext1,
                 myLayerContext2;
    CGLayerRef   stripeLayer,
                 starLayer;
    CGRect       myBoundingBox, // 声明指定将标志绘制到的位置（边界框）、条纹层和星域的矩形。
                 stripeRect,
                 starField;
    
    // 声明一个点数组，这些点指定描绘出一颗星的线。
    const CGPoint myStarPoints[] = {{ 5, 5},   {10, 15},
        {10, 15},  {15, 5},
        {15, 5},   {2.5, 11},
        {2.5, 11}, {16.5, 11},
        {16.5, 11},{5, 5}};
    
    stripeRect  = CGRectMake (0, 0, 400, 17); // 创建一个矩形，它是单个条纹的形状。.
    starField  =  CGRectMake (0, 102, 160, 119); // 创建一个矩形，它是星域的形状。
    
    myBoundingBox = CGRectMake (0, 0, contextRect.size.width,
                                     contextRect.size.height);
    
    // 条纹
    stripeLayer = CGLayerCreateWithContext (context,
                                            stripeRect.size, NULL);
    
    myLayerContext1 = CGLayerGetContext (stripeLayer);
    
    CGContextSetRGBFillColor (myLayerContext1, 1, 0 , 0, 1);
    CGContextFillRect (myLayerContext1, stripeRect);
    
    // 星星
    starLayer = CGLayerCreateWithContext (context,
                                          starField.size, NULL);
    myLayerContext2 = CGLayerGetContext (starLayer);
    CGContextSetRGBFillColor (myLayerContext2, 1.0, 1.0, 1.0, 1);
    CGContextAddLines (myLayerContext2, myStarPoints, 10);
    CGContextFillPath (myLayerContext2);
    
    // 保存状态
    CGContextSaveGState(context);
    for (i=0; i< 7;  i++)
    {
        // 绘制条纹层（由单个红色条纹组成）。
        CGContextDrawLayerAtPoint (context, CGPointZero, stripeLayer);
        // 平移当前变换矩阵，使原点位于必须绘制下一条红色条纹的位置。
        CGContextTranslateCTM (context, 0.0, red_stripe_spacing);
    }
    // 恢复状态
    CGContextRestoreGState(context);
    
    // 将填充颜色设置为适合星域的蓝色阴影。请注意，此颜色的不透明度为 1.0。尽管此示例中的所有颜色都是不透明的，但它们并非必须如此。
    // 您可以使用部分透明的颜色通过分层绘图创建漂亮的效果。回想一下，alpha 值 0.0 指定透明颜色。
    CGContextSetRGBFillColor (context, 0, 0, 0.329, 1.0);
    // 用蓝色填充星域矩形。您将此矩形直接绘制到窗口图形上下文中。如果您只绘制一次，请不要使用图层。
    CGContextFillRect (context, starField);
    
    CGContextSaveGState (context);
    // 平移 CTM，使原点位于星域中，位于第一行（底部）中的第一颗星（左侧）。
    CGContextTranslateCTM (context, start_x, start_y);
    for (j=0; j< num_six_star_rows;  j++)
    {
        for (i=0; i< 6;  i++)
        {
            // 将星形图层绘制到窗口图形上下文。回想一下，星层包含一颗白星。
            CGContextDrawLayerAtPoint (context,CGPointZero, starLayer);
            CGContextTranslateCTM (context, h_spacing, 0);
        }
        CGContextTranslateCTM (context, (-i*h_spacing), v_spacing);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM (context, start_x + h_spacing/2,
                           start_y + v_spacing/2);
    for (j=0; j< num_five_star_rows;  j++)
    {
        for (i=0; i< 5;  i++)
        {
            CGContextDrawLayerAtPoint (context, CGPointZero,
                                       starLayer);
            CGContextTranslateCTM (context, h_spacing, 0);
        }
        CGContextTranslateCTM (context, (-i*h_spacing), v_spacing);
    }
    CGContextRestoreGState(context);
    
    CGLayerRelease(stripeLayer);
    CGLayerRelease(starLayer);
}

@end
