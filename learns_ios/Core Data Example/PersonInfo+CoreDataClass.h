//
//  PersonInfo+CoreDataClass.h
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonFamily, PersonSchool;

NS_ASSUME_NONNULL_BEGIN

@interface PersonInfo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "PersonInfo+CoreDataProperties.h"
