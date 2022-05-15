//
//  LIUIMainVC.m
//  learns_ios
//
//  Created by 杨洋 on 15/5/2022.
//

#import "LIUIMainVC.h"
#import "LI.h"
#import "LIUIMoveView.h"
#import "LIUIMoveView2.h"
#import "LIUIDragView.h"
#import "LIUIPaintView.h"
#import "LIUIDragViewOutside.h"
#import "LIUIMenuView.h"

// TODO: 使用 LIBaseShowVC

@interface LIUIMainVC ()<UITableViewDataSource, UITableViewDelegate>

@property(nullable, nonatomic, strong) UITableView * tableView;

@end

@implementation LIUIMainVC

{
    NSDictionary<NSString *, SetUI> * cells;
    NSArray<NSString *> * cellsKeys;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        cells = @{
            @"跟随手指移动": ^{ [self setViewForFollowFingerMoving]; },
            @"跟随手指移动(UIPanGestureRecognizer)": ^{ [self setViewUseUIPanGestureRecognizer]; },
            @"多手势识别器": ^{ [self setViewMutiGesture]; },
            @"绘图（没有做平滑处理，详看注释）": ^{ [self setViewPaint]; },
            @"把视图从ScrollView拖到外面（未实现展示）": ^{ [self setViewOutside]; },
            @"在View上使用菜单栏": ^{ [self setViewMenu]; }
        };
        cellsKeys = cells.allKeys;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"手势与触摸";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 表格View
    CGFloat x = 0;
    CGFloat y = self.navigationController.navigationBar.frame.size.height;
    CGFloat w = kScreenWidth;
    CGFloat h = kScreenHeight - y;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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


#pragma mark - 跟随手指移动
- (void)setViewForFollowFingerMoving {
    LIUIMoveView * view = [[LIUIMoveView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    view.frame = CGRectMake(0, 0, 100, 100);
    view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    
    [self.view addSubview:view];
}

#pragma mark - 跟随手指移动(UIPanGestureRecognizer)
- (void)setViewUseUIPanGestureRecognizer {
    [self.view addSubview:({
        LIUIMoveView2 * view = [[LIUIMoveView2 alloc] init];
        view;
    })];
}

#pragma mark - 多手势识别器
- (void) setViewMutiGesture {
    [self.view addSubview:({
        UIView * view = [[LIUIDragView alloc] init];
        view.backgroundColor = [UIColor blueColor];
        view.frame = CGRectMake(0, 0, 100, 100);
        view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        view;
    })];
}

#pragma mark - 绘图
- (void) setViewPaint {
    [self.view addSubview:({
        UIView * view = [[LIUIPaintView alloc] init];
        view.frame = CGRectMake(0, 0, 200, 200);
        view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        view;
    })];
}

#pragma mark - 把视图从ScrollView拖到外面（未实现展示）
- (void) setViewOutside {
    [self.view addSubview:({
        UIView * view = [[LIUIDragViewOutside alloc] init];
        view.frame = CGRectMake(0, 0, 200, 200);
        view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        view;
    })];
}

#pragma mark - 在View上使用菜单栏
- (void) setViewMenu {
    [self.view addSubview:({
        UIView * view = [[LIUIMenuView alloc] init];
        view.frame = CGRectMake(0, 0, 200, 200);
        view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        view;
    })];
}

@end
