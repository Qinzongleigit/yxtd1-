//
//  ShangJiaTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/1/5.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "ShangJiaTableViewCell.h"

@interface ShangJiaTableViewCell()

@property (nonatomic,strong) UIImageView*brandImageView;

@property (nonatomic,strong) UILabel*brandNameLabel;

@property (nonatomic,strong) UILabel*kmLabel;

@property (nonatomic,strong) UILabel*typeLabel;


@end

@implementation ShangJiaTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpFoodCell];
        
    }
    
    return self;
}



-(void)setUpFoodCell{
    
    //商家图片
    _brandImageView=[[UIImageView alloc] init];
    _brandImageView.backgroundColor=[UIColor purpleColor];
    _brandImageView.layer.cornerRadius=5;
    _brandImageView.clipsToBounds=YES;
    [self.contentView addSubview:_brandImageView];
    
    
    //商家名字
    _brandNameLabel=[[UILabel alloc] init];
    _brandNameLabel.text=@"星巴克咖啡";
    _brandNameLabel.textColor=BlackHexColor;
    _brandNameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:_brandNameLabel];
    
    //距离商家的路程长
    _kmLabel=[[UILabel alloc] init];
    _kmLabel.text=@"8km";
    _kmLabel.textColor=BlackHexColor;
    _kmLabel.alpha=0.5;
    _kmLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_kmLabel];
    
    
    
    //商家类型
    _typeLabel=[[UILabel alloc] init];
    _typeLabel.text=@"休闲咖啡";
    _typeLabel.textColor=BlackHexColor;
    _typeLabel.alpha=0.5;
    _typeLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_typeLabel];
    
    
    
    //星星等级
    self.starVC=[[FoodStarView alloc] initWithFrame:CGRectZero withFloatNum:4.5];
    [self.contentView addSubview:self.starVC];
    
    
    
    _starButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_starButton setTitle:@"去打星" forState:UIControlStateNormal];
    [_starButton setTitleColor:COLORWITHRGB(236, 105, 65) forState:UIControlStateNormal];
    [_starButton setBackgroundColor:[UIColor whiteColor]];
    _starButton.titleLabel.font=[UIFont systemFontOfSize:10];
    _starButton.layer.cornerRadius=3;
    _starButton.layer.borderWidth=1;
    _starButton.layer.borderColor=COLORWITHRGB(236, 105, 65).CGColor;
    _starButton.clipsToBounds=YES;
    
    [_starButton addTarget:self action:@selector(starBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_starButton];
    

    
}



-(void)layoutSubviews{
    
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
    }];
    
    
    [_brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(_brandImageView.mas_right).offset(10);
        
    }];
    
    [_kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_brandNameLabel);
        make.right.mas_equalTo(-10);
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_brandNameLabel);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    [self.starVC mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(_brandNameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(_brandNameLabel);
        make.size.mas_equalTo(CGSizeMake(105, 15));
    }];
    
    
    
    [_starButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(_typeLabel);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(50);
        
        
    }];
    
    
}

-(void)starBtAction{
    
    self.starButtonBlock();
    
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
