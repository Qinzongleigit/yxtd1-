//
//  FoodDetailHeaderView.h
//  yxtd
//
//  Created by qin on 2017/12/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailHeaderView : UIView

@property (nonatomic,strong) void(^backToFavoriteVC)(void);

@property (nonatomic,strong) UIImageView*headerBgimageView;

@property (nonatomic,strong) UIButton*backButton;

@property (nonatomic,strong) UIButton*rightButton;

@property (nonatomic,strong) UIImageView*iconImageView;

@property (nonatomic,strong) UILabel*brandNameLabel;

@property (nonatomic,strong) UIImageView*locationImageView;

@property (nonatomic,strong) UILabel*addressLabel;

@property (nonatomic,assign) float starNumber;



@end
