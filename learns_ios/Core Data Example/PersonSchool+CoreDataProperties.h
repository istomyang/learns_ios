//
//  PersonSchool+CoreDataProperties.h
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import "PersonSchool+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonSchool (CoreDataProperties)

+ (NSFetchRequest<PersonSchool *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) int16_t score;
@property (nonatomic) int16_t classroom;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) PersonInfo *info;

@end

NS_ASSUME_NONNULL_END
