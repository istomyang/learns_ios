//
//  PersonInfo+CoreDataProperties.m
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import "PersonInfo+CoreDataProperties.h"

@implementation PersonInfo (CoreDataProperties)

+ (NSFetchRequest<PersonInfo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PersonInfo"];
}

@dynamic name;
@dynamic age;
@dynamic height;
@dynamic man;
@dynamic birth;
@dynamic school;
@dynamic family;

@end
