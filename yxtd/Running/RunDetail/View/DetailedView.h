//
//  DetailedView.h
//  yxtd
//
//  Created by qin on 2017/10/31.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedView : UIView

@property(nonatomic,strong) void(^backRunVC)(void);

@property (nonatomic,strong) UIImageView*bgImageView;
@property (nonatomic,strong) UIImageView*brandImageView;
@property (nonatomic,strong) UIImageView*mapImageView;
@property (nonatomic,strong) UILabel*namelabel;
@property (nonatomic,strong) UILabel*brandNameLabel;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) UILabel*dateLabel;

@property (nonatomic,assign) float  statNum;
@property (nonatomic,strong) UILabel*locationLabel;


@property (nonatomic,strong) UIButton*backBt;
@property (nonatomic,strong) UIButton*rightBt;

@end
