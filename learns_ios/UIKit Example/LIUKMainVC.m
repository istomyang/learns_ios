//
//  LIUiKitMainVC.m
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "LIUKMainVC.h"
#import "LIUKAppStructureView.h"

@interface LIUKMainVC ()<UITextViewDelegate>

@end

@implementation LIUKMainVC
{
    UITextView *inputView;
}

- (instancetype)init {
    self = [super initWithCells:@{
        @"剪切板的使用": ^{ [self setupLIUIAppStructureView:TypesPasteBoard]; },
        @"UIActivity使用": ^{ [self setupLIUIAppStructureView:TypesUIActivity]; }
    } andTitle:@"UIKit Example"];
    return self;
}

- (void)setupLIUIAppStructureView:(Types)type {
    [self.view addSubview:({
        LIUKAppStructureView * view = [[LIUKAppStructureView alloc] initWithTypes:type];
        view;
    })];
}

@end
