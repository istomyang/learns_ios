//
//  LIUIMoveView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
//  跟随手指移动的View

#import "LIUIMoveView.h"

@implementation LIUIMoveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.startPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    float dx = pt.x - self.startPoint.x;
    float dy = pt.y - self.startPoint.y;
    CGPoint newCenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    self.center = newCenter;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

@end
