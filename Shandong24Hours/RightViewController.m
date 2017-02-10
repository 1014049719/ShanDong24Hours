//
//  RightViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "RightViewController.h"
#import "RightTableViewCell.h"

@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_titlearray;
    NSArray *_imagearrar;
    UITableView *_tabview;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    [self creatBanbenlabel];
}

-(void)creatUI{

    _titlearray=@[@"清除缓存",@"检查更新",@"推送消息",@"夜间模式",@"给个好评",@"大众广场",@"推荐好友",@"关于产品"];
    
    //添加cell
    _tabview =[[UITableView alloc] initWithFrame:CGRectMake(125, 75, 179, 360) style:UITableViewStylePlain];
    _tabview.delegate=self;
    _tabview.dataSource=self;
    //把分割线颜色去掉
    _tabview.separatorColor = [UIColor clearColor];
    //tableview背景设为无色
    _tabview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tabview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _titlearray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell";
    RightTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[RightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row==0) {
        cell.bgimageview.image=[UIImage imageNamed:@"黑玻璃上"];
    }
    else if(indexPath.row == (_titlearray.count - 1))
    {
        cell.bgimageview.image = [UIImage imageNamed:@"黑玻璃下"];
    }
    cell.iconimageview.image=[UIImage imageNamed:[_titlearray objectAtIndex:indexPath.row]];
    cell.titlelabel.text=[_titlearray objectAtIndex:indexPath.row];
    return cell;
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}

//版本label
-(void)creatBanbenlabel{

    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(100, self.view.bounds.size.height-40, 320, 45)];
    imageview.image=[UIImage imageNamed:@"黑玻璃下"];
    [self.view addSubview:imageview];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(17, 3,180, 40)];
    label.text=@"山东24小时新闻客户端";
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [imageview addSubview:label];
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
