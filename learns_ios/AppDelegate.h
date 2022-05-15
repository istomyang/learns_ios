//
//  AppDelegate.h
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nullable, nonatomic, strong) UIWindow *window API_AVAILABLE(ios(5.0));

@property (readonly, strong) NSPersistentCloudKitContainer * _Nullable persistentContainer;

- (void)saveContext;

@end

