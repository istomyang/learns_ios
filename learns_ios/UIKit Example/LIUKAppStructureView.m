//
//  LIUKAppStructureView.m
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "LIUKAppStructureView.h"
#import "LI.h"
#import <CoreServices/UTType.h>
#import <UniformTypeIdentifiers/UTType.h>
#import <UniformTypeIdentifiers/UTTagClass.h>

#import "CustomAcivity.h"

@interface LIUKAppStructureView ()<UITextViewDelegate>

@end

@implementation LIUKAppStructureView
{
    Types thistype; // 当前的类型
    CGRect rect; // View内的Frame
    
    UITextView *inputView;
}

// 活动任务控制器
- (void)setupUIActivity {
    [self addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"Click" forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setupUIActivityAction)]];
        btn;
    })];

}

- (void)setupUIActivityAction {
    
    UIImage *img0 = [UIImage systemImageNamed:@"signature"];
    UIImage *img1 = [UIImage systemImageNamed:@"sunrise"];
    
    // TODO: 还需要深入的研究，iOS核心开发手册 11.4
    CustomAcivity *cus_act = [[CustomAcivity alloc] init];
    
    // 把数据直接进行分享
    UIActivityViewController *act = [[UIActivityViewController alloc] initWithActivityItems:@[img0, img1] applicationActivities:@[cus_act]];
    
    // TODO: 研究iPad上使用UIPopoverPresentationController
    [self.vcHost presentViewController:act animated:YES completion:nil];
}

//
- (void)setupDocuement {
    /*
     
     Application supports iTunes file sharing 用户通过iTunes访问文件夹
     
     */
}

// 剪切板
- (void)setupPasteBoard {
    // 通用剪切板
    // 还有搜索剪切板、应用程序专用的剪切板。
    UIPasteboard * board = [UIPasteboard generalPasteboard];
    // 应用程序专用的剪切板
    UIPasteboard * board2 = [UIPasteboard pasteboardWithUniqueName];
    // 共享剪切板，后面的Bool，表示是否永久存储
    UIPasteboard * board3 = [UIPasteboard pasteboardWithName:@"ty.learns.ios" create:(YES)];
    
    inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    inputView.delegate = self;
    
    [self addSubview:inputView];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    // 保存到剪切板
    [UIPasteboard generalPasteboard].string = textView.text;
}

- (NSString *)utiForExtension:(NSString *)ext {
    if (@available(iOS 15, *)) {
        return [UTType typeWithFilenameExtension:ext].identifier;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(
                                                                    (__bridge CFStringRef)UTTagClassFilenameExtension,
                                                                    (__bridge CFStringRef)ext,
                                                                    NULL);
#pragma clang diagnostic pop
    }
}

- (NSString *)utiForMIME:(NSString *)mime {
    if (@available(iOS 15, *)) {
        return [UTType typeWithMIMEType:mime].identifier;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(
                                                                    (__bridge CFStringRef)UTTagClassMIMEType,
                                                                    (__bridge CFStringRef)mime,
                                                                    NULL);
#pragma clang diagnostic pop
    }
}



- (void)setupUI {
    switch (thistype) {
        case TypesPasteBoard:
            [self setupPasteBoard];
            break;
        case TypesUIActivity:
            [self setupUIActivity];
            break;
        default:
            break;
    }
}

- (instancetype)initWithTypes:(Types)type {
    CGSize size = CGSizeMake(kScreenWidth, 400);
    self = [super initWithLongPress:YES withSize:&size withBGColor:[UIColor clearColor]];
    rect = U_MakeRectSize(size);
    thistype = type;
    [self setupUI];
    return self;
}

@end
