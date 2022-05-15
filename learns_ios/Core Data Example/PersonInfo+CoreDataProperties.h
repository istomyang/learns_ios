//
//  PersonInfo+CoreDataProperties.h
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import "PersonInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonInfo (CoreDataProperties)

+ (NSFetchRequest<PersonInfo *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nonatomic) int16_t height;
@property (nonatomic) BOOL man;
@property (nullable, nonatomic, copy) NSDate *birth;
@property (nullable, nonatomic, retain) PersonSchool *school;
@property (nullable, nonatomic, retain) PersonFamily *family;

@end

NS_ASSUME_NONNULL_END
