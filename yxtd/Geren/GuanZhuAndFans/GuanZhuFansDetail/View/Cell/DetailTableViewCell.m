//
//  DetailTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/2/7.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DianZanParam.h"
#import "DianZanHttp.h"

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

@property (nonatomic,assign) NSIndexPath*row;

@property (nonatomic,strong) NSString*labelStr;

@property (nonatomic,assign) NSInteger dianzanNum;

@property (nonatomic,strong) NSString*record_id;

@property (nonatomic,strong) NSString*subject_catename;

@property (nonatomic,strong) UILabel*commentLabel;

//是否点赞
@property (nonatomic,assign) NSInteger is_nice;

@property (nonatomic,strong) UITextField*commnetText;

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
    _iconImageView.backgroundColor=[UIColor clearColor];
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
    [_button setBackgroundColor:[UIColor clearColor]];
     [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
    [_cellBgView addSubview:_button];
    
    //地图标识
    _mapImageView=[[UIImageView alloc] init];
    _mapImageView.backgroundColor=[UIColor clearColor];
    _mapImageView.image=[UIImage imageWithoriginName:@"gray_map_Image"];
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
    
    //评论内容
    _commentLabel=[[UILabel alloc] init];
    _commentLabel.text=@"sdk";
    _commentLabel.textColor=[UIColor whiteColor];
    _commentLabel.font=[UIFont systemFontOfSize:15];
    [_bgCommentView addSubview:_commentLabel];
    
    
    
    
    //点赞图标
    _dianzanBt =[UIButton buttonWithType:UIButtonTypeCustom];
    _dianzanBt.backgroundColor=[UIColor whiteColor];
    _dianzanBt.tag=1000;
    
    if (self.is_nice==2) {
        
        _dianzanBt.enabled=YES;
        
    }else{
        
        _dianzanBt.enabled=NO;
    }
   
     [_dianzanBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    _pinglunBt.backgroundColor=[UIColor whiteColor];
    [_pinglunBt setBackgroundImage:[UIImage imageNamed:@"pinglun_Image"] forState:UIControlStateNormal];
    _pinglunBt.tag=1001;
    [_pinglunBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_cellBgView addSubview:_pinglunBt];
    
    
    //评论人数
    _pinglunNumber=[[UILabel alloc] init];
    _pinglunNumber.text=@"350";
    _pinglunNumber.textColor=[UIColor lightGrayColor];
    _pinglunNumber.font=[UIFont systemFontOfSize:12];
    [_cellBgView addSubview:_pinglunNumber];
    
    
}

#pragma mark -点赞、评论按钮点击响应事件
-(void)buttonClick:(UIButton*)btn{
    
    if (btn.tag==1001) {
        
        UIView*commnetView=[[UIView alloc] init];
        commnetView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:commnetView];
        [self bringSubviewToFront:commnetView];
        [commnetView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
            make.top.mas_equalTo(_bgCommentView.mas_bottom).offset(2);
        }];
        
        
        _commnetText=[[UITextField alloc] init];
        _commnetText.placeholder=@"请输入评论内容";
        [_commnetText becomeFirstResponder];
        
        [commnetView addSubview:_commnetText];
        [_commnetText mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        
    }else{
        
        [btn setBackgroundImage:[UIImage imageNamed:@"yidianzan_Image"] forState:UIControlStateNormal];
 
            _dianzanNumber.text=[NSString stringWithFormat:@"%ld",_dianzanNum+1];
        
         //点赞接口
        [self getDianZanHttpData];
       
       
    }
    
}




//头像,昵称赋值
-(void)setModel:(DetailFansAndFocusModel *)model{
    
     [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.avatar]]];
    _nameLabel.text=model.nickname;
}


//cell赋值操作
- (void)fillCellWithModel:(DetailArrayModel*)model indexPath:(NSIndexPath *)path{
    
    if ([model.flag integerValue]==3) {
        
        [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
        
        
    }else if ([model.flag integerValue]==2){
        
        [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_man_Image"] forState:UIControlStateNormal];
        
    }else{
        
        [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_women_Image"] forState:UIControlStateNormal];
        
    }
    
   
    
   self.is_nice=[model.is_nice integerValue];
    
    if ([model.is_nice integerValue]==2) {

        [_dianzanBt setBackgroundImage:[UIImage imageNamed:@"yidianzan_Image"] forState:UIControlStateNormal];
       
    }else{
        
        
        
        [_dianzanBt setBackgroundImage:[UIImage imageNamed:@"dianzan_Image"] forState:UIControlStateNormal];
        
    }
   
    _cityLabel.text=model.addres;
    
    _timeLabel.text=model.time;
    
 
    _dianzanNum=[model.nice_num integerValue];
    
    _dianzanNumber.text=[NSString stringWithFormat:@"%@",model.nice_num];
    
    _pinglunNumber.text=[NSString stringWithFormat:@"%@",model.comment_num];
    
    self.record_id=model.record_id;
    
    self.subject_catename=model.subject_catename;
    
    _commentLabel.text=[NSString stringWithFormat:@"%@:%@",model.comment_user,model.comment_content];
    
    
}


#pragma mark - 填充数据
-(void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath=indexPath;
}


//发布图片显示数组
-(void)setDataArray:(NSArray *)dataArray{
    
    _dataArray=dataArray;
    
    //下标
    self.cellView.indexPath=self.indexPath;
    
    //图片数组
    self.cellView.dataImageArray=_dataArray;
    
}

-(void)setContentArray:(NSArray *)contentArray{
    
    
    //发布内容
     _labelStr=contentArray[0];
  NSMutableParagraphStyle*paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    // 行间距设置为5
    [paragraphStyle setLineSpacing:5]; NSMutableAttributedString*setString=[[NSMutableAttributedString alloc] initWithString:_labelStr];
    
    [setString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_labelStr length])];
    
    [_contentLable setAttributedText:setString];
    
    
}


//计算label自适应高度
-(CGFloat)getLabelCellHeight{
    
    CGFloat contentHight=[_labelStr boundingRectWithSize:CGSizeMake(KscreenW-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
   
    return contentHight;
    
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
    
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(_bgCommentView);
        make.left.mas_equalTo(20);
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


#pragma mark -点赞接口
-(void)getDianZanHttpData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    DianZanParam*params=[[DianZanParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    params.member_id=member_idStr;
    
    params.record_id=self.record_id;
    
    params.subject_catename=self.subject_catename;

    [DianZanHttp httpDianZan:params success:^(id responseObject) {
 
        NSLog(@"点赞返回的数据显示%@",responseObject);
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"点赞数据获取失败");
        
        
        
    }];
    
    
}
    



@end
