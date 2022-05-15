//
//  CustomAcivity.m
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "CustomAcivity.h"

@implementation CustomAcivity
{
    NSArray * items;
}

- (UIActivityType)activityType {
    return @"CustomAcivityTypeListItemsAndTypes";
}

- (NSString *)activityTitle {
    return @"Custom Activity";
}

- (UIImage *)activityImage {
    return [UIImage systemImageNamed:@"camera.macro"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    items = activityItems;
}

- (UIViewController *)activityViewController {
    UIViewController *vc = [[UIViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}

@end
