//
//  StepDayTableViewCell.m
//  yxtd
//
//  Created by qin on 2017/12/15.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "StepDayTableViewCell.h"

@interface StepDayTableViewCell ()

@property (nonatomic,strong) UILabel*paimingLabel;

@property (nonatomic,strong) UIImageView*iconImageV;

@property (nonatomic,strong) UILabel*nichengLabel;

@property (nonatomic,strong) UIImageView*jinduBgImage;

@property (nonatomic,strong) UIImageView*jinduImage;


@property (nonatomic,strong) UILabel*zongshuLabel;


@end

@implementation StepDayTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpStepDayCell];
    }
    
    return self;
}



-(void)setUpStepDayCell{
    //排名
    _paimingLabel=[[UILabel alloc] init];
    _paimingLabel.textColor=BlackHexColor;
    _paimingLabel.font=[UIFont systemFontOfSize:18];
    _paimingLabel.text=@"1";
    [self.contentView addSubview:_paimingLabel];
    
    //头像
    _iconImageV=[[UIImageView alloc] init];
    _iconImageV.backgroundColor=[UIColor purpleColor];
    _iconImageV.layer.cornerRadius=33/2;
    _iconImageV.clipsToBounds=YES;
    [self.contentView addSubview:_iconImageV];
    
    //昵称
    _nichengLabel=[[UILabel alloc] init];
    _nichengLabel.textColor=BlackHexColor;
    _nichengLabel.font=[UIFont systemFontOfSize:12];
    _nichengLabel.text=@"神盾局";
    [self.contentView addSubview:_nichengLabel];
    
    //进度背景
    _jinduBgImage=[[UIImageView alloc] init];
    _jinduBgImage.backgroundColor=[UIColor lightGrayColor];
    _jinduBgImage.layer.cornerRadius=6;
    _jinduBgImage.clipsToBounds=YES;
    [self.contentView addSubview:_jinduBgImage];
    
    //进度条
    _jinduImage=[[UIImageView alloc] init];
    _jinduImage.backgroundColor=COLORWITHRGB(0, 219, 220);
    _jinduImage.layer.cornerRadius=6;
    _jinduImage.clipsToBounds=YES;
    [self.contentView addSubview:_jinduImage];
    
    
    //总数
    _zongshuLabel=[[UILabel alloc] init];
    _zongshuLabel.textColor=BlackHexColor;
    _zongshuLabel.font=[UIFont systemFontOfSize:12];
    _zongshuLabel.text=@"141654";
    [self.contentView addSubview:_zongshuLabel];
    
    
    
    [self.paimingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(19);
    }];
    
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.paimingLabel);
        make.left.mas_equalTo(self.paimingLabel.mas_right).offset(18);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    
    
    [self.nichengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.iconImageV.mas_right).offset(12);
        make.top.mas_equalTo(15);
    }];
    
    [self.jinduBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageV.mas_right).offset(12);
        make.top.mas_equalTo(self.nichengLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-19);
        make.height.mas_equalTo(13);
    }];
    
    
    
    [self.jinduImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jinduBgImage);
        make.height.mas_equalTo(self.jinduBgImage);
        make.top.mas_equalTo(self.jinduBgImage);
        
    }];
    
    [self.contentView layoutIfNeeded];
    
    
    //做动画
    [UIView animateWithDuration:2.0f animations:^{
        
        [self.jinduImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.jinduBgImage.mas_width).multipliedBy(0.6);
        }];
        
        [self.contentView layoutIfNeeded];
    }];
    

    [self.zongshuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.nichengLabel);
        make.right.mas_equalTo(-19);
    }];
    
    
    
    
}



@end
