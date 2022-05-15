//
//  LIBaseViewExample.m
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "LIBaseViewExample.h"
#import "LI.h"

@implementation LIBaseViewExample
{
    Types type; // 当前的类型
    CGRect rect; // View内的Frame
}

- (instancetype)initWithTypes:(Types)type {
    CGSize size = CGSizeMake(kScreenWidth, 300);
    self = [super initWithLongPress:YES withSize:&size withBGColor:nil];
    rect = U_MakeRectSize(size);
    type = type;
    return self;
}

@end
