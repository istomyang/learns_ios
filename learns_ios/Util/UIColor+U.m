//
//  UIColor+U.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "UIColor+U.h"
#import "Util.h"

@implementation UIColor (U)

+ (UIColor *)U_randomColor {
    CGFloat r = RAND_FROM_TO(0, 255);
    CGFloat g = RAND_FROM_TO(0, 255);
    CGFloat b = RAND_FROM_TO(0, 255);
    return [UIColor colorWithRed:r / 255 green:g / 255 blue:b / 255 alpha:1.0];
}

@end
