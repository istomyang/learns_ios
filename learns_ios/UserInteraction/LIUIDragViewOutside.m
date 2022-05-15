//
//  LIUIDragViewOutside.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//  把视图从Scrollview中拖拽到外面


// TODO: 展示，把滚动试图的View拖拽到外面

#import "LIUIDragViewOutside.h"

#define Dx(p1, p2) (p2.x - p1.x)
#define Dy(p1, p2) (p2.y - p1.y)

typedef enum {
    TouchUnknow,
    TouchSwipeLeft,
    TouchSwipeRight,
    TouchSwipeUp,
    TouchSwipeDown,
} SwipeTypes;

// 手势的判断标准
const NSInteger kSwipeDragMin = 16;
const NSInteger kDragLimitMax = 12;

@interface LIUIDragViewOutside ()<UIGestureRecognizerDelegate>

@property(nonatomic) BOOL gestureWasHandled;
@property(nonatomic) int pointCount;
@property(nonatomic) CGPoint startPoint;
@property(nonatomic) SwipeTypes touchType;

@property(nonatomic, nullable, strong) UIView* dragView;
@end

@implementation LIUIDragViewOutside

-(instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        self.gestureRecognizers = @[pan];
    }
    return self;
}

// 允许多个手势同时识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handlePan:(UISwipeGestureRecognizer *)uigr {
    if (![self.superview isKindOfClass:[UIScrollView class]]) return;
    
    UIView *superSuper = self.superview.superview;
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    
    CGPoint touchLocation = [uigr locationInView:superSuper];
    
    if (uigr.state == UIGestureRecognizerStateBegan) {
        self.gestureWasHandled = NO;
        self.pointCount = 1;
        self.startPoint = touchLocation;
    }
    
    if (uigr.state == UIGestureRecognizerStateChanged) {
        self.pointCount++;
        
        float dx = Dx(touchLocation, self.startPoint);
        float dy = Dy(touchLocation, self.startPoint);
        
        BOOL finished = YES;
        
        // 给手势的类型定性
        if ((dx > kSwipeDragMin) && (ABS(dy) < kDragLimitMax))
            self.touchType = TouchSwipeLeft;
        else if ((-dx > kSwipeDragMin) && (ABS(dy) < kDragLimitMax))
            self.touchType = TouchSwipeRight;
        else if ((dy > kSwipeDragMin) && (ABS(dx) < kDragLimitMax))
            self.touchType = TouchSwipeUp;
        else if ((-dy > kSwipeDragMin) && (ABS(dx) < kDragLimitMax))
            self.touchType = TouchSwipeDown;
        else
            finished = NO;
        
        // 一旦给手势定性，就可以进行代码操作，创建或者其他之类的。
        if (!self.gestureWasHandled && finished && (self.touchType == TouchSwipeDown)) {
            self.dragView = [[UIView alloc] init];
            self.dragView.center = touchLocation;
            [superSuper addSubview:self.dragView];
            scrollView.scrollEnabled = NO;
            self.gestureWasHandled = YES;
        } else if (self.gestureWasHandled) {
            self.dragView.center = touchLocation;
        }
        
        // 重置
        if (uigr.state == UIGestureRecognizerStateEnded) {
            if (self.gestureWasHandled) {
                scrollView.scrollEnabled = YES;
            }
        }
    }
}
@end
