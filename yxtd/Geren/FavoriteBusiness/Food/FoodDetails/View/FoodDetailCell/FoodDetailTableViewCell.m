//
//  FoodDetailTableViewCell.m
//  yxtd
//
//  Created by qin on 2017/12/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FoodDetailTableViewCell.h"

@interface FoodDetailTableViewCell()

@property (nonatomic,strong) UIView*bgRoundView;

@property (nonatomic,strong) UIImageView*moneyBgimageView;

@property (nonatomic,strong) UILabel* moneyLabel;

@property (nonatomic,strong) UILabel*describeLabel;

@property (nonatomic,strong) UIView*line;

@property (nonatomic,strong) UILabel*dateLabel;


@end

@implementation FoodDetailTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self setUpFoodDetailCell];
    }
    
    return self;
}


-(void)setUpFoodDetailCell{
    
    //黑框背景
    _bgRoundView=[[UIView alloc] init];
    _bgRoundView.backgroundColor=[UIColor whiteColor];
    _bgRoundView.layer.cornerRadius=5;
    _bgRoundView.clipsToBounds=YES;
    _bgRoundView.layer.borderColor=[[UIColor blackColor] CGColor];
    _bgRoundView.layer.borderWidth=0.5;
    [self.contentView addSubview:_bgRoundView];
    

    _moneyBgimageView=[[UIImageView alloc] init];
    _moneyBgimageView.backgroundColor=COLORWITHRGB(0, 219, 220);
    [_bgRoundView addSubview:_moneyBgimageView];
    
    //价钱
    _moneyLabel=[[UILabel alloc] init];
    _moneyLabel.text=@"¥ 15";
    _moneyLabel.textColor=[UIColor whiteColor];
    _moneyLabel.font=[UIFont boldSystemFontOfSize:30];
    [_bgRoundView addSubview:_moneyLabel];
    
    //优惠券说明
    _describeLabel=[[UILabel alloc] init];
    _describeLabel.text=@"满100元VIP专享抵用券";
    _describeLabel.textColor=BlackHexColor;
    _describeLabel.font=[UIFont boldSystemFontOfSize:15];
    [_bgRoundView addSubview:_describeLabel];
    
    
    _line=[[UIView alloc] init];
    _line.backgroundColor=btnLineColor;
    [_bgRoundView addSubview:_line];
    
    
    _dateLabel=[[UILabel alloc] init];
    _dateLabel.text=@"有效期：2017-09-15   00：00   至\n2017-10-09   23：59";
    _dateLabel.textColor=BlackHexColor;
    _dateLabel.alpha=0.5;
    _dateLabel.numberOfLines=0;
    _dateLabel.font=[UIFont boldSystemFontOfSize:10];
    [_bgRoundView addSubview:_dateLabel];
    
    
}



-(void)layoutSubviews{
    
    
    
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
