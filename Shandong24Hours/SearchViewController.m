//
//  SearchViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-26.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "SearchViewController.h"
#import "RootViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>
{
    UIImageView *imageView;
    UIImageView *imageView1;
}
@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor=[UIColor redColor];
    
    
    //设置导航栏背景
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 45)];
    imageView.backgroundColor=[UIColor colorWithRed:16/255.0 green:171/255.0 blue:234/255.0 alpha:1];
    [self.view addSubview:imageView];
    
    //导航栏标题图片
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 110, 30)];
    logoView.image = [UIImage imageNamed:@"顶部Logo"];
    [imageView addSubview:logoView];
    //返回按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15, 10, 30, 30);
    [btn setImage:[UIImage imageNamed:@"导航前进@2x"] forState:UIControlStateNormal];
    //图片旋转角度
    btn.transform=CGAffineTransformMakeRotation(M_PI/180*180);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    imageView.userInteractionEnabled = YES;
    
    //搜索框下面白色背景
    imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame), 320, 35)];
    imageView1.image=[UIImage imageNamed:@"头部底@2x"];
    imageView1.userInteractionEnabled=YES;
    [self.view addSubview:imageView1];
    
    UITextField *textfield=[[UITextField alloc] initWithFrame:CGRectMake(10, 2.5, 300, 30)];
    textfield.borderStyle=UITextBorderStyleRoundedRect;
    UIImageView *searchImageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Contacts_AddFriends_Icon_Seach@2x"]];
    textfield.leftView=searchImageview;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    [textfield setClearButtonMode:UITextFieldViewModeAlways];
    textfield.placeholder=@"查找";
    textfield.delegate=self;
    [imageView1 addSubview:textfield];
    
   

}

//点击按钮返回
-(void)btnClick:(UIButton *)btn{

    [self dismissModalViewControllerAnimated:NO];
}

//退出键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
//上移
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    imageView.hidden=YES;
    imageView1.frame=CGRectMake(0, 20, 320, 35);
}
//界面下移
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    //下移动画效果
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.hidden=NO;
        imageView1.frame=CGRectMake(0,CGRectGetMaxY(imageView.frame), 320, 35);

    } completion:^(BOOL finished) {
        
    }];
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
