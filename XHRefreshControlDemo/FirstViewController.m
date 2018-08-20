//
//  FirstViewController.m
//  XHRefreshControlDemo
//
//  Created by xiaohui on 2018/8/20.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    self.dataSource = [NSMutableArray arrayWithArray:@[@0, @1, @2, @3, @4]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 49)];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"RefreshData" object:nil];
}

- (void)refreshData {
    //新增一条数据
    [self.dataSource insertObject:[self.dataSource firstObject] atIndex:0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        if ([self.tableView.refreshControl isRefreshing]) {
            [self.tableView.refreshControl endRefreshing];
        }
    });
}

- (void)loadData:(NSNotification *)notification {
    if ([notification.userInfo[@"selectedTabBarItemIndex"]integerValue] == 0) {
        NSLog(@"first page execute load data");
        //animated不要为YES，否则菊花会卡死
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y - self.tableView.refreshControl.frame.size.height - 15) animated:NO];
        [self.tableView.refreshControl beginRefreshing];
        [self.tableView.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"请下拉刷新页面";
    return cell;
}

@end
