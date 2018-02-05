//
//  GuanZhuTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/2/2.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "GuanZhuTableViewCell.h"

@interface GuanZhuTableViewCell ()

@property (nonatomic,strong) UIImageView*iconImage;

@property (nonatomic,strong) UILabel*nickNameLabel;

@property (nonatomic,strong) UIButton*sexBtImage;

@property (nonatomic,assign) NSIndexPath*row;

@end

@implementation GuanZhuTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatCellUI];
    }
    
    
    return self;
    
}

#pragma mark -创建cell
-(void)creatCellUI{
    
    
    _iconImage=[[UIImageView alloc] init];
    _iconImage.backgroundColor=[UIColor clearColor];
    _iconImage.layer.cornerRadius=21/2;
    _iconImage.clipsToBounds=YES;
    [self.contentView addSubview:_iconImage];
    
    
    
    _nickNameLabel=[[UILabel alloc] init];
    _nickNameLabel.text=@"迷妹达人";
    _nickNameLabel.textColor=BlackHexColor;
    _nickNameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nickNameLabel];
    
    

    _sexBtImage=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_sexBtImage];
    
    
    
}

//赋值操作
-(void)fillCellWithModel:(GuanZhuModel *)model indexPath:(NSIndexPath *)path{
    
       self.row=path;
    
       [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.avatar]]];
    _nickNameLabel.text=model.nickname;
    
    if ([model.flag integerValue]==3) {
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
      
        
    }else if ([model.flag integerValue]==2){
        
         [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_man_Image"] forState:UIControlStateNormal];
   
    }else{
        
           [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_women_Image"] forState:UIControlStateNormal];
     
    }
    
   
}


-(void)layoutSubviews{
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(23);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.iconImage);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(15);
        
    }];
    
    [_sexBtImage mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.nickNameLabel.mas_right).offset(8);
        make.top.mas_equalTo(16);
    
    }];
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
