//
//  LICDESimpleModel.m
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

#import "LICDESimpleModel.h"
#import <CoreData/CoreData.h>
#import "LI.h"
#import "PersonInfo+CoreDataClass.h"

@interface LICDESimpleModel ()

// ios10开始的新封装对象
@property(nonatomic, nullable, readonly) NSPersistentCloudKitContainer *container;

// 主Context
// 从事同界面（UI）有关的工作，主要用来从持久化存储中获取 UI 显示所需数据。
@property(nonatomic, nullable, readonly) NSManagedObjectContext *mainContext;

// 私有队列Context，串行队列
// 私有队列上下文在创建时将创建它自己的队列，且只能在它自己创建的队列上使用。
// 主要适用于执行时间较长，如果运行在主队列可能会影响 UI 响应的操作。
@property(nonatomic, nullable, readonly) NSManagedObjectContext *backgroundContext;

@end

@implementation LICDESimpleModel

+ (instancetype)shared {
    static dispatch_once_t once;
    static LICDESimpleModel * intance;
    dispatch_once(&once, ^{
        intance = [[LICDESimpleModel alloc] init];
    });
    return intance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (@available(iOS 10, macOS 10.12, *)) {
            // 此函数仅仅App初始化时使用，所以不需要同步
            _container = [[NSPersistentCloudKitContainer alloc] initWithName:@"LI"];
            [_container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull desc, NSError * _Nullable error) {
                                if (error != nil) {
                                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                                    abort();
                                }
            }];
            _mainContext = _container.viewContext;
            _backgroundContext = _container.newBackgroundContext;
        } else {
            
            // 创建托管对象模型，并使用Student.momd路径当做初始化参数
            // .xcdatamodeld文件 编译之后变成.momd文件  （.mom文件）
            NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"LI" withExtension:@"momd"];
            NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
            
            // 创建持久化存储调度器
            NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
            
            // 此需要使用异步，防止阻塞
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
                // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
                NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
                dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite",@"LI"];
                
                // 添加数据库
                [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
            });
            
            // 创建上下文对象，并发队列设置为主队列
            _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            _mainContext.persistentStoreCoordinator = coordinator;
            
            _backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            _backgroundContext.persistentStoreCoordinator = coordinator;
        }
    }
    return self;
}

- (NSError *)insert:(PersonInfo *)info {
    NSError *err = nil;
    
    NSManagedObjectContext *context = self.backgroundContext;
    
    PersonInfo *person = [NSEntityDescription insertNewObjectForEntityForName:@"PersonInfo" inManagedObjectContext:self.mainContext];
    
    person.name = info.name;
    person.height = info.height;
    person.age = info.age;
    person.birth = info.birth;
    person.man = info.man;
    person.school = info.school;
    person.family = info.family;
    
    // 此为单线程下
    // 如果多线程，需要使用 performBlock
    [self save:context withErr:err];
    
    return err;
}

- (NSError *)delete:(NSString *)name withEntity:(NSString *)entity {
    __block NSError *err = nil;
    
    NSManagedObjectContext *context = self.backgroundContext;
    [context performBlock:^{
        // 构造请求
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entity];
        // 过滤
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name == %@", name];
        req.predicate = pre;
        
        // 拿到查询的对象，然后删除
        NSArray * re = [self.mainContext executeFetchRequest:req error:&err];
        [re enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.mainContext deleteObject:obj];
        }];
        
        [self save:context withErr:err];
    }];
    
    return err;
}

- (NSError *)update:(PersonInfo *)info withEntity:(NSString *)entity {
    
    __block NSError *err = nil;
    
    
    NSManagedObjectContext *context = self.backgroundContext;
    [context performBlock:^{
        
        // 构造请求
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entity];
        // 过滤
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name == %@", info.name];
        req.predicate = pre;
        
        // 拿到查询的对象，然后删除
        NSArray<PersonInfo *> * re = [self.mainContext executeFetchRequest:req error:&err];
        [re enumerateObjectsUsingBlock:^(PersonInfo *  _Nonnull person, NSUInteger idx, BOOL * _Nonnull stop) {
            person.name = info.name;
            person.height = info.height;
            person.age = info.age;
            person.birth = info.birth;
            person.man = info.man;
            person.school = info.school;
            person.family = info.family;
        }];
        
        [self save:context withErr:err];
    }];
    
    return err;
}

- (PersonInfo *)queryName:(NSString *)name withEntity:(NSString *)entity {
    
    __block PersonInfo * ret = nil;
    
    [self.mainContext performBlockAndWait:^{
        NSError * err;
        
        // 构造请求
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:entity];
        // 过滤
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@", name];
        req.predicate = pre;
        
        ret = [self.mainContext executeFetchRequest:req error:&err].firstObject;
    }];
    
    return ret;
}

- (void)save:(NSManagedObjectContext *)context withErr:(NSError *)err {
    context.hasChanges && [context save:&err];
}

@end
