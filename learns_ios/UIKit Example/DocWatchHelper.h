//
//  DocWatchHelper.h
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kDocWatchHelperDocumentChanged @"DocumentsFolderContentsDidChangeNotification"

/// 对文件夹的变化监控通知
@interface DocWatchHelper : NSObject

@property(nonatomic, strong, nullable) NSString * path;

+ (instancetype)watcherForPath:(NSString *)aPath;

@end

NS_ASSUME_NONNULL_END
