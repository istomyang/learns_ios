//
//  PersonSchool+CoreDataProperties.m
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import "PersonSchool+CoreDataProperties.h"

@implementation PersonSchool (CoreDataProperties)

+ (NSFetchRequest<PersonSchool *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PersonSchool"];
}

@dynamic score;
@dynamic classroom;
@dynamic name;
@dynamic info;

@end
