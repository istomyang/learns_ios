//
//  LIWKWebViewVC.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "LIWKWebViewVC.h"
#import <WebKit/WebKit.h>
#import "LI.h"

@interface LIWKWebViewVC ()

@end

@implementation LIWKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    CGFloat barHeight = self.navigationController.navigationBar.frame.size.height;
    [self.view addSubview:({
        CGRect rect = CGRectMake(0, barHeight, kScreenWidth, kScreenHeight - barHeight);
//        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:rect];
        [webView loadRequest:request];
        webView;
    })];
}

@end
