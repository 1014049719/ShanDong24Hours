//
//  LeftViewController.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-20.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

//天气
#define Weather_URL @"http://www.weather.com.cn/data/cityinfo/%@.html"
//图片
#define Image_URL @"http://m.weather.com.cn/img/b%@"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSString *_locationCiryStr;
    NSArray *_dataarray;
    NSIndexPath *_seletedIndex;
    //天气预报城市
    UILabel *_label;
    UILabel *_tempLabel;
    UIImageView *_imageview;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    [self weatherUI];
}

-(void)creatUI{
    
    _locationCiryStr = @"广州";
    NSArray *titleArr1 = @[@"当前定位城市",_locationCiryStr];
    NSArray *titleArr2  = @[@"选择城市",@"济南",@"青岛",@"淄博",@"枣庄",@"东营",@"烟台",@"潍坊",@"济宁",@"泰安",@"威海",@"日照",@"莱芜",@"临沂",@"德州",@"聊城",@"滨州",@"菏泽"];
    _dataarray=@[titleArr1,titleArr2];
    
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(18, 60, 179, self.view.bounds.size.height-110)  style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.backgroundColor=[UIColor clearColor];
    _tableview.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataarray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_dataarray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"cell";
    LeftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    
    cell.titlelabel.text=[[_dataarray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.arrowimageview.hidden = !(indexPath == _seletedIndex);

    
    if (indexPath.row==0) {
        
        cell.bgimageview.frame=CGRectMake(0,0, 180, 29);
        cell.titlelabel.frame=CGRectMake(40,0,100, 35);
        cell.titlelabel.font=[UIFont systemFontOfSize:14];
        cell.bgimageview.image=[UIImage imageNamed:@"黑玻璃上"];
    }
    else
    {
        cell.titlelabel.frame = CGRectMake(30, 5,120, 35);
        cell.bgimageview.frame=CGRectMake(0, 0, 180, 44);
        cell.titlelabel.font=[UIFont systemFontOfSize:17];
        cell.bgimageview.image=[UIImage imageNamed:@"黑玻璃中"];
    }
    
    if(indexPath.section==0 && indexPath.row==1){
        
        cell.iconimageview.image=[UIImage imageNamed:@"地址"];
    }
    else{
        cell.iconimageview.image=nil;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 30;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
//设置选中时的样式
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!(indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0))) {
        
        _seletedIndex = indexPath;
        ((LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).arrowimageview.hidden = NO;
    }
    if(indexPath.section==1 && indexPath.row!=0){
    
        NSString *str=_dataarray[indexPath.section][indexPath.row];
        NSLog(@"选中了。。%@",str);
        //发布通知（选中的城市）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeCityName" object:str];
    }

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ((LeftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).arrowimageview.hidden = YES;
}

//最下方天气预报
-(void)weatherUI{
    
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-40, 220, 45)];
    imageview.image=[UIImage imageNamed:@"黑玻璃下"];
    [self.view addSubview:imageview];
    
    _label=[[UILabel alloc] initWithFrame:CGRectMake(80, 3,60, 40)];
    _label.text=@"天气预报";
    _label.font=[UIFont systemFontOfSize:14];
    _label.textColor=[UIColor whiteColor];
    [imageview addSubview:_label];
    
    _tempLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 3, 200, 40)];
    _tempLabel.font=[UIFont systemFontOfSize:14];
    _tempLabel.textColor=[UIColor whiteColor];
    [imageview addSubview:_tempLabel];
    
    _imageview =[[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 25, 25)];
    [imageview addSubview:_imageview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:)  name:@"ChangeCityName" object:nil];
}

//改变天气预报城市
-(void)changeCity:(NSNotification *)noti{

   
    NSDictionary *cityIdDic=@{@"济南": @"101120101",@"青岛": @"101120201",@"淄博": @"101120301",@"枣庄": @"101121401",@"东营": @"101121201",@"烟台": @"101120501",@"潍坊": @"101120601",@"济宁": @"101120701",@"泰安": @"101120801",@"威海": @"101121301",@"日照": @"101121501",@"莱芜": @"101121601",@"临沂": @"101120901",@"德州": @"101120401",@"聊城": @"101121701",@"滨州": @"101121101",@"菏泽": @"101121001"};
    
    _label.text=noti.object;
    _label.frame=CGRectMake(17, 3, 60, 40);
[self requestDataFromURL:[NSString stringWithFormat:Weather_URL, cityIdDic[noti.object]]];

}

-(void)requestDataFromURL:(NSString *)urlString{
    NSLog(@"%@", urlString);//www.xxx.php?
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    //如果解析失败，就加入支持这种格式类型（重要） （类型在打印失败原因中找）
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"image/gif",nil];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *jsonDic=responseObject[@"weatherinfo"];
        _tempLabel.text=[NSString stringWithFormat:@"%@~%@  %@",jsonDic[@"temp2"],jsonDic[@"temp1"],jsonDic[@"weather"]];
        

        NSString *imageString=jsonDic[@"img1"];
        NSString *subimageStr=[imageString substringFromIndex:1];
        NSLog(@"%@",subimageStr);
        
        [_imageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:Image_URL,subimageStr]]];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
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
