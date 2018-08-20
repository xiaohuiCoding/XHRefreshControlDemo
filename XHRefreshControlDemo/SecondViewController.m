//
//  SecondViewController.m
//  XHRefreshControlDemo
//
//  Created by xiaohui on 2018/8/20.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"second";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData:) name:@"RefreshData" object:nil];
}

- (void)loadData:(NSNotification *)notification {
    if ([notification.userInfo[@"selectedTabBarItemIndex"]integerValue] == 1) {
        NSLog(@"second page execute load data");
    }
}

@end
