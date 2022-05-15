//
//  LIUIMenuView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
//  在View上显示专用的菜单

#import "LIUIMenuView.h"

@implementation LIUIMenuView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *re = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressed:)];
        [self addGestureRecognizer:re];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)pressed:(UILongPressGestureRecognizer *)uigr {
    if (![self becomeFirstResponder]) {
    NSLog(@"Shoud become first");
        return;
    }
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *pop = [[UIMenuItem alloc] initWithTitle:@"Pop" action:@selector(popSelf)];
    UIMenuItem *rotate = [[UIMenuItem alloc] initWithTitle:@"Rotate" action:@selector(rotateSelf)];
    [menu setMenuItems:@[pop, rotate]];
    
    menu.arrowDirection = UIMenuControllerArrowDown;
    [menu update];
    [menu showMenuFromView:self rect: self.bounds];
}

- (void)popSelf {
    
}

- (void)rotateSelf {
    
}
@end
