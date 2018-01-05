//
//  ShangJiaTableViewCell.h
//  yxtd
//
//  Created by qin on 2018/1/5.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodStarView.h"

@interface ShangJiaTableViewCell : UITableViewCell

@property (nonatomic,strong) void(^starButtonBlock)(void);

@property (nonatomic,strong) UIButton*starButton;

@property (nonatomic,strong) FoodStarView*starVC;

@end
