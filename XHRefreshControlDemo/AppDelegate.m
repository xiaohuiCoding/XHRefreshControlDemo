//
//  AppDelegate.m
//  XHRefreshControlDemo
//
//  Created by xiaohui on 2018/8/20.
//  Copyright © 2018年 XIAOHUI. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, assign) NSUInteger selectedIndex;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    UINavigationController *navFirst = [[UINavigationController alloc] initWithRootViewController:firstVC];
    navFirst.tabBarItem.title = @"first";
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *navSecond = [[UINavigationController alloc] initWithRootViewController:secondVC];
    navSecond.tabBarItem.title = @"second";
    
    tabBarC.viewControllers = @[navFirst,navSecond];
    tabBarC.delegate = self;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarC;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//点击已选中的任意tabbarItem刷新对应的页面

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (self.selectedIndex == tabBarController.selectedIndex) {
        //TODO:刷新操作
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshData" object:nil userInfo:@{@"selectedTabBarItemIndex":@(self.selectedIndex)}];
    }
    self.selectedIndex = tabBarController.selectedIndex;
}

//点击已选中的某个tabbarItem刷新对应的页面

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if ([tabBarController.selectedViewController isEqual:tabBarController.viewControllers.firstObject]) {
//        if ([viewController isEqual:tabBarController.selectedViewController]) {
//            //TODO:刷新操作
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshData" object:nil];
//            return NO;
//        }
//    }
//    return YES;
//}

@end
