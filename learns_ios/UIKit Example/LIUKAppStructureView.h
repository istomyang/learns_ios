//
//  LIUKAppStructureView.h
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "LIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Types) {
    TypesPasteBoard = 0,
    TypesUIActivity
};

@interface LIUKAppStructureView : LIBaseView

- (instancetype)initWithTypes:(Types)type;

@end

NS_ASSUME_NONNULL_END
