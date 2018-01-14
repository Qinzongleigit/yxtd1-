//
//  MySportsTableViewCell.m
//  yxtd
//
//  Created by 覃宗雷 on 2018/1/14.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "MySportsTableViewCell.h"

@interface MySportsTableViewCell ()

@property (nonatomic,strong) UIImageView*bgImageView;

@property (nonatomic,strong) UILabel*statusLabel;

@property (nonatomic,strong) UILabel*typesLabel;

@end

@implementation MySportsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatCellUI];
        
    }
    
    return self;
    
}

-(void)creatCellUI{
    
    self.bgImageView=[[UIImageView alloc] init];
    self.bgImageView.layer.cornerRadius=5;
    self.bgImageView.clipsToBounds=YES;
    self.bgImageView.backgroundColor=[UIColor purpleColor];
    [self.contentView addSubview:self.bgImageView];
    
    
    
    self.statusLabel=[[UILabel alloc] init];
    self.statusLabel.font=[UIFont systemFontOfSize:12];
    self.statusLabel.text=@"进行中";
    self.statusLabel.textColor=[UIColor orangeColor];
    [self.contentView addSubview:self.statusLabel];
    
    
    
    self.typesLabel=[[UILabel alloc] init];
    self.typesLabel.font=[UIFont systemFontOfSize:12];
    self.typesLabel.text=@"当前步数 45414";
    self.typesLabel.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.typesLabel];
}


-(void)layoutSubviews{
    
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(-10);
        make.left.mas_equalTo(self.bgImageView).offset(15);
    }];
    
    [self.typesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.statusLabel);
        make.right.mas_equalTo(self.bgImageView.mas_right).offset(-15);
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
