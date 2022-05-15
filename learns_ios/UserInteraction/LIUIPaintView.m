//
//  LIUIPaintView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "LIUIPaintView.h"

@implementation LIUIPaintView
{
    UIBezierPath *path;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.multipleTouchEnabled = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    path = [UIBezierPath bezierPath];
    path.lineWidth = 4.0f;
    UITouch *touch = [touches anyObject];
    [path moveToPoint:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self drawLineToPoint:[touch locationInView:self]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self drawLineToPoint:[touch locationInView:self]];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)drawLineToPoint:(CGPoint)point {
    [path addLineToPoint:point];
    [self setNeedsDisplay]; // 触发drawRect
}

// TODO: 平滑算法，《iOS核心开发手册》第一章 1.9
- (void)drawRect:(CGRect)rect {
    [path stroke];
}
@end
