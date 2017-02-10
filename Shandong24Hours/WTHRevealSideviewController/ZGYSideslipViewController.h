//
//  ZGYSideslipViewController.h
//  ShanDong24HoursDemo
//
//  Created by zgy on 15/1/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZGYSideslipViewController : UIViewController


//是否允许主视图有滑动手势效果。默认为yes(_sideslipTapGes.enabled = YES;)
@property (strong) UIPanGestureRecognizer *slideslipPanGes;

//构造初始化方法
//传入参数：左视图控制器，主视图控制器，右视图控制器，背景图片
//instancetype类似ID  但是不同在于返回的是当前类的类型
-(instancetype)initWithLeftView:(UIViewController *)leftView andMainView:(UIViewController *)mainView andRightView:(UIViewController *)rightView andBackGroundImgView:(NSString *)bgImg;

//展示左视图
-(void)showLeftView;

//展示主视图
-(void)showMianView;

//展示右视图
-(void)showRightView;


@end
