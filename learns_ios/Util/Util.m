//
//  Util.m
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "Util.h"

// 随机颜色
UIColor *U_RandomColor(void)
{
    CGFloat r = RAND_FROM_TO(0, 255);
    CGFloat g = RAND_FROM_TO(0, 255);
    CGFloat b = RAND_FROM_TO(0, 255);
    return [UIColor colorWithRed:r / 255 green:g / 255 blue:b / 255 alpha:1.0];
}

