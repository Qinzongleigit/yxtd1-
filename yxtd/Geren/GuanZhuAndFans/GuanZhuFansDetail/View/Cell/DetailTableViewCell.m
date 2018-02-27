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



#define padding 10
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

//myfamily
#define myFamilyHeaderHeight 80
#define makeBookButtonHeight 60

#define imageTag 2000

#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:13]
#define timeFont [UIFont systemFontOfSize:10]
#define replyFont [UIFont systemFontOfSize:13]



@interface DetailTableViewCell ()


@property (weak,nonatomic)UIImageView *iconView;
@property (strong,nonatomic)NSMutableArray *picturesView;
@property (strong,nonatomic)NSMutableArray *replysView;
@property (weak,nonatomic)UILabel *nameLabel;
@property (weak,nonatomic)UILabel *timeLabel;
@property (weak,nonatomic)UIView*lineH;
@property (weak,nonatomic)UILabel *cityLabel;
@property (weak,nonatomic)UILabel *shuoshuotextLabel;
@property (weak,nonatomic)UIImageView *replyBackgroundView;

@property (weak,nonatomic)UIImageView *mapLogoView;

@property (weak,nonatomic)UIView*lineView;

@property (weak,nonatomic)UILabel *dianzanNumberLabel;

@property (nonatomic,strong) UIButton*dianzanBt;

//
//@property (nonatomic,strong) UILabel*dianzanNumber;
//
//@property (nonatomic,strong) UIView*lineV;
//
//@property (nonatomic,strong) UIButton*pinglunBt;
//
//@property (nonatomic,strong) UILabel*pinglunNumber;
//
//@property (nonatomic,assign) NSIndexPath*row;
//
//@property (nonatomic,strong) NSString*labelStr;
//
//@property (nonatomic,assign) NSInteger dianzanNum;
//
//@property (nonatomic,strong) NSString*record_id;
//
//@property (nonatomic,strong) NSString*subject_catename;
//
//@property (nonatomic,strong) UILabel*commentLabel;
//
////是否点赞
//@property (nonatomic,assign) NSInteger is_nice;
//
//@property (nonatomic,strong) UITextView*commnetTextView;

@end

@implementation DetailTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"FamilyGroupCell";
    
    //缓存中取
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //创建
    if (!cell)
    {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
   
    
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //让子定义cell和系统cell一样，一创建出来就有一些子控件给我们使用
        //创建头像
        self.selectionStyle = UITableViewCellSelectionStyleNone;   //cell选中时的颜色，无色
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        
        //创建昵称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = nameFont;
        nameLabel.textColor = [UIColor colorWithRed:77/255.0 green:182/255.0 blue:172/255.0 alpha:1];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        
        //创建时间戳
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = timeFont;
        timeLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        //发布时间前竖线
        UIView*lineH=[[UIView alloc] init];
        lineH.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:lineH];
        self.lineH=lineH;
        
        
        //城市定位
        UILabel *cityLabel = [[UILabel alloc]init];
        cityLabel.font = timeFont;
        cityLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
        cityLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:cityLabel];
        self.cityLabel = cityLabel;
        
        //地图标志
        UIImageView*mapLogoView=[[UIImageView alloc] init];
        mapLogoView.image=[UIImage imageNamed:@"gray_map_Image"];
        [self.contentView addSubview:mapLogoView];
        self.mapLogoView=mapLogoView;
        
        
        
        //创建正文
        UILabel *shuoshuotextLabel = [[UILabel alloc]init];
        shuoshuotextLabel.font = textFont;
        shuoshuotextLabel.textColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        shuoshuotextLabel.numberOfLines = 0;
        [self.contentView addSubview:shuoshuotextLabel];
        self.shuoshuotextLabel = shuoshuotextLabel;
        
       
        
        //创建评论按钮
        UIButton *replyButton = [UIButton buttonWithType:0];
        [replyButton setImage:[UIImage imageNamed:@"reply"] forState:0];
        [self.contentView addSubview:replyButton];
        self.replyButton = replyButton;
        
        //创建评论的背景
        UIImageView *replyBackgroundView = [[UIImageView alloc]init];
        replyBackgroundView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [self.contentView addSubview:replyBackgroundView];
        self.replyBackgroundView = replyBackgroundView;
        
        
        //点赞lan竖线
        UIView*lineView=[[UIView alloc] init];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        self.lineView=lineView;
        
        
        UILabel *dianzanNumberLabel = [[UILabel alloc]init];
        dianzanNumberLabel.font = timeFont;
        dianzanNumberLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
        [self.contentView addSubview:dianzanNumberLabel];
        self.dianzanNumberLabel = dianzanNumberLabel;
        
        //点赞图标
         UIButton*dianzanBt =[UIButton buttonWithType:UIButtonTypeCustom];
          dianzanBt.backgroundColor=[UIColor clearColor];
 
       [dianzanBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
         [dianzanBt setBackgroundImage:[UIImage imageNamed:@"yidianzan_Image"] forState:UIControlStateNormal];
        [self.contentView addSubview:dianzanBt];
        self.dianzanBt=dianzanBt;
     
        
    }
    
    return self;
}





//赋值
-(void)settingtData
{
    
     DetailArrayModel *modelGroup = self.cellFrame.modelGroup;
   DetailFansAndFocusModel*model=self.cellFrame.model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.avatar]]];
    
    _nameLabel.text=model.nickname;
    
    _cityLabel.text=modelGroup.addres;
    
    
    //创建正文
    self.shuoshuotextLabel.text = modelGroup.content[0];
    
    //创建配图
    for (int i = 0; i < [modelGroup.img_url count]; i++) {
        
        UIImageView *pictureView = [[UIImageView alloc]init];
        pictureView.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureView addGestureRecognizer:tap];
        pictureView.tag = imageTag + i;
        
        
        pictureView.userInteractionEnabled = YES;
        [self.contentView addSubview:pictureView];
        [self.picturesView addObject:pictureView];
        [pictureView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",modelGroup.img_url[i]]]];
    }
    
    //时间戳
    self.timeLabel.text = modelGroup.time;
    
    //创建评论
    for (int i = 0; i < [modelGroup.content count]; i++) {
        UILabel *replyLabel = [[UILabel alloc]init];
        replyLabel.font = replyFont;
        replyLabel.numberOfLines = 0;
        
        NSString *searchText = [modelGroup.content objectAtIndex:i];
        //NSString *searchText = @"浮夸：哈哈";
        //把评论的姓名变色，用正则表达式
        NSRange range = [searchText rangeOfString:@"([\u4e00-\u9fa5]|[a-zA-Z0-9])+：" options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:searchText];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:104/255.0 green:109/255.0 blue:248/255.0 alpha:1.0] range:NSMakeRange(0, range.length - 1)];
            replyLabel.attributedText = str;
        }
        else
        {
            replyLabel.text = [modelGroup.content objectAtIndex:i];
        }
        [self.contentView addSubview:replyLabel];
        [self.replysView addObject:replyLabel];
    }
    
    
    self.dianzanNumberLabel.text=[NSString stringWithFormat:@"%@",modelGroup.nice_num];
    
    
    
}


-(NSMutableArray *)picturesView
{
    if (!_picturesView) {
        _picturesView = [[NSMutableArray alloc]init];
    }
    return _picturesView;
    
}


-(NSMutableArray *)replysView
{
    if (!_replysView) {
        _replysView = [[NSMutableArray alloc]init];
    }
    return _replysView;
}

-(void)settingFrame
{
    self.iconView.frame = self.cellFrame.iconF;
    
    self.nameLabel.frame = self.cellFrame.nameF;
    
    self.lineH.frame=self.cellFrame.lineF;
    
    self.cityLabel.frame=self.cellFrame.cityF;
    
    self.mapLogoView.frame=self.cellFrame.mapLogoF;
    
    self.shuoshuotextLabel.frame = self.cellFrame.shuoshuotextF;
    
    for (int i = 0; i < [self.cellFrame.picturesF count]; i++) {
        ((UIImageView *)[self.picturesView objectAtIndex:i]).frame = [((NSValue *)[self.cellFrame.picturesF objectAtIndex:i]) CGRectValue];
    }
    for (int i = 0; i < [self.cellFrame.replysF count]; i++) {
        ((UILabel *)[self.replysView objectAtIndex:i]).frame = [(NSValue *)[self.cellFrame.replysF objectAtIndex:i] CGRectValue];
    }
    self.timeLabel.frame = self.cellFrame.timeF;
    
    self.replyButton.frame = self.cellFrame.replyF;
    
     self.replyBackgroundView.frame = self.cellFrame.replyBackgroundF;
    
    self.lineView.frame=self.cellFrame.lineViewF;
    self.dianzanNumberLabel.frame=self.cellFrame.dianzanNumberF;
    
    self.dianzanBt.frame=self.cellFrame.dianzanLogoF;
}

-(void)setCellFrame:(DetailFansAndFocusCellFrame *)cellFrame{
    
    _cellFrame = cellFrame;
    
    [self removeOldPicturesAndReplys];
    
    [self settingtData];

    [self settingFrame];
}

//防止cell重叠
-(void)removeOldPicturesAndReplys
{
    for(int i = 0;i < [self.picturesView count];i++)
    {
        UIImageView *pictureView = [self.picturesView objectAtIndex:i];
        if (pictureView.superview) {
            [pictureView removeFromSuperview];
        }
    }
    for (int i = 0; i < [self.replysView count]; i++) {
        UILabel *replyView = [self.replysView objectAtIndex:i];
        if (replyView.superview) {
            [replyView removeFromSuperview];
        }
    }
    [self.picturesView removeAllObjects];
    [self.replysView removeAllObjects];
}

-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    self.imageBlock(self.cellFrame.modelGroup.img_url,tap.view.tag);
}




//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//
//    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//
//        [self makeCellUI];
//    }
//
//    return self;
//
//}
//
//#pragma mark -界面布局
//-(void)makeCellUI{
//
//    //cell背景
//    _cellBgView=[[UIView alloc] init];
//    _cellBgView.backgroundColor=[UIColor whiteColor];
//    [self.contentView addSubview:_cellBgView];
//
//
//    //头像
//    _iconImageView=[[UIImageView alloc] init];
//    _iconImageView.backgroundColor=[UIColor clearColor];
//    _iconImageView.layer.cornerRadius=22/2;
//    _iconImageView.clipsToBounds=YES;
//    [_cellBgView addSubview:_iconImageView];
//
//    //昵称
//    _nameLabel=[[UILabel alloc ] init];
//    _nameLabel.text=@"跑券";
//    _nameLabel.textColor=BlackHexColor;
//    _nameLabel.font=[UIFont systemFontOfSize:15];
//    [_cellBgView addSubview:_nameLabel];
//
//    //是否为官方标识
//    _button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setBackgroundColor:[UIColor clearColor]];
//     [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
//    [_cellBgView addSubview:_button];
//
//    //地图标识
//    _mapImageView=[[UIImageView alloc] init];
//    _mapImageView.backgroundColor=[UIColor clearColor];
//    _mapImageView.image=[UIImage imageWithoriginName:@"gray_map_Image"];
//    [_cellBgView addSubview:_mapImageView];
//
//    //发布城市
//    _cityLabel=[[UILabel alloc ] init];
//    _cityLabel.text=@"深圳";
//    _cityLabel.textColor=[UIColor lightGrayColor];
//    _cityLabel.font=[UIFont systemFontOfSize:9];
//    [_cellBgView addSubview:_cityLabel];
//
//    //竖线
//    _lineView=[[UIView alloc] init];
//    _lineView.backgroundColor=[UIColor lightGrayColor];
//    [_cellBgView addSubview:_lineView];
//
//    //发布时间
//    _timeLabel=[[UILabel alloc ] init];
//    _timeLabel.text=@"10小时前";
//    _timeLabel.textColor=[UIColor lightGrayColor];
//    _timeLabel.font=[UIFont systemFontOfSize:9];
//    [_cellBgView addSubview:_timeLabel];
//
//    //动态内容
//    _contentLable=[[UILabel alloc] init];
//    _contentLable.textColor=BlackHexColor;
//    _contentLable.font=[UIFont systemFontOfSize:14];
//    _contentLable.numberOfLines=0;
//    [_cellBgView addSubview:_contentLable];
//
//
//
//
//
//    //评论显示背景图
//    _bgCommentView=[[UIView alloc] init];
//    _bgCommentView.backgroundColor=[UIColor lightGrayColor];
//    [_cellBgView addSubview:_bgCommentView];
//
//    //评论内容
//    _commentLabel=[[UILabel alloc] init];
//    _commentLabel.text=@"sdk";
//    _commentLabel.textColor=[UIColor whiteColor];
//    _commentLabel.font=[UIFont systemFontOfSize:15];
//    [_bgCommentView addSubview:_commentLabel];
//
//
//
//
//    //点赞图标
//    _dianzanBt =[UIButton buttonWithType:UIButtonTypeCustom];
//    _dianzanBt.backgroundColor=[UIColor whiteColor];
//    _dianzanBt.tag=1000;
//
//    if (self.is_nice==2) {
//
//        _dianzanBt.enabled=YES;
//
//    }else{
//
//        _dianzanBt.enabled=NO;
//    }
//
//     [_dianzanBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_cellBgView addSubview:_dianzanBt];
//
//
//    //点赞人数
//    _dianzanNumber=[[UILabel alloc] init];
//    _dianzanNumber.text=@"1687";
//    _dianzanNumber.textColor=[UIColor lightGrayColor];
//    _dianzanNumber.font=[UIFont systemFontOfSize:12];
//    [_cellBgView addSubview:_dianzanNumber];
//
//    //点赞区域竖线
//    _lineV=[[UIView alloc] init];
//    _lineV.backgroundColor=[UIColor lightGrayColor];
//    [_cellBgView addSubview:_lineV];
//
//    //评论图标
//    _pinglunBt =[UIButton buttonWithType:UIButtonTypeCustom];
//    _pinglunBt.backgroundColor=[UIColor whiteColor];
//    [_pinglunBt setBackgroundImage:[UIImage imageNamed:@"pinglun_Image"] forState:UIControlStateNormal];
//    _pinglunBt.tag=1001;
//    [_pinglunBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    [_cellBgView addSubview:_pinglunBt];
//
//
//    //评论人数
//    _pinglunNumber=[[UILabel alloc] init];
//    _pinglunNumber.text=@"350";
//    _pinglunNumber.textColor=[UIColor lightGrayColor];
//    _pinglunNumber.font=[UIFont systemFontOfSize:12];
//    [_cellBgView addSubview:_pinglunNumber];
//
//
//}
//
//#pragma mark -点赞、评论按钮点击响应事件
//-(void)buttonClick:(UIButton*)btn{
//
//    if (btn.tag==1001) {
//
//
//
//    }else{
//
//        [btn setBackgroundImage:[UIImage imageNamed:@"yidianzan_Image"] forState:UIControlStateNormal];
//
//            _dianzanNumber.text=[NSString stringWithFormat:@"%ld",_dianzanNum+1];
//
//         //点赞接口
//        [self getDianZanHttpData];
//
//
//    }
//
//}
//
//
//
//

//
////cell赋值操作
//- (void)fillCellWithModel:(DetailArrayModel*)model indexPath:(NSIndexPath *)path{
//
//    if ([model.flag integerValue]==3) {
//
//        [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
//
//
//    }else if ([model.flag integerValue]==2){
//
//        [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_man_Image"] forState:UIControlStateNormal];
//
//    }else{
//
//        [_button setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_women_Image"] forState:UIControlStateNormal];
//
//    }
//
//
//
//   self.is_nice=[model.is_nice integerValue];
//
//    if ([model.is_nice integerValue]==2) {
//
//        [_dianzanBt setBackgroundImage:[UIImage imageNamed:@"yidianzan_Image"] forState:UIControlStateNormal];
//
//    }else{
//
//
//
//        [_dianzanBt setBackgroundImage:[UIImage imageNamed:@"dianzan_Image"] forState:UIControlStateNormal];
//
//    }
//
//    _cityLabel.text=model.addres;
//
//    _timeLabel.text=model.time;
//
//
//    _dianzanNum=[model.nice_num integerValue];
//
//    _dianzanNumber.text=[NSString stringWithFormat:@"%@",model.nice_num];
//
//    _pinglunNumber.text=[NSString stringWithFormat:@"%@",model.comment_num];
//
//    self.record_id=model.record_id;
//
//    self.subject_catename=model.subject_catename;
//
//    _commentLabel.text=[NSString stringWithFormat:@"%@:%@",model.comment_user,model.comment_content];
//
//
//}
//
//
//#pragma mark - 填充数据
//-(void)setIndexPath:(NSIndexPath *)indexPath{
//
//    _indexPath=indexPath;
//}
//
//
////发布图片显示数组
//-(void)setDataArray:(NSArray *)dataArray{
//
//    _dataArray=dataArray;
//
//
//}
//
//-(void)setContentArray:(NSArray *)contentArray{
//
//
//    //发布内容
//     _labelStr=contentArray[0];
//  NSMutableParagraphStyle*paragraphStyle=[[NSMutableParagraphStyle alloc] init];
//    // 行间距设置为5
//    [paragraphStyle setLineSpacing:5]; NSMutableAttributedString*setString=[[NSMutableAttributedString alloc] initWithString:_labelStr];
//
//    [setString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_labelStr length])];
//
//    [_contentLable setAttributedText:setString];
//
//
//}
//
//
////计算label自适应高度
//-(CGFloat)getLabelCellHeight{
//
//    CGFloat contentHight=[_labelStr boundingRectWithSize:CGSizeMake(KscreenW-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
//
//    return contentHight;
//
//}
//
//
//#pragma mark -位置坐标
//-(void)layoutSubviews{
//
//    [_cellBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(-12);
//    }];
//
//    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.size.mas_equalTo(CGSizeMake(22, 22));
//        make.left.mas_equalTo(18);
//        make.top.mas_equalTo(19);
//    }];
//
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(self.iconImageView);
//        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
//    }];
//
//
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(20);
//        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
//
//    }];
//
//
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.mas_equalTo(-15);
//        make.centerY.mas_equalTo(self.nameLabel);
//
//    }];
//
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.timeLabel.mas_left).offset(-7);
//
//        make.width.mas_equalTo(1);
//        make.height.mas_equalTo(self.timeLabel.mas_height);
//        make.centerY.mas_equalTo(self.timeLabel);
//
//    }];
//
//    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.mas_equalTo(self.lineView.mas_left).offset(-7);
//        make.centerY.mas_equalTo(self.timeLabel);
//
//
//    }];
//
//    [_mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(self.nameLabel);
//        make.right.mas_equalTo(self.cityLabel.mas_left).offset(-6);
//        make.size.mas_equalTo(CGSizeMake(6, 7));
//    }];
//
//
//    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(17);
//    }];
//
//
//
//    [_bgCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(self.dianzanBt.mas_top).offset(-16);
//        make.height.mas_equalTo(30);
//
//
//    }];
//
//
//    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(_bgCommentView);
//        make.left.mas_equalTo(20);
//    }];
//
//
//    [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.bottom.mas_equalTo(-13);
//        make.width.mas_equalTo(1);
//        make.height.mas_equalTo(self.dianzanBt.mas_height);
//    }];
//
//    [_dianzanNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.mas_equalTo(self.lineV.mas_left).offset(-80);
//        make.centerY.mas_equalTo(self.lineV);
//
//    }];
//
//
//    [_dianzanBt mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(self.dianzanNumber);
//        make.right.mas_equalTo(self.dianzanNumber.mas_left).offset(-15);
//
//    }];
//
//
//    [_pinglunBt mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(self.lineV.mas_right).offset(80);
//        make.centerY.mas_equalTo(self.dianzanBt);
//    }];
//
//    [_pinglunNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(self.pinglunBt);
//        make.left.mas_equalTo(self.pinglunBt.mas_right).offset(20);
//    }];
//
//
//}
//
//
//#pragma mark -点赞接口
//-(void)getDianZanHttpData{
//
//    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
//
//    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
//
//    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
//
//    DianZanParam*params=[[DianZanParam alloc] init];
//
//    params.api_token=api_tokenStr;
//
//    params.member_id=member_idStr;
//
//    params.record_id=self.record_id;
//
//    params.subject_catename=self.subject_catename;
//
//    [DianZanHttp httpDianZan:params success:^(id responseObject) {
//
//        NSLog(@"点赞返回的数据显示%@",responseObject);
//
//
//    } failure:^(NSError *error) {
//
//        NSLog(@"点赞数据获取失败");
//
//
//
//    }];
//
//
//}




@end
