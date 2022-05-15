//
//  TouchView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "TouchView.h"

// 跟随手指的方块

@implementation TouchView
{
    NSSet *touches;
    UIView *fingers;
    UIColor *touchColor;
}

+ (instancetype)sharedInstance {
    static TouchView *shared = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        shared = [[TouchView alloc] initWithFrame:CGRectZero];
    });
    
    if (!shared.superview) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        shared.frame = window.frame;
        [window addSubview:shared];
    }
    
    return shared;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.multipleTouchEnabled = YES;
        touchColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        touches = nil;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)theTouches withEvent:(UIEvent *)event {
    touches = theTouches;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)theTouches withEvent:(UIEvent *)event {
    touches = theTouches;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    touches = nil;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    [[UIColor clearColor] set];
    CGContextFillRect(context, self.bounds);
    
    float size = 25.0f;
    
    for (UITouch *touch in touches) {
        [[[UIColor darkGrayColor] colorWithAlphaComponent:0.5f] set];
        CGPoint aPoint = [touch locationInView:self];
        CGContextAddEllipseInRect(context, CGRectMake(aPoint.x - size, aPoint.y - size, size * 2, size * 2));
        CGContextFillPath(context);
        
        float dsize = 1.0f;
        [touchColor set];
        aPoint = [touch locationInView:self];
        CGContextAddEllipseInRect(context, CGRectMake(
                                                      aPoint.x - size - dsize,
                                                      aPoint.y - size - dsize, 2 * (size - dsize), 2 * (size - dsize)) );
        CGContextFillPath(context);
    }
    
    touches = nil;
}

@end
