//
//  PersonFamily+CoreDataProperties.m
//  
//
//  Created by 杨洋 on 24/5/2022.
//
//

#import "PersonFamily+CoreDataProperties.h"

@implementation PersonFamily (CoreDataProperties)

+ (NSFetchRequest<PersonFamily *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PersonFamily"];
}

@dynamic father;
@dynamic mother;
@dynamic dog;
@dynamic cat;
@dynamic address;
@dynamic name;
@dynamic info;

@end
