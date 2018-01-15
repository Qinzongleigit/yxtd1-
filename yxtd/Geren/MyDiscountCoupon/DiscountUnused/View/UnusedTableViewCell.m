//
//  UnusedTableViewCell.m
//  yxtd
//
//  Created by qin on 2017/12/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "UnusedTableViewCell.h"

@interface UnusedTableViewCell()

@property (nonatomic,strong) UIView*shadowView;

@property (nonatomic,strong) UIView*bgView;

@property (nonatomic,strong) UIImageView*brandImageView;

@property (nonatomic,strong) UIImageView*bgImageView;

@property (nonatomic,strong) UILabel*moneyLabel;

@property (nonatomic,strong) UILabel*describeLabel;

@property (nonatomic,strong) UILabel*dateLabel;

@property (nonatomic,strong) UIImageView*foodIconImageView;


@end

@implementation UnusedTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creadUnusedCell];
    }
    
    return self;
}



-(void)creadUnusedCell{
    
    //白色背景阴影
    _shadowView = [[UIView alloc] init];
    _shadowView.backgroundColor = [UIColor clearColor];
    _shadowView.layer.shadowOpacity = 0.5; //不透明度
    
    _shadowView.layer.shadowOffset=  CGSizeMake(0, 3);//偏移距离
    _shadowView.layer.shadowRadius = 5; //半径
    _shadowView.layer.shadowColor=[UIColor lightGrayColor].CGColor; //阴影颜色
    
    //白色背景
    _bgView=[[UIView alloc] init];
    _bgView.backgroundColor=[UIColor whiteColor];
    _bgView.layer.cornerRadius=10;
    _bgView.clipsToBounds=YES;
    
    [self.contentView addSubview:_shadowView];
    [_shadowView addSubview:_bgView];
    
    //商标
    _brandImageView=[[UIImageView alloc] init];
    _brandImageView.backgroundColor=[UIColor redColor];
    _brandImageView.layer.cornerRadius=56/2;
    _brandImageView.clipsToBounds=YES;
    [_bgView addSubview:_brandImageView];
    
    //食物背景图
    _bgImageView=[[UIImageView alloc] init];
    _bgImageView.backgroundColor=[UIColor purpleColor];
    _bgImageView.layer.cornerRadius=10;
    _bgImageView.clipsToBounds=YES;
    [_bgView addSubview:_bgImageView];
    
    //优惠券价值
    _moneyLabel=[[UILabel alloc] init];
    _moneyLabel.text=@"¥ 15";
    _moneyLabel.textColor=[UIColor whiteColor];
    //_moneyLabel.font=[UIFont systemFontOfSize:30];
    _moneyLabel.font=[UIFont boldSystemFontOfSize:30];
    [_bgView addSubview:_moneyLabel];
    
    //满减
    _describeLabel=[[UILabel alloc] init];
    _describeLabel.text=@"满100VIP专享抵用券";
    _describeLabel.textColor=[UIColor whiteColor];
    _describeLabel.font=[UIFont systemFontOfSize:12];
    [_bgView addSubview:_describeLabel];
    
    
    //食物图标
    _foodIconImageView=[[UIImageView alloc] init];
    _foodIconImageView.backgroundColor=[UIColor yellowColor];
    [_bgView addSubview:_foodIconImageView];
    
    
    _dateLabel=[[UILabel alloc] init];
    _dateLabel.text=@"有效期：\n2017-09-15   00：00    至 \n2017-10-09   23：59";
    _dateLabel.numberOfLines=0;
    _dateLabel.textColor=[UIColor whiteColor];
    _dateLabel.font=[UIFont systemFontOfSize:10];
    [_bgView addSubview:_dateLabel];
    
    
}


-(void)layoutSubviews{
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(_shadowView);
        make.left.top.mas_equalTo(0);
        
    }];
    
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(_bgView);
        make.left.mas_equalTo(_bgView).offset(15);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(_brandImageView.mas_right).offset(15);
        make.top.mas_equalTo(_bgView).offset(0); make.right.mas_equalTo(_bgView).offset(0);
        make.bottom.mas_equalTo(_bgView).offset(0);
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_bgView).offset(10);
        make.left.mas_equalTo(_bgImageView).offset(22);
    }];
    
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_moneyLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_moneyLabel);
    }];
    
   
    [_foodIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(_moneyLabel);
        make.bottom.mas_equalTo(_bgView).offset(-18);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_foodIconImageView.mas_right).offset(8);
        make.centerY.equalTo(_foodIconImageView);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
