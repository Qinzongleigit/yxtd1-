//
//  SearchUserTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/2/4.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "SearchUserTableViewCell.h"

@interface SearchUserTableViewCell ()


@property (nonatomic,strong) UIImageView*iconImage;

@property (nonatomic,strong) UILabel*nickNameLabel;

@property (nonatomic,strong) UIButton*sexBtImage;

@property (nonatomic,strong) UIButton*foucsButton;

@property (nonatomic,assign) NSIndexPath*row;



@end

@implementation SearchUserTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatSearchCellUI];
    }
    
    
    return self;
    
}

#pragma mark -创建cell
-(void)creatSearchCellUI{
    
    
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
    
    
    _foucsButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _foucsButton.layer.cornerRadius=5;
    _foucsButton.clipsToBounds=YES;
    _foucsButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_foucsButton];
    
    
    
}

//赋值操作
-(void)fillCellWithModel:(DataModel *)model indexPath:(NSIndexPath *)path{
    
    self.row=path;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.avatar]]];
    _nickNameLabel.text=model.nickname;
    
    if ([model.flag integerValue]==3) {
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
        
        
    }else if ([model.flag integerValue]==2){
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guznzhu_man_Image"] forState:UIControlStateNormal];
        
    }else{
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_women_Image"] forState:UIControlStateNormal];
        
    }
    
    if ([model.is_focus integerValue]==1) {
        
        _foucsButton.backgroundColor=COLORWITHRGB(0, 219, 220);
        [_foucsButton setTitle:@"已关注" forState:UIControlStateNormal];
        [_foucsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }else{
    
        [_foucsButton setTitle:@"关注" forState:UIControlStateNormal];
        [_foucsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _foucsButton.layer.borderWidth=1;
        _foucsButton.layer.borderColor=[UIColor blackColor].CGColor;
        
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
    
    [_foucsButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.nickNameLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(48);
        make.right.mas_equalTo(-23);
    }];
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
