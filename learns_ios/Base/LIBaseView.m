//
//  LIBaseView.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
//  通用的测试功能View

#import "LIBaseView.h"
#import "LI.h"

@implementation LIBaseView

-(instancetype)initWithLongPress:(BOOL)enabledLP withSize:(CGSize * _Nullable )size withBGColor:(UIColor * _Nullable )color {
    self = [super init];
    if (self) {
        if (enabledLP) {
            [self setupLongPressRemove];
        }
        if (size) {
            self.frame = CGRectMake(0, 0, size->width, size->height);
            self.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        }
        if (color) {
            self.backgroundColor = color;
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor greenColor].CGColor;
    }
    return self;
}

#pragma mark - 长按remove
-(void)setupLongPressRemove {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
    [self addGestureRecognizer:recognizer];
}

@end
