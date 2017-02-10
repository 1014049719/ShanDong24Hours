//
//  PromotionViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "PromotionViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "PromotionTableViewCell.h"
#import "PromotionModel.h"
#import "StarView.h"

#define Promotion_URL @"http://api.sjb.dzwww.com/sale.php?m=shopping_list&buy_type=1"
@interface PromotionViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    UIImageView *_imageview;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    //滚动图片数据源
    NSMutableArray *imageDataArray;
    //cell内容数据源
    NSMutableArray *cellDataArray;
   
    BOOL _isOpen;
    
    UIView *_view;
    UITableView *_UpdownTableview;
}
@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据源
    imageDataArray=[[NSMutableArray alloc] init];
    cellDataArray=[[NSMutableArray alloc] init];
    
    //创建头部三个按钮
    [self creatBtnView];
    
    _isOpen = NO;
   
    //创建解析数据
    [self upDataFromUrl:Promotion_URL];
   
    //创建上下滑动视图
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 - 300, 320, 300)];
    _view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_view];
    //添加上下滑动tableview
    _UpdownTableview=[[UITableView alloc] initWithFrame:_view.bounds style:UITableViewStylePlain];
    [_view addSubview:_UpdownTableview];
    

}

-(void)creatBtnView{
    
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0,64, 320, 35)];
    _imageview.backgroundColor=[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    _imageview.image=[UIImage imageNamed:@"头部白底@2x"];
    _imageview.userInteractionEnabled=YES;
    [self.view addSubview:_imageview];
    
    NSArray *arr=@[@"今日特惠",@"济南市",@"最新上架"];
    for (int i=0; i<3; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*320/3, 5,320/3, 25);
        btn.tag=10+i;
        btn.selected=NO;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"灰箭头"] forState:UIControlStateNormal];
        [btn.imageView setTransform:CGAffineTransformMakeRotation(M_PI/180*90)];
        btn.titleEdgeInsets=UIEdgeInsetsMake(0, -35, 0, 0);
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitleColor:[UIColor colorWithRed:16/255.0 green:171/255.0 blue:234/255.0 alpha:1] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_imageview addSubview:btn];
    }
    
    for (int i=0; i<2; i++) {
        UIImageView *lineImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底部分隔线@2x"]];
        lineImage.frame=CGRectMake(320/3*i+320/3, 0, 5, 35);
        [_imageview addSubview:lineImage];
    }
    
}

//点击上面三个按钮事件
-(void)btnclick:(UIButton *)btn{

    NSLog(@"%ld",(long)btn.tag);

    for (int i=0; i<3; i++) {
        UIButton *button=(UIButton *)[_imageview viewWithTag:10+i];
        button.selected=NO;
    }
    btn.selected=YES;
    
    if (!_isOpen) {
        [UIView animateWithDuration:0.3 animations:^{
            _view.frame = CGRectMake(0, 94, 320, 300);
            
            [self.view bringSubviewToFront:_view];
        }];
        [btn.imageView setTransform:CGAffineTransformMakeRotation(M_PI/180*270)];
        _isOpen = YES;
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _view.frame = CGRectMake(0, 64-300, 320, 300);
        }];
        [btn.imageView setTransform:CGAffineTransformMakeRotation(M_PI/180*90)];
        _isOpen = NO;

    }
}


-(void)upDataFromUrl:(NSString *)urlStr{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //添加支持类型
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manager POST:urlStr parameters:@{@"time":@"20150129175843",@"area":@"%E9%9D%92%E5%B2%9B",@"token":@"a4b53563de7907de869dfb00abe68149",@"sale_type":@"all",@"page":@"1",@"key":@"",@"v":@"5",@"city":@"532",@"sign":@"1%7C863155020856579%7CCoolpad+7298A%7C17%7C24%7Cqq%7C19542514&session=ffd46c495276876f454ac0e8262d8528"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"variable"][@"focus"]) {
            NSString *str=dic[@"thumb"];
            [imageDataArray addObject:str];
        }
        
        for (NSDictionary *dictionary in responseObject[@"variable"][@"list"]) {
            PromotionModel *model=[[PromotionModel alloc] init];
            model.thumb=dictionary[@"thumb"];
            model.title=dictionary[@"title"];
            model.oprice=[NSString stringWithFormat:@"￥%@",dictionary[@"oprice"]];
            model.price=[NSString stringWithFormat:@"￥%@",dictionary[@"price"]];
            model.success_nums=dictionary[@"success_nums"];
            model.total_score=dictionary[@"score"][@"total_score"];
            [cellDataArray addObject:model];

        }
        NSLog(@"%@",cellDataArray);

        //刷新数据
        [tableview reloadData];
        
        //创建滚动视图
        [self creatScrollView];
        //创建tableview
        [self creatTableview];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败%@",error);
    }];
}

-(void)creatScrollView{

    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageview.frame), 320, 150)];
    _scrollView.contentSize=CGSizeMake(320*3, 150);
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    UIViewController *popin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlayNDropViewController"];
    //定时器滚动视图
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    
    if (imageDataArray.count>0) {
        
        for (int i=0; i<3; i++) {
            UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0+320*i, 0, 320,_scrollView.bounds.size.height)];
            [imageview setImageWithURL:[NSURL URLWithString:imageDataArray[i]]];
            [_scrollView addSubview:imageview];
        }

    }
    
    //滚动下方的小点
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(110, 130, 100, 20)];
    _pageControl.numberOfPages=3;
    _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor greenColor];
    _pageControl.currentPage=0;
    
}

//滚动时小圆点改变(scrollview滚动减速时)
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _pageControl.currentPage = index;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _pageControl.currentPage = index;
}

//定时器滚动视图
-(void)animation{

    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+320, 0)];
    if (_scrollView.contentOffset.x/320==3) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
}
-(void)creatTableview{
    
    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageview.frame), 320, self.view.bounds.size.height-140) style:UITableViewStylePlain];
    //将头部设置为scrollview
    tableview.tableHeaderView = _scrollView;
    [tableview addSubview:_pageControl];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];

    //注册xib
    [tableview registerNib:[UINib nibWithNibName:@"PromotionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 12;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell1";
    PromotionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[PromotionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    PromotionModel *model=[cellDataArray objectAtIndex:indexPath.row];
    [cell.thumbView setImageWithURL:[NSURL URLWithString:model.thumb]];
    cell.titleLabel.text=model.title;
    cell.priceLabel.text=model.price;
    cell.opriceLabel.text=model.oprice;
    [cell.total_scoreView setStar:model.total_score.doubleValue];
    
    cell.success_numsLabel.text=[NSString stringWithFormat:@"%d",model.success_nums.intValue];
    
    return cell;
    
   

    

    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
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
