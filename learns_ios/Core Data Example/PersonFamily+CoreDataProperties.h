//
//  PersonFamily+CoreDataProperties.h
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import "PersonFamily+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonFamily (CoreDataProperties)

+ (NSFetchRequest<PersonFamily *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *father;
@property (nullable, nonatomic, copy) NSString *mother;
@property (nullable, nonatomic, copy) NSString *dog;
@property (nullable, nonatomic, copy) NSString *cat;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) PersonInfo *info;

@end

NS_ASSUME_NONNULL_END
