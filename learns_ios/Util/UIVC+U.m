//
//  UIViewController+U.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "UIVC+U.h"
#import "Util.h"

@implementation UIViewController (U)

-(CGPoint)centerPointNavBar {
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height;
    return CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - barHeight);
}

-(CGRect)contentFrame {
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height;
    return CGRectMake(0, kScreenHeight - barHeight, kScreenWidth, kScreenHeight - barHeight);
}

-(CGPoint)contentStartPoint {
    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height;
    return CGPointMake(0, barHeight);
}

@end
