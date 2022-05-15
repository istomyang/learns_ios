//
//  LIUIDragView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
//  多手势识别器

#import "LIUIDragView.h"

@implementation LIUIDragView
{
    CGFloat tx;
    CGFloat ty; // transition y
    CGFloat scale; // zoom scale
    CGFloat theta; // rotation
    CGFloat saveScale; // zoom scale
    CGFloat saveTheta; // rotation
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.transform = CGAffineTransformIdentity;
        tx = 0.0f; ty = 0.0f; scale = 1.0f; theta = 0.0f;
        
        UIRotationGestureRecognizer *rot = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.gestureRecognizers = @[rot, pinch, pan];
        for (UIGestureRecognizer * recognizer in self.gestureRecognizers) {
            recognizer.delegate = self;
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.superview bringSubviewToFront:self];
    
    tx = self.transform.tx;
    ty = self.transform.ty;
    scale = saveScale;
    theta = saveTheta;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 3) {
        self.transform = CGAffineTransformIdentity;
        tx = 0.0f; ty = 0.0f; scale = 1.0f; theta = 0.0f;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)updateTransform:(CGPoint)translation {
    self.transform = CGAffineTransformMakeTranslation(translation.x + tx, translation.y + ty);
    self.transform = CGAffineTransformRotate(self.transform, theta);
    
    if (scale > 0.5f) {
        self.transform = CGAffineTransformScale(self.transform, scale, scale);
    } else {
        self.transform = CGAffineTransformScale(self.transform, 0.5f, 0.5f);
    }
}


-(void) handleRotation:(UIRotationGestureRecognizer *)uigr {
    theta = uigr.rotation;
    saveTheta += theta; // assert scale有正负
    [self updateTransform:CGPointZero];
}

-(void) handlePinch:(UIPinchGestureRecognizer *)uigr {
    scale = uigr.scale;
    saveScale += scale; // assert scale有正负
    [self updateTransform:CGPointZero];
}

-(void) handlePan:(UIPanGestureRecognizer *)uigr {
    CGPoint translation = [uigr translationInView:self.superview];
    [self updateTransform:translation];
}

// 多手势识别中，通过 UIGestureRecognizerDelegate 处理，比如，同时识别单机和双击，会导致识别延迟，或者某个识别需要等待另一个识别失败。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// 加一个另外功能，对不规则物体检测是否受测
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (!CGRectContainsPoint(self.bounds, point)) return NO;
    return YES;
    
    // 思路：
    // 某些简单矢量图形，可以通过简单的数学计算，返回Bool，决定是否受测。
    // 对于图像来说，一般得出该点的alpha值小于某值，决定是否受测。
}
@end
