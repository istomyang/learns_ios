//
//  LICDESimpleModel.h
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@class PersonInfoType;
//
//@interface PersonFamilyType
//
//@property (nullable, nonatomic, strong) NSString *father;
//@property (nullable, nonatomic, strong) NSString *mother;
//@property (nullable, nonatomic, strong) NSString *dog;
//@property (nullable, nonatomic, strong) NSString *cat;
//@property (nullable, nonatomic, strong) NSString *address;
//@property (nullable, nonatomic, strong) NSString *name;
//@property (nullable, nonatomic, strong) PersonInfoType *info;
//
//@end
//
//@interface PersonSchoolType
//
//@property (nonatomic) int16_t score;
//@property (nonatomic) int16_t classroom;
//@property (nullable, nonatomic, strong) NSString *name;
//@property (nullable, nonatomic, strong) PersonInfoType *info;
//
//@end
//
//@interface PersonInfoType
//
//@property (nullable, nonatomic, strong) NSString *name;
//@property (nonatomic) int16_t age;
//@property (nonatomic) int16_t height;
//@property (nonatomic) BOOL man;
//@property (nullable, nonatomic, strong) NSDate *birth;
//@property (nullable, nonatomic, strong) PersonSchoolType *school;
//@property (nullable, nonatomic, strong) PersonFamilyType *family;
//
//@end

@interface LICDESimpleModel : NSObject

+ (instancetype)shared;


@end

NS_ASSUME_NONNULL_END
