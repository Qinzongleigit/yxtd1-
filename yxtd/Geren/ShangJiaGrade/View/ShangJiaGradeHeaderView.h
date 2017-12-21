//
//  ShangJiaGradeHeaderView.h
//  yxtd
//
//  Created by qin on 2017/12/21.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShangJiaGradeHeaderView : UIView

@property (nonatomic,strong) void(^buttonAction)(NSInteger tag);



@property (nonatomic,strong) UIImageView*headerBgimageView;

@property (nonatomic,strong) UIButton*backButton;

@property (nonatomic,strong) UIButton*rightButton;

@property (nonatomic,strong) UIImageView*iconImageView;

@property (nonatomic,strong) UILabel*brandNameLabel;

@property (nonatomic,strong) UIImageView*locationImageView;

@property (nonatomic,strong) UILabel*addressLabel;

@property (nonatomic,strong) UIButton*sportButton;

@end
