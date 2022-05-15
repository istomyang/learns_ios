//
//  ViewController.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "LIUIMainVC.h"

// TODO: 研究表格，大标题，还有描述信息
@interface CellInfo : NSObject
@property(nonatomic, readonly) NSString * name;
@property(nonatomic, readonly) NSString * remarks;
@property(nonatomic, readonly) NSString * vcName;

+(instancetype)with:(NSString *)name withR:(NSString *)remarks withV:(NSString *)vcName;

@end

@implementation CellInfo
- (instancetype)initWithName:(NSString *)name withRemarks:(NSString *)remarks withVCClassName:(NSString *)vcName {
    self = [super init];
    if (self) {
        _name = name;
        _remarks = remarks;
        _vcName = vcName;
    }
    return self;
}

+ (instancetype)with:(NSString *)name withR:(NSString *)remarks withV:(NSString *)vcName {
    return [[CellInfo alloc] initWithName:name withRemarks:remarks withVCClassName:vcName];
}
@end

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nullable, nonatomic, strong) NSDictionary<NSString *, NSArray<CellInfo *> *> * cells;
@property(nullable, nonatomic, strong) NSArray<NSString *> * sections;

//@property(nullable, nonatomic, strong) UINavigationController *nnnn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showHeyWorld];
    
    self.cells = @{
        @"UIKit": @[
            [CellInfo with:@"User Interactions" withR:@"" withV:@"LIUIMainVC"],
            [CellInfo with:@"Drawing" withR:@"" withV:@"LIUDMainVC"]
        ],
        @"UIkit Example": @[
            [CellInfo with:@"App Structure" withR:@"" withV:@"LIUKMainVC"],
        ],
        @"WebKit": @[
            [CellInfo with:@"Hey, WKWebView!" withR:@"" withV:@"LIWKWebViewVC"]
        ],
        @"Core Graphics": @[
            [CellInfo with:@"CG Context" withR:@"" withV:@"LICGContextVC"],
        ]
    };
    
    self.sections = self.cells.allKeys;
}

- (void) showHeyWorld {
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init]; // 输入右括号会自动补全；
        label.text = @"Hey World!";
        [label sizeToFit]; // 重新计算元素的宽高。
        label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        label.userInteractionEnabled = YES;
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterInHome)]];
        label;
    })];
}

-(void) enterInHome {
    UITableViewController *tableCtrl = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self configTable:tableCtrl];
    [self.navigationController pushViewController:tableCtrl animated:YES];
}

#pragma mark - Table: config

- (void)configTable:(nonnull UITableViewController *)tableCtrl {
    UITableView *table = tableCtrl.tableView;
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine; // 默认
    
    tableCtrl.navigationItem.title = @"Table of Content";
}

#pragma mark - Table: dataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *id = @"table_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    cell.textLabel.text = [[self.cells objectForKey:self.sections[indexPath.section]] objectAtIndex:indexPath.row].name;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cells valueForKey:self.sections[section]].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cells.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.cells allKeys] objectAtIndex:section];
}

#pragma mark - Table: delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * className = self.cells[self.sections[indexPath.section]][indexPath.row].vcName;
    Class class1 = NSClassFromString(className);
    ViewController *vc = [[class1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
