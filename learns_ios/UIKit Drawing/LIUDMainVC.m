//
//  LIUDTextVC.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LIUDMainVC.h"
#import "LI.h"
#import "LIUDTextView.h"

@interface LIUDMainVC ()

@end

@implementation LIUDMainVC

- (instancetype)init {
    self = [super initWithCells:@{
        @"文本：Point法绘制字符串": ^{ [self setupSimpleViewAtPoint:YES]; },
        @"文本：Rect法绘制字符串": ^{ [self setupSimpleViewAtPoint:NO]; },
        @"文本：属性字符串": ^{ [self setupAttrStringWithRange:NO]; },
        @"文本：局部改变的属性字符串": ^{ [self setupAttrStringWithRange:YES]; },
        @"文本：富文本操作": ^{ [self setupView:LessonFull]; },
        @"文本：文字在贝塞尔曲线内环绕": ^{ [self setupView:LessonTextAroundBezierPath]; },
        @"文本：使用CoreText改变Matrix": ^{ [self setupView:LessonTextMatrix]; }
    } andTitle:@"UIKit Drawing"];
    return self;
}

- (void)setupAttrStringWithRange:(BOOL)range {
    if (range) {
        [self setupView:LessonAttrStringRange];
    } else {
        [self setupView:LessonAttrString];
    }
}

- (void)setupSimpleViewAtPoint:(BOOL)atPoint {
    if (atPoint) {
        [self setupView:LessonSimpleTextAtPoint];
    } else {
        [self setupView:LessonSimpleTextAtRect];
    }
}

- (void)setupView:(Lesson)le {
    [self.view addSubview:({
        LIUDTextView * view = [[LIUDTextView alloc] initWithLesson:le];
        view;
    })];
}

@end
