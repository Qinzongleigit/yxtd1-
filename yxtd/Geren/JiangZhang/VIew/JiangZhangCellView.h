//
//  JiangZhangCellView.h
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiangZhangCellView : UIView

//需要有数据源
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,assign) NSInteger dataArrayCount;

//点击时返回下标
@property (nonatomic,copy) void(^ReturnClickItemIndex)(NSIndexPath * itemtIP ,NSInteger itemIndex);

//高度
@property (nonatomic,assign) CGFloat cellHeight;

//单元格的下标
@property (nonatomic,strong) NSIndexPath * indexPath;


@end
