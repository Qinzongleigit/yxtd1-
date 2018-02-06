//
//  SearchUserTableViewCell.m
//  yxtd
//
//  Created by qin on 2018/2/4.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "SearchUserTableViewCell.h"
#import "MyFocusHttp.h"
#import "MyFocusParam.h"
#import "CancleMyFocusHttp.h"

@interface SearchUserTableViewCell ()


@property (nonatomic,strong) UIImageView*iconImage;

@property (nonatomic,strong) UILabel*nickNameLabel;

@property (nonatomic,strong) UIButton*sexBtImage;

@property (nonatomic,strong) UIButton*foucsButton;

@property (nonatomic,assign) NSIndexPath*row;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) BOOL isFocus;

@property (nonatomic,strong) NSString*user_id;

@property (nonatomic,strong) NSString*is_admin;



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
    _foucsButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [_foucsButton addTarget:self action:@selector(focusbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_foucsButton];
    
    self.isFocus=NO;
    
}

//赋值操作
-(void)fillCellWithModel:(DataModel *)model indexPath:(NSIndexPath *)path{
    
    self.row=path;
    
    self.user_id=model.user_id;
    
    self.is_admin=model.flag;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.avatar]]];
    _nickNameLabel.text=model.nickname;
    
    if ([model.flag integerValue]==3) {
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_Guanfang_Image"] forState:UIControlStateNormal];
        
        
    }else if ([model.flag integerValue]==2){
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_man_Image"] forState:UIControlStateNormal];
        
    }else{
        
        [_sexBtImage setBackgroundImage:[UIImage imageWithoriginName:@"guanzhu_women_Image"] forState:UIControlStateNormal];
        
    }
    
    self.index=[model.is_focus integerValue];
    
    if ([model.is_focus integerValue]==1) {
        
     
       [_foucsButton setImage:[UIImage imageNamed:@"yiguanzhu_Image"] forState:UIControlStateNormal];
       
        
        
    }else{
        
    [_foucsButton setImage:[UIImage imageNamed:@"guanzhu_Image"] forState:UIControlStateNormal];
        
       
        
    }
 
}


-(void)focusbuttonClick:(UIButton*)btn{

    self.isFocus=!self.isFocus;
    
    if (self.index==1) {


        if (self.isFocus) {

            [btn setImage:[UIImage imageNamed:@"guanzhu_Image"] forState:UIControlStateNormal];
            
            
               [self getCancelMyFocusHttpData];

        }else{

            [btn setImage:[UIImage imageNamed:@"yiguanzhu_Image"] forState:UIControlStateNormal];
            
              [self  getMyFocusHttpData];
            
         
            
            
        }

    }else{

        
        if (self.isFocus) {
            
            [btn setImage:[UIImage imageNamed:@"yiguanzhu_Image"] forState:UIControlStateNormal];
            
            [self  getMyFocusHttpData];

        }else{

            [btn setImage:[UIImage imageNamed:@"guanzhu_Image"] forState:UIControlStateNormal];
            
            [self getCancelMyFocusHttpData];
            
            
       }
        
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


#pragma mark -取消关注数据接口
-(void)getCancelMyFocusHttpData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MyFocusParam*params=[[MyFocusParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    params.member_id=member_idStr;
    
    params.user_id=self.user_id;
    
    params.is_admin=self.is_admin;
    
   [ CancleMyFocusHttp httpCancleMyFocus:params success:^(id responseObject) {
       
       NSLog(@"取消关注成功返回的数据=============:%@",responseObject);
        
    } failure:^(NSError *error) {
        
        NSLog(@"取消关注失败");
        
    }];
    
    
}



#pragma mark -添加关注数据接口
-(void)getMyFocusHttpData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MyFocusParam*params=[[MyFocusParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    params.member_id=member_idStr;
    
    params.user_id=self.user_id;
    
    params.is_admin=self.is_admin;
    
    
    [MyFocusHttp httpMyFocus:params success:^(id responseObject) {
        
        NSLog(@"关注成功返回的接口数据显示===========：%@",responseObject);
        
    } failure:^(NSError *error) {
       
        
        NSLog(@"关注失败");
    }];
    
    
}

@end
