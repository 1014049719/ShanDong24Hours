//
//  MyTabBarController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "MyTabBarController.h"
#import "NewsViewController.h"
#import "ActivityViewController.h"
#import "PromotionViewController.h"
#import "FoundViewController.h"
#import "MineViewController.h"
#import "PPRevealSideViewController.h"

@interface MyTabBarController ()
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NewsViewController *newsVCl=[[NewsViewController alloc] init];
    UINavigationController *nvc1=[[UINavigationController alloc] initWithRootViewController:newsVCl];
    UIImage *norimage1=[[UIImage imageNamed:@"tab新闻"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selsctimage1=[[UIImage imageNamed:@"tab新闻_高亮"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbaritem1=[[UITabBarItem alloc] initWithTitle:@"新闻" image:norimage1 selectedImage:selsctimage1];    
    newsVCl.tabBarItem = tabbaritem1;
    
    ActivityViewController *activityVCl=[[ActivityViewController alloc] init];
    UINavigationController *nvc2=[[UINavigationController alloc] initWithRootViewController:activityVCl];
    UIImage *norimage2=[[UIImage imageNamed:@"convenience_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selsctimage2=[[UIImage imageNamed:@"convenience_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbaritem2=[[UITabBarItem alloc] initWithTitle:@"活动" image:norimage2 selectedImage:selsctimage2];
    activityVCl.tabBarItem=tabbaritem2;
    
    PromotionViewController *proVCl=[[PromotionViewController alloc] init];
    UINavigationController *nvc3=[[UINavigationController alloc] initWithRootViewController:proVCl];
    UIImage *norimage3=[[UIImage imageNamed:@"discount_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectimage3=[[UIImage imageNamed:@"discount_hi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbaritem3=[[UITabBarItem alloc] initWithTitle:@"优惠" image:norimage3 selectedImage:selectimage3];
    proVCl.tabBarItem=tabbaritem3;
    
    FoundViewController *foundVCL=[[FoundViewController alloc] init];
    UINavigationController *nvc4=[[UINavigationController alloc] initWithRootViewController:foundVCL];
    UITabBarItem *tabbaritem4=[[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"tab活动"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab活动_高亮"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    foundVCL.tabBarItem=tabbaritem4;
    
    MineViewController *mineVCl=[[MineViewController alloc] init];
    UINavigationController *nvc5=[[UINavigationController alloc] initWithRootViewController:mineVCl];
    UITabBarItem *tabbaritem5=[[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tab我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab我的_高亮"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mineVCl.tabBarItem=tabbaritem5;
    
    //底部分隔线
    for (int i=0; i<4; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底部分隔线"]];
        imageView.frame=CGRectMake(60+i*64, self.view.bounds.size.height - 49, 8, 49);
        [self.view addSubview:imageView];
    }
    
    self.viewControllers=@[nvc1,nvc2,nvc3,nvc4,nvc5];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
