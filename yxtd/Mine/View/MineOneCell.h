//
//  MineOneCell.h
//  yxtd
//
//  Created by qin on 2017/10/12.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineUserMessageModel.h"

@interface MineOneCell : UITableViewCell

@property (nonatomic,strong) void(^codeBtBlock)(void);

@property (nonatomic,strong) void(^tapBlock)(NSInteger tapTag);


@property (nonatomic,strong) MineUserMessageModel*model;


@end
