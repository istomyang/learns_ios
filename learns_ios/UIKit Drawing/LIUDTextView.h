//
//  LIUDTextView.h
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import <UIKit/UIKit.h>
#import "LIBaseView.h"
#import "LI.h"

typedef NS_ENUM(NSUInteger, Lesson) {
    LessonSimpleTextAtPoint = 0,
    LessonSimpleTextAtRect,
    LessonAttrString,
    LessonAttrStringRange,
    LessonFull,
    LessonTextAroundBezierPath,
    LessonTextMatrix
};

NS_ASSUME_NONNULL_BEGIN

@interface LIUDTextView : LIBaseView

- (instancetype)initWithLesson:(Lesson)le;

@end

NS_ASSUME_NONNULL_END
