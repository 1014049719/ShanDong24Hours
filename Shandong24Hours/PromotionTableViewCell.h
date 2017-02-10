//
//  PromotionTableViewCell.h
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-29.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface PromotionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *opriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *success_numsLabel;
@property (strong, nonatomic) StarView *total_scoreView;

@end
