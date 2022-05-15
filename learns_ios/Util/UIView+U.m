//
//  UIView+U.m
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "UIView+U.h"

@implementation UIView (U)

-(UIViewController *)vcHost {
    UIResponder *responder = [self nextResponder];
     while (responder != nil) {
         if ([responder isKindOfClass:[UIViewController class]]) {
             return (UIViewController *)responder;
         }
         responder = [responder nextResponder];
     }
     return nil;
}

@end
