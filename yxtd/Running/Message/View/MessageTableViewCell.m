//
//  MessageTableViewCell.m
//  yxtd
//
//  Created by qin on 2017/12/27.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@property (nonatomic,strong) UIImageView*messageImageView;

@property (nonatomic,strong) UILabel*tongzhiLabel;

@property (nonatomic,strong) UILabel*timeLabel;




@end

@implementation MessageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatMessageCell];
        
    }
    
    return self;
    
}

-(void)creatMessageCell{
    
    
    _messageImageView=[[UIImageView alloc] init];
    _messageImageView.image=[UIImage imageWithoriginName:@"tongzhi_Image"];
    [self.contentView addSubview:_messageImageView];
    
    
    _tongzhiLabel=[[UILabel alloc] init];
    _tongzhiLabel.font=[UIFont boldSystemFontOfSize:12];
    _tongzhiLabel.textColor=BlackHexColor;
    _tongzhiLabel.text=@"活动通知";
    [self.contentView addSubview:_tongzhiLabel];
    
    _timeLabel=[[UILabel alloc] init];
    _timeLabel.font=[UIFont systemFontOfSize:12];
    _timeLabel.textColor=BlackHexColor;
    _timeLabel.text=@"1个月前";
    _timeLabel.alpha=0.5;
    [self.contentView addSubview:_timeLabel];
    
    _messageLabel=[[UILabel alloc] init];
    _messageLabel.font=[UIFont systemFontOfSize:12];
    _messageLabel.textColor=BlackHexColor;
    _messageLabel.text=@"阿里斯顿了商家福利大师傅";
    _messageLabel.numberOfLines=0;
    [self.contentView addSubview:_messageLabel];
    
    
    
}


-(void)layoutSubviews{
    
    
    [_messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        
    }];
    
    

    [_tongzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(_messageImageView.mas_right).offset(10);
        make.top.mas_equalTo(10);

    }];


    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(_tongzhiLabel);
        make.top.mas_equalTo(_tongzhiLabel.mas_bottom).offset(5);

    }];


    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(_tongzhiLabel);
        make.right.mas_equalTo(-5);

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
