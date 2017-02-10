//
//  ActivityViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ActivityModel.h"
#import "MJRefresh.h"


#define Activity_URL @ "http://124.133.228.226/active.php?m=list&cid=48&city=531&page=%d"

@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataMutableArr;
    UITableView *tableview;
    int page;
}
@end

@implementation ActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataMutableArr=[[NSMutableArray alloc] init];
    page=1;

    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-49)];
    tableview.dataSource=self;
    tableview.delegate=self;
    [self.view addSubview:tableview];
    
    //注册Xib  (一定要加上)
    [tableview registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //请求数据
    [self requestDatafromURLstr:[NSString stringWithFormat:Activity_URL,page]];
    
    //添加刷新头部、尾部视图
    [tableview addHeaderWithTarget:self action:@selector(dealHead)];
    [tableview addFooterWithTarget:self action:@selector(dealFoot)];
}
//刷新操作
-(void)dealHead{

    page=1;
    [dataMutableArr removeAllObjects];
    [self requestDatafromURLstr:[NSString stringWithFormat:Activity_URL,page]];
}
-(void)dealFoot{
    
    page++;
    [self requestDatafromURLstr:[NSString stringWithFormat:Activity_URL,page]];
}

-(void)requestDatafromURLstr:(NSString *)urlString{

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //加支持类型
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *jsonArr=responseObject[@"variable"][@"list"];
        for (NSDictionary *dic in jsonArr) {
            ActivityModel *model=[[ActivityModel alloc] init];
            model.location=dic[@"location"];
            model.ntime=dic[@"ntime"];
            model.price=dic[@"price"];
            model.thumb=dic[@"thumb"];
            model.title=dic[@"title"];

            [dataMutableArr addObject:model];
        }
        NSLog(@"%lu",(unsigned long)dataMutableArr.count);
        [tableview reloadData];
        //获取到数据后，停止刷新
        [tableview headerEndRefreshing];
        [tableview footerEndRefreshing];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataMutableArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell";
    ActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ActivityModel *model=[dataMutableArr objectAtIndex:indexPath.row];
    cell.titleLabel.text=model.title;
    cell.ntimeLabel.text=model.ntime;
    cell.locationLabel.text=model.location;
    [cell.thumbImageview setImageWithURL:[NSURL URLWithString:model.thumb]];
    if ([model.price isEqualToString:@""]) {
         cell.priceLabel.text=@"免费";
    }
    else{
        cell.priceLabel.text=model.price;
    }
    if ([model.location isEqualToString:@""]) {
        cell.LocationImage.hidden=YES;
    }
    else{
        cell.LocationImage.hidden=NO;
    }
    if ([model.ntime isEqualToString:@""]) {
        cell.TimeImage.hidden=YES;
    }
    else{
        cell.TimeImage.hidden=NO;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
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
