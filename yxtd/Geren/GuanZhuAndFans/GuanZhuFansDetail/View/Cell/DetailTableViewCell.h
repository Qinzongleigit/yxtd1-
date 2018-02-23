//
//  DetailTableViewCell.h
//  yxtd
//
//  Created by qin on 2018/2/7.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailImageCellView.h"
#import "DetailArrayModel.h"
#import "DetailFansAndFocusModel.h"


@interface DetailTableViewCell : UITableViewCell

@property (nonatomic,strong) DetailImageCellView*cellView;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) NSIndexPath * indexPath;


@property (nonatomic,assign) CGFloat  getLabelCellHeight;

@property (nonatomic,strong) NSArray * contentArray;

//接收头像赋值网址
@property (nonatomic,strong) DetailFansAndFocusModel*model;


- (void)fillCellWithModel:(DetailArrayModel*)model indexPath:(NSIndexPath *)path;


@end
