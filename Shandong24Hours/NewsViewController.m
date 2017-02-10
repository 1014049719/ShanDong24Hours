//
//  NewsViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "NewsViewController.h"
#import "MytabviewMain.h"
//#import "MyTableviewOthers.h"

#define Others_URL @"http://124.133.228.226/news.php?m=list&cid=%d&city=531&page=%d"

@interface NewsViewController ()<UIScrollViewDelegate>
{
    UIImageView *_imageview;
    //头部滚动栏目
    UIScrollView *_headScrollview;
    //下方滚动视图
    UIScrollView *_tableScrollview;
    
    //滚动页面标记
    int _index;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建栏目滚动视图
    [self creatView];
    //创建下方滚动视图
    [self creattableScrollview];
}

-(void)creatView{
    
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0,64, 320, 30)];
    _imageview.backgroundColor=[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    _imageview.image=[UIImage imageNamed:@"头部白底@2x"];
    _imageview.userInteractionEnabled=YES;
    [self.view addSubview:_imageview];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(CGRectGetMaxX(_imageview.frame)-38, 0, 40, 30);
    [btn setImage:[UIImage imageNamed:@"导航加号@2x"] forState:UIControlStateNormal];
    [_imageview addSubview:btn];
   
    UIImageView *lineImageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"导航栏阴影@2x"]];
    lineImageview.frame=CGRectMake(btn.frame.origin.x-18, 0, 20, 30);
    [_imageview addSubview:lineImageview];
    
    _headScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    _headScrollview.userInteractionEnabled=YES;
    _headScrollview.bounces=NO;
    _headScrollview.contentSize=CGSizeMake(270+280/7*3, 30);
    [_imageview addSubview:_headScrollview];
    
    NSArray *array=@[@"头条",@"体育",@"趣谈",@"娱乐",@"山东",@"财经",@"青岛"];
    for (int i=0; i<7; i++) {
        UIButton *headButton =[UIButton buttonWithType:UIButtonTypeCustom];
        headButton.tag= 10 + i;
        headButton.selected=NO;
        headButton.frame=CGRectMake((280/7+15)*i+10, 0, 280/7, 30);
        [headButton setTitle:array[i] forState:UIControlStateNormal];
        [headButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [headButton setTitleColor:[UIColor colorWithRed:16/255.0 green:171/255.0 blue:234/255.0 alpha:1] forState:UIControlStateSelected];
        headButton.imageEdgeInsets=UIEdgeInsetsMake(22, 10, 0, 0);
        [headButton addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_headScrollview addSubview:headButton];
    }
    
    //刚进入界面时，把第一个按钮设为选中状态
   UIButton *btn1=(UIButton *)[self.view viewWithTag:10];
    btn1.selected=YES;
}


-(void)creattableScrollview{

    _tableScrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageview.frame), 320, 428)];
    _tableScrollview.pagingEnabled=YES;
    _tableScrollview.bounces=NO;
    _tableScrollview.contentSize=CGSizeMake(320*7, 428);
    _tableScrollview.delegate=self;
    [self.view addSubview:_tableScrollview];
    
    [self creattableview];
}

//滚动视图上面添加tableview
-(void)creattableview{

    for (int i=0; i<7; i++) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 428)];
        [_tableScrollview addSubview:view];
    }
    
    //先把第一界面设定
    switch (_index) {
        case 0:
        {
            NSLog(@"0 界面");
            MytabviewMain *tableviewMain=[[MytabviewMain alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            [_tableScrollview addSubview:tableviewMain];
        }
        default:
            break;
    }
    
}

-(void)btnclick:(UIButton *)btn{

    NSLog(@"%ld",(long)btn.tag);
    for (int i = 0; i < 7; i ++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:10+i];
        button.selected = NO;
    }
    btn.selected = YES;
    [_tableScrollview setContentOffset:CGPointMake(320*(btn.tag-10), 0)];
    
    //滚动时显示相应的界面
    switch (btn.tag-10) {
        case 0:
        {
            NSLog(@"0 界面");
            MytabviewMain *tableviewMain=[[MytabviewMain alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            [_tableScrollview addSubview:tableviewMain];
        }
            break;
//        case 1:
//        {
//            NSLog(@"1 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320, 0, 320, 480)];
//            tableviewOthers.cid = 17;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 2:
//        {
//            NSLog(@"2 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*2, 0, 320, 480)];
//            tableviewOthers.cid = 84;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 3:
//        {
//            NSLog(@"3 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*3, 0, 320, 480)];
//            tableviewOthers.cid = 16;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 4:
//        {
//            NSLog(@"4 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*4, 0, 320, 480)];
//            tableviewOthers.cid = 12;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 5:
//        {
//            NSLog(@"5 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*5, 0, 320, 480)];
//            tableviewOthers.cid = 19;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 6:
//        {
//            NSLog(@"6 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*6, 0, 320, 480)];
//            tableviewOthers.cid = 20;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//            break;
        default:
            break;
    }

}
//滑动停止减速时更改按钮的选定状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _index=abs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    NSLog(@"%d",_index);
    
    for (int i=0; i<7; i++) {
        UIButton *butt=(UIButton *)[self.view viewWithTag:i+10];
        butt.selected=NO;
    }
    UIButton *btn=(UIButton *)[self.view viewWithTag:_index+10];
    btn.selected=YES;
    
    //上面的headscrollview栏目跟着滑动
    [_headScrollview scrollRectToVisible:CGRectMake(20*(_index) , 0, 280, 30) animated:YES];
    
    //滚动时显示相应的界面
    switch (_index) {
        case 0:
        {
            NSLog(@"0 界面");
            MytabviewMain *tableviewMain=[[MytabviewMain alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
            [_tableScrollview addSubview:tableviewMain];
        }
            break;
//        case 1:
//        {
//            NSLog(@"1 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320, 0, 320, 480)];
//            tableviewOthers.cid = 17;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 2:
//        {
//            NSLog(@"2 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*2, 0, 320, 480)];
//            tableviewOthers.cid = 84;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 3:
//        {
//            NSLog(@"3 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*3, 0, 320, 480)];
//            tableviewOthers.cid = 16;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 4:
//        {
//            NSLog(@"4 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*4, 0, 320, 480)];
//            tableviewOthers.cid = 12;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 5:
//        {
//            NSLog(@"5 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*5, 0, 320, 480)];
//            tableviewOthers.cid = 19;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//        case 6:
//        {
//            NSLog(@"6 界面");
//            MyTableviewOthers *tableviewOthers=[[MyTableviewOthers alloc] initWithFrame:CGRectMake(320*6, 0, 320, 480)];
//            tableviewOthers.cid = 20;
//            [_tableScrollview addSubview:tableviewOthers];
//        }
//            break;
        default:
            break;
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
