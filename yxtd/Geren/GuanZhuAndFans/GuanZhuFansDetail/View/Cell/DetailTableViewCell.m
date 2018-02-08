//
//  DetailTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/2/7.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()

@property (nonatomic,strong) UIView*cellBgView;

@property (nonatomic,strong) UIImageView*iconImageView;
@property (nonatomic,strong) UILabel*nameLabel;
@property (nonatomic,strong) UIButton*button;
@property (nonatomic,strong) UIImageView*mapImageView;
@property (nonatomic,strong) UILabel*cityLabel;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) UILabel*timeLabel;
@property (nonatomic,strong) UILabel*contentLable;


@property (nonatomic,strong) UIView*bgCommentView;

@property (nonatomic,strong) UIButton*dianzanBt;

@property (nonatomic,strong) UILabel*dianzanNumber;

@property (nonatomic,strong) UIView*lineV;

@property (nonatomic,strong) UIButton*pinglunBt;

@property (nonatomic,strong) UILabel*pinglunNumber;



@end

@implementation DetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self makeCellUI];
    }
    
    return self;
    
}

#pragma mark -界面布局
-(void)makeCellUI{
    
    //cell背景
    _cellBgView=[[UIView alloc] init];
    _cellBgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_cellBgView];
    
    
    //头像
    _iconImageView=[[UIImageView alloc] init];
    _iconImageView.backgroundColor=[UIColor redColor];
    _iconImageView.layer.cornerRadius=22/2;
    _iconImageView.clipsToBounds=YES;
    [_cellBgView addSubview:_iconImageView];
    
    //昵称
    _nameLabel=[[UILabel alloc ] init];
    _nameLabel.text=@"跑券";
    _nameLabel.textColor=BlackHexColor;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [_cellBgView addSubview:_nameLabel];
    
    //是否为官方标识
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundColor:[UIColor purpleColor]];
    [_cellBgView addSubview:_button];
    
    //地图标识
    _mapImageView=[[UIImageView alloc] init];
    _mapImageView.backgroundColor=[UIColor yellowColor];
    [_cellBgView addSubview:_mapImageView];
    
    //发布城市
    _cityLabel=[[UILabel alloc ] init];
    _cityLabel.text=@"深圳";
    _cityLabel.textColor=[UIColor lightGrayColor];
    _cityLabel.font=[UIFont systemFontOfSize:9];
    [_cellBgView addSubview:_cityLabel];
    
    //竖线
    _lineView=[[UIView alloc] init];
    _lineView.backgroundColor=[UIColor lightGrayColor];
    [_cellBgView addSubview:_lineView];
    
    //发布时间
    _timeLabel=[[UILabel alloc ] init];
    _timeLabel.text=@"10小时前";
    _timeLabel.textColor=[UIColor lightGrayColor];
    _timeLabel.font=[UIFont systemFontOfSize:9];
    [_cellBgView addSubview:_timeLabel];
    
    //动态内容
    _contentLable=[[UILabel alloc] init];
 NSMutableParagraphStyle*paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    
    // 行间距设置为5
    [paragraphStyle setLineSpacing:5];
    NSString*labelStr=@"发疯地爱生活、爱斗争、建设的人，只有我们这些看透了生活的全部意义的人，才不会随便死去，哪怕只有一点机会就不能放弃生活.";
    NSMutableAttributedString*setString=[[NSMutableAttributedString alloc] initWithString:labelStr];
    [setString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelStr length])];
    
    [_contentLable setAttributedText:setString];
    _contentLable.textColor=BlackHexColor;
    _contentLable.font=[UIFont systemFontOfSize:14];
    _contentLable.numberOfLines=0;
    [_cellBgView addSubview:_contentLable];
    
    
    //动态图片显示
    _cellView=[[DetailImageCellView alloc] init];
    [_cellBgView addSubview:_cellView];
    
    
    //评论显示背景图
    _bgCommentView=[[UIView alloc] init];
    _bgCommentView.backgroundColor=[UIColor lightGrayColor];
    [_cellBgView addSubview:_bgCommentView];
    
    
    //点赞图标
    _dianzanBt =[UIButton buttonWithType:UIButtonTypeCustom];
    _dianzanBt.backgroundColor=[UIColor redColor];
    [_cellBgView addSubview:_dianzanBt];
    
    
    //点赞人数
    _dianzanNumber=[[UILabel alloc] init];
    _dianzanNumber.text=@"1687";
    _dianzanNumber.textColor=[UIColor lightGrayColor];
    _dianzanNumber.font=[UIFont systemFontOfSize:12];
    [_cellBgView addSubview:_dianzanNumber];
    
    //点赞区域竖线
    _lineV=[[UIView alloc] init];
    _lineV.backgroundColor=[UIColor lightGrayColor];
    [_cellBgView addSubview:_lineV];
    
    //评论图标
    _pinglunBt =[UIButton buttonWithType:UIButtonTypeCustom];
    _pinglunBt.backgroundColor=[UIColor redColor];
    [_cellBgView addSubview:_pinglunBt];
    
    //评论人数
    _pinglunNumber=[[UILabel alloc] init];
    _pinglunNumber.text=@"350";
    _pinglunNumber.textColor=[UIColor lightGrayColor];
    _pinglunNumber.font=[UIFont systemFontOfSize:12];
    [_cellBgView addSubview:_pinglunNumber];
    
    
}


#pragma mark - 填充数据
-(void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath=indexPath;
}

-(void)setDataArray:(NSArray *)dataArray{
    
    _dataArray=dataArray;
    self.cellView.indexPath=self.indexPath;
    self.cellView.dataImageArray=_dataArray;
    
}


#pragma mark -位置坐标
-(void)layoutSubviews{
    
    [_cellBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-12);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(19);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
        
    }];
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.nameLabel);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel.mas_left).offset(-7);
     
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.timeLabel.mas_height);
        make.centerY.mas_equalTo(self.timeLabel);
        
    }];
    
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.lineView.mas_left).offset(-7);
        make.centerY.mas_equalTo(self.timeLabel);
        
        
    }];
    
    [_mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(self.cityLabel.mas_left).offset(-6);
        make.size.mas_equalTo(CGSizeMake(6, 7));
    }];
    
    
    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(17);
    }];
    
    
    [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contentLable.mas_bottom).offset(5);
        
        make.bottom.mas_equalTo(self.bgCommentView.mas_top).offset(0);
        
    }];
    
   
    
    
    
    [_bgCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.dianzanBt.mas_top).offset(-16);
        make.height.mas_equalTo(30);
        
        
    }];
    
    [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-13);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.dianzanBt.mas_height);
    }];
    
    [_dianzanNumber mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.lineV.mas_left).offset(-80);
        make.centerY.mas_equalTo(self.lineV);
        
    }];
    
    
    [_dianzanBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.dianzanNumber);
        make.right.mas_equalTo(self.dianzanNumber.mas_left).offset(-15);
        
    }];
    
    
    [_pinglunBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.lineV.mas_right).offset(80);
        make.centerY.mas_equalTo(self.dianzanBt);
    }];
    
    [_pinglunNumber mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.pinglunBt);
        make.left.mas_equalTo(self.pinglunBt.mas_right).offset(20);
    }];
    
    
}



@end
