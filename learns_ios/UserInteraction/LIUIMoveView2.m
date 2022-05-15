//
//  LIUIMoveView2.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
//  跟随手指移动的View（UIPanGestureRecognizer实现）

#import "LIUIMoveView2.h"
#import "LI.h"

@implementation LIUIMoveView2

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.frame = CGRectMake(0, 0, 100, 100);
        self.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)]];
    }
    return self;
}

-(void)handlePan:(UIPanGestureRecognizer*)sender {
    
    // 结束后，center取代原来的transform，transform归零。
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint center = CGPointMake(
                                     sender.view.center.x + sender.view.transform.tx,
                                     sender.view.center.y + sender.view.transform.ty);
        sender.view.center = center;
        CGAffineTransform transform = sender.view.transform;
        transform.tx = 0.0f;
        transform.ty = 0.0f;
        sender.view.transform = transform;
        
        return;
    }
    
    CGPoint translation = [sender translationInView:sender.view.superview];
    CGAffineTransform transform = sender.view.transform;
    transform.tx = translation.x;
    transform.ty = translation.y;
    sender.view.transform = transform;
}

@end
