//
//  LICGContextVC.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "LICGContextVC.h"
#import "LICGContextView.h"
#import "LI.h"

@interface LICGContextVC ()

@end

@implementation LICGContextVC

- (instancetype)init {
    self = [super initWithTitle:@"Context"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        LICGContextView *view = [[LICGContextView alloc] init];
        view.frame = self.contentFrame;
        view.backgroundColor = [UIColor whiteColor];
        view;
    })];
}

@end
