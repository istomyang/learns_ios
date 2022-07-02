//
//  LIFEPredicateExample.m
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

/*
 
 苹果官网：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/AdditionalChapters/Introduction.html#//apple_ref/doc/uid/TP40001798-SW1
 
 谓词有两种类型，称为比较和复合：
 1. 比较谓词使用运算符比较两个表达式。
 2. 复合谓词比较两个或多个其他谓词的评估结果，或否定另一个谓词。
 
 谓词类型：
 1. Simple comparisons, such as grade == 7 or firstName like 'Mark'
 2. 不区分大小写或变音符号的查找，例如name contains[cd] 'citroen'
 3. 逻辑运算，例如(firstName beginswith 'M') AND (lastName like 'Adderley')
 
 NSPredicate有两个子类，NSComparisonPredicate和NSCompoundPredicate，前比较谓词，后复合谓词。
 
 约束和限制：
 1 谓词查询没有特定的实现语言；根据后备存储的要求（如果确实有的话），谓词查询可能会被转换为 SQL、XML 或其他格式。
 2 并非所有后备存储都支持所有可能的谓词查询，并且并非所有后备存储支持的所有操作都可以用NSPredicate对象NSExpression来表示。
 3 如果您尝试使用不受支持的运算符，后端可能会降级谓词（例如，它可能使区分大小写的比较不区分大小写）或引发异常。例如：
    1 matches运算符使用regex, 所以不受 Core Data 的 SQL 存储支持——尽管它确实适用于内存过滤。
    2 Core Data SQL 存储每个查询仅支持一对多操作；
    3 ANYKEY运算符只能与 Spotlight 一起使用
    4 Spotlight 不支持关系。
 
 */

#import "LIFEPredicateExample.h"

@implementation LIFEPredicateExample

#pragma mark - 创建谓词
- (void)createPredicate {
    /*
     创建谓词有三种方法：使用格式字符串、直接在代码中和从谓词模板。

     格式化字符串摘要
     
     @"attributeName == %@"
     
     @"%K == %@" %K 替换属性
     
     @"name IN $NAME_LIST"
     
     @"'name' IN $NAME_LIST"
     
     @"$name IN $NAME_LIST"
     
     @"%K == '%@'" 这个需要注意，单引号意思是不被处理
     */
    
    // 对某个对象
    // like[cd]是一个修改后的“like”运算符，它不区分大小写和变音符号。
    NSPredicate *predicate = [NSPredicate
        predicateWithFormat:@"(lastName like[cd] %@) AND (birthday > %@)",
                @"name", @""];
    
    // 通配符，注意加引号，并且转义
    // %@ 会自动加上引号
    predicate = [NSPredicate
        predicateWithFormat:@"lastName like[c] \"S*\""];
    
    // 另一种通配符
    // 对字符串本身
    NSString *prefix = @"prefix";
    NSString *suffix = @"suffix";
    predicate = [NSPredicate
        predicateWithFormat:@"SELF like[c] %@",
        [[prefix stringByAppendingString:@"*"] stringByAppendingString:suffix]];
    [predicate evaluateWithObject:@"prefixxxxxxsuffix"];
    
    // 会引发错误，因为需要用引号
    predicate = [NSPredicate
        predicateWithFormat:@"SELF like[c] %@*%@", prefix, suffix];
    [predicate evaluateWithObject:@"prefixxxxxxsuffix"];

    // Bool
    predicate = [NSPredicate predicateWithFormat:@"anAttribute == %@", [NSNumber numberWithBool:YES]];
    predicate = [NSPredicate predicateWithFormat:@"anAttribute == YES"];
    
    
    // 使用属性
    // 如果使用属性，必须是 %K
    NSString *attributeName = @"firstName";
    NSString *attributeValue = @"Adam";
    predicate = [NSPredicate predicateWithFormat:@"%K like %@",
            attributeName, attributeValue];

    
    // 复合谓词
    // 表示(revenue >= 1000000) and (revenue < 100000000)
    NSExpression *lhs = [NSExpression expressionForKeyPath:@"revenue"];
     
    NSExpression *greaterThanRhs = [NSExpression expressionForConstantValue:[NSNumber numberWithInt:1000000]];
    NSPredicate *greaterThanPredicate = [NSComparisonPredicate
        predicateWithLeftExpression:lhs // 左侧表达式
        rightExpression:greaterThanRhs // 右侧表达式
        modifier:NSDirectPredicateModifier
        type:NSGreaterThanOrEqualToPredicateOperatorType // 大于等于
        options:0];
     
    NSExpression *lessThanRhs = [NSExpression expressionForConstantValue:[NSNumber numberWithInt:100000000]];
    NSPredicate *lessThanPredicate = [NSComparisonPredicate
        predicateWithLeftExpression:lhs
        rightExpression:lessThanRhs
        modifier:NSDirectPredicateModifier
        type:NSLessThanPredicateOperatorType
        options:0];
     
    predicate = [NSCompoundPredicate andPredicateWithSubpredicates:
        @[greaterThanPredicate, lessThanPredicate]];
    
    
    // 谓词模板：后期需要运行 predicateWithSubstitutionVariables
    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:@"lastName like[c] $LAST_NAME"];
    
    // 上面，相当于
    NSExpression *lhs2 = [NSExpression expressionForKeyPath:@"lastName"];
    NSExpression *rhs2 = [NSExpression expressionForVariable:@"LAST_NAME"];
    predicateTemplate = [NSComparisonPredicate
        predicateWithLeftExpression:lhs2
        rightExpression:rhs2
        modifier:NSDirectPredicateModifier
        type:NSLikePredicateOperatorType
        options:NSCaseInsensitivePredicateOption];
    
    // 返回的新谓词是lastName LIKE[c] "Turner"
    predicate = [predicateTemplate predicateWithSubstitutionVariables:
        [NSDictionary dictionaryWithObject:@"Turner" forKey:@"LAST_NAME"]];
    
    // 如果要匹配空值，则必须在字典中提供空值， lastName LIKE[c] <null>
    predicate = [predicate predicateWithSubstitutionVariables: [NSDictionary dictionaryWithObject:[NSNull null] forKey:@"LAST_NAME"]];
}


#pragma mark - 创建谓词
- (void)usePredicate {
    
    /*
     如果您使用 Core Data 框架，数组方法提供了一种过滤现有对象数组的有效方法，而无需像 fetch 那样需要往返于持久数据存储。
     
     
     */
    
    // 文本是否在什么中
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", @[@"Stig", @"Shaffiq", @"Chris"]];
    BOOL result = [predicate evaluateWithObject:@"Shaffiq"];
    
    // 数组
    NSMutableArray *names = [@[@"Nick", @"Ben", @"Adam", @"Melissa"] mutableCopy];
     
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] 'b'"];
    NSArray *beginWithB = [names filteredArrayUsingPredicate:bPredicate];
    // 结果：beginWithB contains { @"Ben" }.
     
    NSPredicate *ePredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] 'e'"];
    [names filterUsingPredicate:ePredicate];
    // 结果：array now contains { @"Ben", @"Melissa" }
    
    
    // 对象的健路径
    NSString *departmentName = @"";
    predicate = [NSPredicate predicateWithFormat:@"department.name like %@", departmentName];
    
    // 至少一名员工的名字为“Matthew”的部门
    predicate = [NSPredicate predicateWithFormat:@"ANY employees.firstName like 'Matthew'"];

    // 如果要查找至少有一名员工的工资超过一定金额的部门，请使用ANY如下示例所示的运算符：
    float salary = 100.f;
    predicate = [NSPredicate predicateWithFormat:@"ANY employees.salary > %f", salary];
    
    
    // 里面包含空值
    NSString *firstName = @"Ben";
    NSArray *array = @[ @{ @"lastName" : @"Turner" },
                        @{ @"firstName" : @"Ben", @"lastName" : @"Ballard",
                           @"birthday": NSDate.now }];
     predicate = [NSPredicate predicateWithFormat:@"firstName like %@", firstName];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
     
    NSLog(@"filteredArray: %@", filteredArray);
    // Output:
    // filteredArray ({birthday = 1972-03-24 10:45:32 +0600; \\
                          firstName = Ben; lastName = Ballard;})
    
    
    NSDate *referenceDate = [NSDate dateWithTimeIntervalSince1970:0];
     
    predicate = [NSPredicate predicateWithFormat:@"birthday > %@", referenceDate];
    filteredArray = [array filteredArrayUsingPredicate:predicate];
     
    NSLog(@"filteredArray: %@", filteredArray);
    // Output:
    // filteredArray: ({birthday = 1972-03-24 10:45:32 +0600; \\
                           firstName = Ben; lastName = Ballard;})

    // 测试空值
    predicate = [NSPredicate predicateWithFormat:@"(firstName == %@) || (firstName = nil)", firstName];
    filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"filteredArray: %@", filteredArray);
    // Output:
    // filteredArray: ( { lastName = Turner; }, { birthday = 1972-03-23 20:45:32 -0800; firstName = Ben; lastName = Ballard; }
    
    predicate = [NSPredicate predicateWithFormat:@"firstName = nil"];
    BOOL ok = [predicate evaluateWithObject:[NSDictionary dictionary]];
     
    ok = [predicate evaluateWithObject:
        [NSDictionary dictionaryWithObject:[NSNull null] forKey:@"firstName"]];
    
    NSLog(@"%d", result);
}

@end
