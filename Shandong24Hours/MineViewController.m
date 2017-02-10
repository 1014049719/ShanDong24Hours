//
//  MineViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
    UITableView *tableview;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray=[[NSMutableArray alloc] init];
    
    NSDictionary *dic1=@{@"Iconimage": @"头像@2x",@"TitleLabel":@"请登录"};
    NSArray *arr1=@[dic1];
    [dataArray addObject:arr1];
    
    NSDictionary *dic2=@{@"Iconimage": @"消息2@2x",@"TitleLabel":@"消息"};
    NSDictionary *dic3=@{@"Iconimage": @"收藏2@2x",@"TitleLabel":@"收藏"};
    NSArray *arr2=@[dic2,dic3];
    [dataArray addObject:arr2];
    
    NSDictionary *dic4=@{@"Iconimage": @"积分",@"TitleLabel":@"积分"};
    NSDictionary *dic5=@{@"Iconimage": @"订单@2x",@"TitleLabel":@"订单"};
    NSDictionary *dic6=@{@"Iconimage": @"扫一扫",@"TitleLabel":@"扫一扫"};
    NSArray *arr3=@[dic4,dic5,dic6];
    [dataArray addObject:arr3];
    
    NSDictionary *dic7=@{@"Iconimage": @"手机报",@"TitleLabel":@"手机报"};
    NSArray *arr4=@[dic7];
    [dataArray addObject:arr4];
    
    NSDictionary *dic8=@{@"Iconimage": @"好友",@"TitleLabel":@"好友"};
    NSDictionary *dic9=@{@"Iconimage": @"对话@2x",@"TitleLabel":@"对话"};
    NSArray *arr5=@[dic8,dic9];
    [dataArray addObject:arr5];
    
    NSDictionary *dic10=@{@"Iconimage": @"邀请码@2x",@"TitleLabel":@"邀请码"};
    NSArray *arr6=@[dic10];
    [dataArray addObject:arr6];

    
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-49) style:UITableViewStylePlain];
    tableview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    tableview.delegate=self;
    tableview.dataSource=self;
//    tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:tableview];
    
    //注册Xib
    [tableview registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return dataArray.count;
//    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[dataArray objectAtIndex:section] count];

//    if( section==1 || section==4){
//        return 2;
//    }
//    if (section==2){
//        return 3;
//    }
//    else {
//        return 1;
//    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell";
    MineTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section==0 && indexPath.row==0) {
    
        cell.IconImage.frame=CGRectMake(18, 11, 52, 53);
        cell.TitleLabel.frame=CGRectMake(18+51+15, 13, 51, 51);
        cell.ArrowImage.frame=CGRectMake(276, 28, 22, 22);
    }
    else{
        cell.IconImage.frame=CGRectMake(23, 13, 23, 23);
        cell.TitleLabel.frame=CGRectMake(65, 15, 160, 21);
        cell.ArrowImage.frame=CGRectMake(276, 15, 22, 22);

    }
    
    NSDictionary *dic=[dataArray objectAtIndex:indexPath.section][indexPath.row];
    cell.IconImage.image=[UIImage imageNamed:dic[@"Iconimage"]];
    cell.TitleLabel.text=dic[@"TitleLabel"];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0 && indexPath.row==0) {
        return 80;
    }
    else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
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
