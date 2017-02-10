//
//  ZGYSideslipViewController.m
//  ShanDong24HoursDemo
//
//  Created by zgy on 15/1/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZGYSideslipViewController.h"
#import <QuartzCore/QuartzCore.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ZGYSideslipViewController ()
{
    UIViewController *_leftVC;
    UIViewController *_mainVC;
    UIViewController *_rightVC;
    //    背景View
    UIImageView *_backGroudImgView;
    
}
@end

@implementation ZGYSideslipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//构造初始化方法
//传入参数：左视图控制器，主视图控制器，右视图控制器，背景图片
//instancetype类似ID  但是不同在于 返回的是当前类的类型
- (instancetype)initWithLeftView:(UIViewController *)leftView andMainView:(UITabBarController *)mainView andRightView:(UIViewController *)rightView andBackGroundImgView:(NSString *)bgImg
{
    self = [super init];
    if (self) {
        //        分别把传入的控制器赋给相应的控制器
        _leftVC = leftView;
        _mainVC = mainView;
        _rightVC = rightView;
        
        //        为了实现自定义视图的阴影，添加需要使用QuartzCore框架。在项目里添加QuartzCore框架后引入头文件。
        //        设置阴影颜色
        _mainVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
        //        设置阴影圆润度半径
        _mainVC.view.layer.shadowRadius = 3;
        //      设置阴影透明度
        _mainVC.view.layer.shadowOpacity = 0.7;
        //        设置阴影偏移量
        _mainVC.view.layer.shadowOffset = CGSizeMake(0, 10);
        
        //        设置当前的背景
        _backGroudImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backGroudImgView.image = [UIImage imageNamed:bgImg];
        [self.view addSubview:_backGroudImgView];
        
        //        创建左边视图与中间视图重叠区域大小的view，用来添加点击手势
        UIView *leftTapView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH-100, 0, 100, HEIGHT)];
        leftTapView.backgroundColor = [UIColor clearColor];
        [_leftVC.view addSubview:leftTapView];
        
        //        添加左边视图的点击手势
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapClicked:)];
        [leftTapView addGestureRecognizer:leftTap];
        leftTapView.userInteractionEnabled = YES;
        
        //        创建左边视图与中间视图重叠区域大小的view，用来添加点击手势
        UIView *rightTapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, HEIGHT)];
        rightTapView.backgroundColor = [UIColor clearColor];
        [_rightVC.view addSubview:rightTapView];
        //        添加右边视图的点击手势
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapCliked:)];
        [rightTapView addGestureRecognizer:rightTap];
        rightTapView.userInteractionEnabled = YES;
        
        
        //添加滑动手势
        _slideslipPanGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.view addGestureRecognizer:_slideslipPanGes];
        self.view.userInteractionEnabled = YES;
        
        
        [self addChildViewController:_leftVC];
        [self.view addSubview:_leftVC.view];
        
        [self addChildViewController:_rightVC];
        [self.view addSubview:_rightVC.view];
        
        [self addChildViewController:_mainVC];
        [self.view addSubview:_mainVC.view];
        
        //        添加观察者,监听是否打开左右视图
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLeftView:) name:@"OpenLeftView" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openRightView:) name:@"OpenRightView" object:nil];
        
        
        //    添加消息观察者，监听是否改变定位按钮的标题，这边要紧跟着展示主视图
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMianView) name:@"ChangeCityName" object: nil];
    }
    return self;
}
#pragma mark - 通知中心，消息监听触发事件
//监听触发方法：打开左视图
- (void)openLeftView:(NSNotification *)leftNoti
{
    _leftVC.view.hidden = NO;
    _rightVC.view.hidden = YES;
    [self showLeftView];
}
//监听触发方法：打开右视图
- (void)openRightView:(NSNotification *)rightNoti
{
    _leftVC.view.hidden = YES;
    _rightVC.view.hidden = NO;
    [self showRightView];
}
#pragma mark - 手势处理事件
//滑动手势处理事件
-(void)handlePan:(UIPanGestureRecognizer *)panGes
{
    [self.view bringSubviewToFront:_mainVC.view];
    //    获取当前偏移量
    CGPoint skewing = [panGes translationInView:panGes.view];
    NSLog(@"skewing.x = %f",skewing.x);
    NSLog(@"\npanGes.view.frame.origin.x = %f",panGes.view.frame.origin.x);
    if ((_mainVC.view.frame.origin.x >= 0) && (_mainVC.view.frame.origin.x < WIDTH-100)) {
        _mainVC.view.transform = CGAffineTransformTranslate(_mainVC.view.transform, skewing.x, 0);
        _leftVC.view.hidden = NO;
        _rightVC.view.hidden = YES;
        
    }
    else if ((_mainVC.view.frame.origin.x > (100-WIDTH))&&(_mainVC.view.frame.origin.x< 0))
    {
        _mainVC.view.transform = CGAffineTransformTranslate(_mainVC.view.transform, skewing.x, 0);
        _leftVC.view.hidden = YES;
        _rightVC.view.hidden = NO;
        
    }
    else if(_mainVC.view.frame.origin.x >= 220 )
    {
        if (skewing.x<0) {
            _mainVC.view.transform = CGAffineTransformTranslate(_mainVC.view.transform, skewing.x, 0);
        }
    }
    else if(_mainVC.view.frame.origin.x <= -220)
    {
        if (skewing.x > 0) {
            _mainVC.view.transform = CGAffineTransformTranslate(_mainVC.view.transform, skewing.x, 0);
        }
    }
    [panGes setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if (_mainVC.view.frame.origin.x >= 100) {
            [self showLeftView];
        }
        else if(_mainVC.view.frame.origin.x <= -100)
        {
            [self showRightView];
        }
        else
        {
            [self showMianView];
        }
        
    }
    
}
//右边视图手势事件：先把主视图bring到最上层，然后改变坐标，展示主视图
- (void)rightTapCliked:(UITapGestureRecognizer *)rightTapGes
{
    if (rightTapGes.state == UIGestureRecognizerStateEnded) {
        [self.view bringSubviewToFront:_mainVC.view];
        [UIView animateWithDuration:0.35 animations:^{
            _mainVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        } completion:^(BOOL finished) {
            
        }];
    }
}
//左边视图手势事件：先把主视图bring到最上层，然后改变坐标，展示主视图，
- (void)leftTapClicked:(UITapGestureRecognizer *)leftTapGes
{
    if (leftTapGes.state == UIGestureRecognizerStateEnded) {
        [self.view bringSubviewToFront:_mainVC.view];
        [UIView animateWithDuration:0.35 animations:^{
            _mainVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//点击事件：主要使得偏移时候点一下使得主界面返回原来中心位置
- (void)tapClick:(UITapGestureRecognizer *)tapGes
{
    if (tapGes.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        _mainVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        [UIView commitAnimations];
    }
    
}

#pragma mark - 各种使得视图展示的构造方法
//展示左视图
- (void)showLeftView
{
    [UIView animateWithDuration:0.35 animations:^{
        //    需要缩放的时候可以添加下面的语句，意思是：把当前的缩放比例设置为基于前面的缩放基础上
        //    _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        _mainVC.view.frame = CGRectMake(WIDTH-100, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:_leftVC.view];
    }];
}
//展示中间视图
- (void)showMianView
{
    //    把主视图放到最上层
    [self.view bringSubviewToFront:_mainVC.view];
    [UIView animateWithDuration:0.35 animations:^{
        //    需要缩放的时候可以添加下面的语句，意思是：把当前的缩放比例设置为基于前面的缩放基础上
        //    _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        _mainVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
    
}
//展示右边视图
- (void)showRightView
{
    [UIView animateWithDuration:0.35 animations:^{
        _mainVC.view.frame = CGRectMake(100-WIDTH, 0, WIDTH, HEIGHT);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:_rightVC.view];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
