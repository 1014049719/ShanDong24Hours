//
//  ActivityTableViewCell.h
//  Shandong24Hours
//
//  Created by 天宏 on 15-1-27.
//  Copyright (c) 2015年 天宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageview;
@property (weak, nonatomic) IBOutlet UIImageView *PricebgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ntimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *TimeImage;
@property (weak, nonatomic) IBOutlet UIImageView *LocationImage;

@end
