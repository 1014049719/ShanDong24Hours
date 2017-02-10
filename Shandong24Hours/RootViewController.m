//
//  RootViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "RootViewController.h"
#import "PPRevealSideViewController.h"
#import "SearchViewController.h"

@interface RootViewController ()
{
    UIButton *_locationBtn;
    UIButton *_rightbtn;
    UIButton *_searchbtn;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置导航栏背景
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:16/255.0 green:171/255.0 blue:234/255.0 alpha:1];
    
    //导航栏标题图片
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    logoView.image = [UIImage imageNamed:@"顶部Logo"];
    self.navigationItem.titleView = logoView;
    
    //导航左边按钮：定位按钮
    _locationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_locationBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [_locationBtn setTitle:@"青岛" forState:UIControlStateNormal];
    _locationBtn.frame = CGRectMake(8, 29, 55, 26);
    _locationBtn.tintColor = [UIColor whiteColor];
    _locationBtn.tag = 100;
    [_locationBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_locationBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边按钮 设置
    _rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightbtn.frame=CGRectMake(288, 31, 22, 22);
    _rightbtn.tag=101;
    [_rightbtn setImage:[UIImage imageNamed:@"右抽屉开关"] forState:UIControlStateNormal];
    [_rightbtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:_rightbtn];
    
    //添加右边搜索按钮
    _searchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _searchbtn.frame=CGRectMake(245, 13, 22, 22);
    _searchbtn.tag=102;
    [_searchbtn setImage:[UIImage imageNamed:@"right_0@2x"] forState:UIControlStateNormal];
    [_searchbtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_searchbtn];
    
    //隐藏“我的”界面中的搜索按钮
    if (self.tabBarController.selectedIndex==4) {
        _searchbtn.hidden=YES;
    }
    
    //添加监听者，改变地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:@"ChangeCityName" object:nil];
}
//监听者改变城市地址
-(void)changeCity:(NSNotification *)noti{
    
    [_locationBtn setTitle:noti.object forState:UIControlStateNormal];
}

-(void)clickBtn:(UIButton *)button{

    if (button.tag == 100) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OpenLeftView" object:nil];
    }
    if(button.tag==101)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OpenRightView" object:nil];
    }
    else if (button.tag==102){
    
        SearchViewController *searchVCL=[[SearchViewController alloc] init];
        [self presentViewController:searchVCL animated:YES completion:nil];
    }
    

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
