//
//  MytabviewMain.m
//  test
//
//  Created by 天宏 on 15-2-5.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "MytabviewMain.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "TableViewCellOnly.h"
#import "TableViewCellMore.h"
#import "navsCell.h"
#import "newsModel.h"
#import "MJRefresh.h"

#define News_URL @"http://124.133.228.226/news.php?m=list&cid=11&city=531&page=%d"

@implementation MytabviewMain
{
    UITableView *_tableview;
    NSMutableArray *_dataArray;
    
    UIScrollView *_headScrollview;
    
    NSMutableArray *_imageDataArray;
    NSMutableArray *_imageTitleArray;
    //广告图片网址
    NSMutableArray *_navsArray;

    //滚动时的数字
    UILabel *_numLabel;
    UILabel *_label;
    
    int page;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self creatTableview];
    }
    return self;
}
-(void)creatTableview{
    
    //初始化数据源
    _dataArray=[[NSMutableArray alloc] init];
    _imageDataArray=[[NSMutableArray alloc] init];
    _imageTitleArray=[[NSMutableArray alloc] init];
    _navsArray=[[NSMutableArray alloc] init];
    
    page=1;
    
    _tableview=[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self addSubview:_tableview];
    
    //添加头部滚动视图(先加一层view，再将headScrollview加到view上，然后将label加到view)
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];

    _headScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    _headScrollview.contentSize=CGSizeMake(320*4, 80);
    _headScrollview.pagingEnabled=YES;
    _headScrollview.bounces=NO;
    _headScrollview.delegate = self;
    [headview addSubview:_headScrollview];
    //滚动图片标题
    _label=[[UILabel alloc] initWithFrame:CGRectMake(38, CGRectGetMaxY(_headScrollview.bounds)-25, 250, 20)];
    _label.textColor=[UIColor whiteColor];
    [_label setFont:[UIFont systemFontOfSize:14]];
    [headview addSubview:_label];
    
    UIView *numView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headScrollview.bounds)-25, 30, 20)];
    numView.backgroundColor=[UIColor colorWithRed:255/255.0 green:61/255.0 blue:0 alpha:1];
    [headview addSubview:numView];
    //滚动图片数字
    _numLabel=[[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(_headScrollview.bounds)-25,30, 20)];
    _numLabel.text=@"1/4";
    _numLabel.textColor=[UIColor whiteColor];
    [_numLabel setFont:[UIFont systemFontOfSize:14]];
    [headview addSubview:_numLabel];
    
    //将_tableview的头部视图设置为headview
    _tableview.tableHeaderView=headview;
    
    //注册xib
    [_tableview registerNib:[UINib nibWithNibName:@"TableViewCellOnly" bundle:nil] forCellReuseIdentifier:@"cellOnly"];
    [_tableview registerNib:[UINib nibWithNibName:@"TableViewCellMore" bundle:nil] forCellReuseIdentifier:@"cellMore"];
    [_tableview registerNib:[UINib nibWithNibName:@"navsCell" bundle:nil] forCellReuseIdentifier:@"navsCell"];
    
    //请求数据
    [self upDataFromURL:[NSString stringWithFormat:News_URL,page]];
    
    //添加刷新数据视图
    [_tableview addHeaderWithTarget:self action:@selector(dealHead)];
    [_tableview addFooterWithTarget:self action:@selector(dealFoot)];
}
//处理刷新
-(void)dealHead{

    page=1;
    [_dataArray removeAllObjects];
    [self upDataFromURL:[NSString stringWithFormat:News_URL,page]];
}
-(void)dealFoot{

    page++;
    [self upDataFromURL:[NSString stringWithFormat:News_URL,page]];
}

-(void)upDataFromURL:(NSString *)urlStr{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //添加支持类型
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //滚动热点
        for (NSDictionary *imageDic in responseObject[@"variable"][@"focus"]) {
            NSString *imagaUrlStr=imageDic[@"thumb"];
            NSString *imageTitle=imageDic[@"title"];
            
            [_imageDataArray addObject:imagaUrlStr];
            [_imageTitleArray addObject:imageTitle];

            //先设置第一张图片的标题
            _label.text=_imageTitleArray[0];
        }
        
        //第一栏广告
        for (NSDictionary *navsDic in responseObject[@"variable"][@"navs"]) {
            NSString *navsString=navsDic[@"img"];
            [_navsArray addObject:navsString];
        }
        NSLog(@"%@",_navsArray);
        
        for (NSDictionary *dataDic in responseObject[@"variable"][@"list"]) {
            newsModel *model=[[newsModel alloc] init];
            model.title=dataDic[@"title"];
            model.thumb=dataDic[@"thumb"];
            model.ntime=dataDic[@"ntime"];
            model.pics=dataDic[@"pics"];
            
            [_dataArray addObject:model];
        }
        
        //刷新数据
        [_tableview reloadData];
        
        //获取到数据后，停止刷新
        [_tableview headerEndRefreshing];
        [_tableview footerEndRefreshing];
        
        //添加headScrollview上的图片
        [self addPicture];
        
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败：%@",error);
    }];
}

-(void)addPicture{
    
    for (int i=0; i<4; i++) {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 140)];
        [imageview setImageWithURL:[NSURL URLWithString:_imageDataArray[i]]];
        [_headScrollview addSubview:imageview];
    }
    
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
}
//计时器滚动图片
-(void)scroll{

    [_headScrollview setContentOffset:CGPointMake(_headScrollview.contentOffset.x+320, 0)];
    if (_headScrollview.contentOffset.x>320*3) {
        [_headScrollview setContentOffset:CGPointMake(0, 0)];
    }
}
//滚动时更改数字和文字
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int index=fabs(_headScrollview.contentOffset.x)/_headScrollview.frame.size.width;
    NSLog(@"滚动%d",index);
    if (index>= 4) {
        index = 0;
    }
    _numLabel.text=[NSString stringWithFormat:@"%d/4",index+1];
    _label.text=_imageTitleArray[index];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier1=@"cellOnly";
    TableViewCellOnly *cellOnly=[tableView dequeueReusableCellWithIdentifier:identifier1];
    if (cellOnly==nil) {
        cellOnly=[[TableViewCellOnly alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    
    static NSString *identifier2=@"cellMore";
    TableViewCellMore *cellMore=[tableView dequeueReusableCellWithIdentifier:identifier2];
    if (cellMore==nil) {
        cellMore=[[TableViewCellMore alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    }
    
    static NSString *identifier3=@"navsCell";
    navsCell *navscell=[tableView dequeueReusableCellWithIdentifier:identifier3];
    if (navscell==nil) {
        navscell=[[navsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
    }
    
    if (_dataArray.count>0) {
        newsModel *model=[_dataArray objectAtIndex:indexPath.row];
        cellOnly.titleLabel.text=model.title;
        [cellOnly.thumbImage setImageWithURL:[NSURL URLWithString:model.thumb]];
        cellOnly.ntimeLabel.text=[model.ntime substringWithRange:NSMakeRange(5, 5)];
        NSLog(@"%@",model.pics);
        
        if (model.pics.count>0) {
            cellMore.titleLabel.text=model.title;
            cellMore.ntimeLabel.text=[model.ntime substringWithRange:NSMakeRange(5, 5)];
            [cellMore.picsImageView0 setImageWithURL:[NSURL URLWithString:model.pics[0]]];
            [cellMore.picsImageView1 setImageWithURL:[NSURL URLWithString:model.pics[1]]];
            [cellMore.picsImageView2 setImageWithURL:[NSURL URLWithString:model.pics[2]]];
            return cellMore;
        }
    }
    
    if (indexPath.row==0) {
        if (_navsArray.count>0) {
            [navscell.navsImageview setImageWithURL:[NSURL URLWithString:_navsArray[0]]];
        }
        return navscell;
    }
    else{
    return cellOnly;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_dataArray.count>0) {
        newsModel *model=[_dataArray objectAtIndex:indexPath.row];
        if (model.pics.count>0) {
            return 98;
        }
    }
    return 70;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
