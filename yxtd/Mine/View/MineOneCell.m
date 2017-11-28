//
//  MineOneCell.m
//  yxtd
//
//  Created by qin on 2017/10/12.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MineOneCell.h"

@interface MineOneCell ()

@property (nonatomic,strong) UIImageView*iconImage;

@property (nonatomic,strong) UILabel*nameLabel;

@property (nonatomic,strong) UIImageView*codeImage;

@property (nonatomic,strong) UILabel*guanzhuLabel;

@property (nonatomic,strong) UILabel*fensiLabel;

@property (nonatomic,strong) UILabel*dongtaiLabel;

@property (nonatomic,strong) UILabel*guanzhuNumber;

@property (nonatomic,strong) UILabel*fensiNumber;

@property (nonatomic,strong) UILabel*dongtaiNumber;

@property (nonatomic, strong) UIView *cutLineView;

@end

@implementation MineOneCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconImage=[[UIImageView alloc] init];
        _iconImage.backgroundColor=[UIColor purpleColor];
        [self.contentView addSubview:_iconImage];
        
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.text=@"绥芬河开发商";
        //_nameLabel.textColor=btnLineColor;
        _nameLabel.font=[UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_nameLabel];
        
        
        _codeImage=[[UIImageView alloc] init];
        //_codeImage.backgroundColor=[UIColor redColor];
        _codeImage.image=[UIImage imageWithoriginName:@"code_Image"];
        [self.contentView addSubview:_codeImage];
        
        
        _guanzhuLabel=[[UILabel alloc] init];
        _guanzhuLabel.text=@"关注";
        _guanzhuLabel.textColor=BlackHexColor;
        _guanzhuLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_guanzhuLabel];
        
        _fensiLabel=[[UILabel alloc] init];
        _fensiLabel.text=@"粉丝";
        _fensiLabel.textColor=BlackHexColor;
        _fensiLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_fensiLabel];
        
        _dongtaiLabel=[[UILabel alloc] init];
        _dongtaiLabel.text=@"动态";
        _dongtaiLabel.textColor=BlackHexColor;
        _dongtaiLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_dongtaiLabel];
        
        
        _guanzhuNumber=[[UILabel alloc] init];
        _guanzhuNumber.text=@"10";
        _guanzhuNumber.textColor=BlackHexColor;
        _guanzhuNumber.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_guanzhuNumber];
        
        
        _fensiNumber=[[UILabel alloc] init];
        _fensiNumber.text=@"30";
        _fensiNumber.textColor=BlackHexColor;
        _fensiNumber.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_fensiNumber];
        
        
        _dongtaiNumber=[[UILabel alloc] init];
        _dongtaiNumber.text=@"100";
        _dongtaiNumber.textColor=BlackHexColor;
       _dongtaiNumber.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dongtaiNumber];
        
        
        _cutLineView=[[UIView alloc] init];
        _cutLineView.backgroundColor=btnLineColor;
        [self.contentView addSubview:_cutLineView];
        
    }
    return self;
}




-(void)layoutSubviews{
    
    __weak typeof(self) weakSelf=self;
    
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(16);
        make.top.equalTo(weakSelf).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(68, 68));
        
    }];
    
    _iconImage.layer.cornerRadius=68/2;
    _iconImage.clipsToBounds=YES;
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf).with.offset(23);
        make.left.equalTo(_iconImage.mas_right).with.offset(15);
    }];
    
    
    [_codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_nameLabel);
        
        make.left.equalTo(_nameLabel.mas_right).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
        
    }];
    
    [_guanzhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconImage.mas_right).with.offset(17);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(10);
        
    }];
    
    [_fensiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_guanzhuLabel);
        
        make.left.equalTo(_guanzhuLabel.mas_right).with.offset(18);
    }];
    
    
    [_dongtaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_guanzhuLabel);
        
        make.left.equalTo(_fensiLabel.mas_right).with.offset(18);
    }];
    
    
    [_guanzhuNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_guanzhuLabel);
        make.top.equalTo(_guanzhuLabel.mas_bottom).with.offset(10);
        
    }];
    
    [_fensiNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_fensiLabel);
        
        make.top.equalTo(_fensiLabel.mas_bottom).with.offset(10);
        make.top.equalTo(_fensiLabel.mas_bottom).offset(10);
        
        
        
    }];
    
    
    [_dongtaiNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_dongtaiLabel);
        
        make.top.equalTo(_dongtaiLabel.mas_bottom).with.offset(10);
    }];
    
    
    [_cutLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(16);
        make.bottom.equalTo(weakSelf).with.offset(-1);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.equalTo(@1);
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
