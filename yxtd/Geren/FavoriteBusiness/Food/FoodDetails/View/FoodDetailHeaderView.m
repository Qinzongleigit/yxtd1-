//
//  FoodDetailHeaderView.m
//  yxtd
//
//  Created by qin on 2017/12/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FoodDetailHeaderView.h"
#import "FoodDetaliStarView.h"

@interface FoodDetailHeaderView()

@end

@implementation FoodDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self detailHeaderView];
    }
    
    return self;
    
}


-(void)detailHeaderView{
    
    _headerBgimageView=[[UIImageView alloc] init];
    _headerBgimageView.image=[UIImage imageWithoriginName:@"jifenheader_Image"];
    [self addSubview:_headerBgimageView];
    
    
    _backButton=[[UIButton alloc] init];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"leftLoginImage"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    
    
    _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_Run_Image"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
    
    
    _iconImageView=[[UIImageView alloc] init];
    _iconImageView.backgroundColor=[UIColor redColor];
    _iconImageView.layer.cornerRadius=72/2;
    _iconImageView.clipsToBounds=YES;
    [self addSubview:_iconImageView];
    
    
    _brandNameLabel=[[UILabel alloc] init];
    _brandNameLabel.text=@"STARBUCKS";
    _brandNameLabel.font=[UIFont boldSystemFontOfSize:24];
    _brandNameLabel.textColor=[UIColor whiteColor];
    [self addSubview:_brandNameLabel];
    
    
    _locationImageView=[[UIImageView alloc] init];
    _locationImageView.image=[UIImage imageWithoriginName:@"map_Image"];
    [self addSubview:_locationImageView];
    
    
    _addressLabel=[[UILabel alloc] init];
    _addressLabel.text=@"深圳市南山区工业区";
    _addressLabel.textColor=[UIColor whiteColor];
    _addressLabel.font=[UIFont systemFontOfSize:9];
    [self addSubview:_addressLabel];
    
    
    
}

//星星评分
-(void)setStarNumber:(float)starNumber{
    
    FoodDetaliStarView*starVC=[[FoodDetaliStarView alloc] initWithFrame:CGRectZero withFloatNum:starNumber];
    
   [self addSubview:starVC];
    [starVC mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(96, 15));
        make.bottom.mas_equalTo(-8);
        make.right.mas_equalTo(0);
    }];
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    __weak typeof(self) weakSelf=self;
    
    [_headerBgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(16);
        make.top.equalTo(weakSelf).with.offset(32);
    }];
    
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(_backButton);
    }];
    
    
    
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(_backButton.mas_bottom).offset(15);
        make.centerX.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(72, 72));
    }];
    
    
    [_brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_iconImageView);
        make.top.equalTo(_iconImageView.mas_bottom).with.offset(12);
    }];
    
    
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(23);
        make.bottom.equalTo(weakSelf).with.offset(-10);
    }];
    
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_locationImageView.mas_right).with.offset(6);
        make.centerY.equalTo(_locationImageView);
    }];
    
   
}


-(void)rightBtAction{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"收藏提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}


//返回按钮点击事件
-(void)backBtAction{
    
    self.backToFavoriteVC();
    
}


@end
