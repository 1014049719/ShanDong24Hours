//
//  LeftTableViewCell.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-22.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creatCell];
    }
    return self;
}

-(void)creatCell{
    
    //背景
    _bgimageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    _bgimageview.image=[UIImage imageNamed:@"黑玻璃中"];
    _bgimageview.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_bgimageview];
    //图标
    _iconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(39, 10, 20, 23)];
    [self.contentView addSubview:_iconimageview];
    //文字
    _titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 5,120, 35)];
    [_titlelabel setTextColor:[UIColor whiteColor]];
    _titlelabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_titlelabel];
    
    _arrowimageview=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_bgimageview.frame)-50, 12, 20, 20)];
    _arrowimageview.image=[UIImage imageNamed:@"灰箭头@2x"];
    _arrowimageview.backgroundColor=[UIColor clearColor];
    _arrowimageview.hidden=YES;
    [self.contentView addSubview:_arrowimageview];
    
    self.backgroundColor=[UIColor clearColor];
    //设置无选取样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

@end
