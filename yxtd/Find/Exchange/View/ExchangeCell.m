//
//  ExchangeCell.m
//  yxtd
//
//  Created by qin on 2017/11/10.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ExchangeCell.h"
@interface ExchangeCell ()
@property (nonatomic,strong) UIImageView*IconImage;
@property (nonatomic,strong) UIImageView*bgImage;
@property (nonatomic,strong) UIImageView*imageView1;
@property (nonatomic,strong) UILabel*zhifenlabel;
@end

@implementation ExchangeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

       [self setUpCell];
    }

    return self;
}

//布局cell
-(void)setUpCell{
    
    UIImageView*IconImage=[[UIImageView alloc] init];
    self.IconImage=IconImage;
    IconImage.backgroundColor=[UIColor purpleColor];
    IconImage.layer.cornerRadius=36/2;
    IconImage.clipsToBounds=YES;
    [self.contentView addSubview:IconImage];
    
    
    UIImageView*bgImage=[[UIImageView alloc] init];
    self.bgImage=bgImage;
    bgImage.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:bgImage];
    
    UILabel*zhifenlabel=[[UILabel alloc] init];
    self.zhifenlabel=zhifenlabel;
    zhifenlabel.text=@"100之分出星巴克优惠券";
    zhifenlabel.textColor=BlackHexColor;
    zhifenlabel.font=[UIFont systemFontOfSize:12];
    [bgImage addSubview:zhifenlabel];
    
    
    UIImageView*imageView=[[UIImageView alloc] init];
    self.imageView1=imageView;
    imageView.backgroundColor=[UIColor greenColor];
    [bgImage addSubview:imageView];
    
}

-(void)layoutSubviews{
    
    __weak typeof(self) weakSelf=self;
    [self.IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf).with.offset(17);
        make.top.equalTo(weakSelf).with.offset(28);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.IconImage.mas_right).with.offset(7);
        make.right.equalTo(weakSelf).with.offset(-43);
        make.top.equalTo(weakSelf).with.offset(32);
        make.bottom.equalTo(weakSelf).with.offset(5);
        
    }];
    
    
    [self.zhifenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_bgImage);
        make.top.equalTo(_bgImage.mas_top).with.offset(5);
    }];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.top.equalTo(self.zhifenlabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(_bgImage.mas_bottom).with.offset(-5);
        make.left.equalTo(_bgImage.mas_left).with.offset(5);
        make.right.equalTo(_bgImage.mas_right).with.offset(-5);
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
