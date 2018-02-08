//
//  DetailImageCellView.h
//  yxtd
//
//  Created by qin on 2018/2/8.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImageCellView : UIView

//需要有数据源
@property (nonatomic,strong) NSArray * dataImageArray;

@property (nonatomic,assign) NSInteger dataArrayCount;

//点击图片时返回下标
@property (nonatomic,copy) void(^ReturnImageClickItemIndex)(NSIndexPath * itemtIP ,NSInteger itemIndex);

//高度
@property (nonatomic,assign) CGFloat cellHeight;

//单元格的下标
@property (nonatomic,strong) NSIndexPath * indexPath;

@end
