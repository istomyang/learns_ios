//
//  LIBaseVC.m
//  learns_ios
//
//  Created by 杨洋 on 16/5/2022.
//

#import "LIBaseVC.h"

@interface LIBaseVC ()

@end

@implementation LIBaseVC

-(instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.navigationItem.title = title;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
@end
