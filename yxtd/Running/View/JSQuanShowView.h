//
//  JSQuanShowView.h
//  yxtd
//
//  Created by qin on 2017/10/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSQuanShowView : UIView

@property(nonatomic,strong) void(^gotoDetailVC)(void);

@property (nonatomic,strong) UIImageView*bgImageView;
@property (nonatomic,strong) UIImageView*brandImageView;
@property (nonatomic,strong) UIImageView*hotImageView;
@property (nonatomic,strong) UILabel*namelabel;
@property (nonatomic,strong) UILabel*brandNameLabel;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) UILabel*dateLabel;
@property (nonatomic,strong) UIView*starBgView;
@property (nonatomic,assign) float  statNum;






@property (nonatomic,strong) UILabel *label_address;
@property (nonatomic,strong) UILabel *label_minutes;
@property (nonatomic,strong) UILabel *label_distance;
@property (nonatomic,strong) UILabel *label_availTotal;
@property (nonatomic,strong) UILabel *label_emptyTotal;

@end
