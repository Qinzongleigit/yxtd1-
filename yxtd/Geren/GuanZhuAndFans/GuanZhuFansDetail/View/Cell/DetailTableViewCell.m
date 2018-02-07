//
//  DetailTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/2/7.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()

@property (nonatomic,strong) UIImageView*iconImageView;
@property (nonatomic,strong) UILabel*nameLabel;
@property (nonatomic,strong) UIButton*button;
@property (nonatomic,strong) UIImageView*mapImageView;
@property (nonatomic,strong) UILabel*cityLabel;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) UILabel*timeLabel;
@property (nonatomic,strong) UILabel*contentLable;
@property (nonatomic,strong) UIImageView*issueImageView;

@property (nonatomic,strong) UIView*bgCommentView;


@end

@implementation DetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self makeCellUI];
    }
    
    return self;
    
}

#pragma mark -界面布局
-(void)makeCellUI{
    //头像
    _iconImageView=[[UIImageView alloc] init];
    _iconImageView.backgroundColor=[UIColor redColor];
    _iconImageView.layer.cornerRadius=22/2;
    _iconImageView.clipsToBounds=YES;
    [self.contentView addSubview:_iconImageView];
    
    //昵称
    _nameLabel=[[UILabel alloc ] init];
    _nameLabel.text=@"跑券";
    _nameLabel.textColor=BlackHexColor;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    
    //是否为官方标识
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundColor:[UIColor purpleColor]];
    [self.contentView addSubview:_button];
    
    //地图标识
    _mapImageView=[[UIImageView alloc] init];
    _mapImageView.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:_mapImageView];
    
    //发布城市
    _cityLabel=[[UILabel alloc ] init];
    _cityLabel.text=@"深圳";
    _cityLabel.textColor=[UIColor lightGrayColor];
    _cityLabel.font=[UIFont systemFontOfSize:9];
    [self.contentView addSubview:_cityLabel];
    
    //竖线
    _lineView=[[UIView alloc] init];
    _lineView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:_lineView];
    
    //发布时间
    _timeLabel=[[UILabel alloc ] init];
    _timeLabel.text=@"10小时前";
    _timeLabel.textColor=[UIColor lightGrayColor];
    _timeLabel.font=[UIFont systemFontOfSize:9];
    [self.contentView addSubview:_timeLabel];
    
    
    
}


#pragma mark -位置坐标
-(void)layoutSubviews{
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(19);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
        
    }];
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.nameLabel);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel.mas_left).offset(-7);
     
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.timeLabel.mas_height);
        make.centerY.mas_equalTo(self.timeLabel);
        
    }];
    
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.lineView.mas_left).offset(-7);
        make.centerY.mas_equalTo(self.timeLabel);
        
        
    }];
    
    [_mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(self.cityLabel.mas_left).offset(-6);
        make.size.mas_equalTo(CGSizeMake(6, 7));
    }];
    
    
    
}



@end
