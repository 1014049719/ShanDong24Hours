//
//  AppDelegate.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-19.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "PPRevealSideViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "ZGYSideslipViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    MyTabBarController *myTBC=[[MyTabBarController alloc] init];
    LeftViewController *leftVCL=[[LeftViewController alloc] init];
    RightViewController *rightVCL=[[RightViewController alloc] init];
    
    //装载侧滑视图
    ZGYSideslipViewController *sidelip=[[ZGYSideslipViewController alloc] initWithLeftView:leftVCL andMainView:myTBC andRightView:rightVCL andBackGroundImgView:@"抽屉背景"];
    self.window.rootViewController=sidelip;
    
    //设置状态栏
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, 20)];
    bgView.backgroundColor = [UIColor blackColor];
    [self.window addSubview:bgView];
    
    

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
