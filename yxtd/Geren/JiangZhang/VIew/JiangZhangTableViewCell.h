//
//  JiangZhangTableViewCell.h
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiangZhangCellView.h"

@interface JiangZhangTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet JiangZhangCellView *cellView;

@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSIndexPath * indexPath;

@end
