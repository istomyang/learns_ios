//
//  LIBaseShowVC.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//
//  同用的表格展示VC

#import "LIBaseShowVC.h"
#import "UIVC+U.h"


@interface LIBaseShowVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation LIBaseShowVC
{
    UITableView * tableView;
    NSDictionary<NSString *, SetUI> * cells;
    NSArray<NSString *> * cellsKeys;
}

-(instancetype)initWithCells:(NSDictionary<NSString *, SetUI> *)newCells andTitle:(NSString *)title {
    self = [super initWithTitle:title];
    if (self) {
        cells = newCells;
        cellsKeys = newCells.allKeys;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 表格View
    CGFloat x = 0;
    CGFloat y = self.navigationController.navigationBar.frame.size.height;
    CGFloat w = kScreenWidth;
    CGFloat h = kScreenHeight - y;
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellsKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cell_id = @"cell_id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = cellsKeys[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = cellsKeys[indexPath.row];
    [cells objectForKey:key]();
}

@end
