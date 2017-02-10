//
//  PromotionTableViewCell.m
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-29.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import "PromotionTableViewCell.h"

@implementation PromotionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

//xib走此方法
- (void)awakeFromNib {
    // Initialization code
    [self creatCell];

}
-(void)creatCell{
    
    _total_scoreView=[[StarView alloc] initWithFrame:CGRectMake(136, 37, 100, 26)];
    [self.contentView addSubview:_total_scoreView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
