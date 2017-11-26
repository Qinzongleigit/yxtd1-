//
//  FindTwoCell.m
//  yxtd
//
//  Created by qin on 2017/9/28.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FindTwoCell.h"

@interface FindTwoCell ()

@property (nonatomic,strong) UIImageView*mainImageView;

@property (nonatomic,strong) UILabel*miaosulabel;

@property (nonatomic,strong) UIImageView*iconImageView;

@property (nonatomic,strong) UILabel*namelabel;

@property (nonatomic,strong) UIButton*dianzanBt;

@property (nonatomic,strong) UILabel*dianzanlabe;


@end

@implementation FindTwoCell


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"FindTwoCell";
    
    FindTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        
        [self createCell];
    }
    return self;
}

//布局
-(void)createCell{
    //主图
    _mainImageView=[[UIImageView alloc] init];
    _mainImageView.layer.cornerRadius=5;
    _mainImageView.clipsToBounds=YES;
    _mainImageView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:_mainImageView];
    
    
    _miaosulabel=[[UILabel alloc] init];
    _miaosulabel.text=@"会当临绝顶，一览众山小";
    _miaosulabel.font=[UIFont systemFontOfSize:12];
    _miaosulabel.textColor=BlackHexColor;
    [self.contentView addSubview:_miaosulabel];
    
    
    _iconImageView=[[UIImageView alloc] init];
    _iconImageView.backgroundColor=[UIColor purpleColor];
    _iconImageView.layer.cornerRadius=19/2;
    _iconImageView.clipsToBounds=YES;
    [self.contentView addSubview:_iconImageView];
    
    
    _namelabel=[[UILabel alloc] init];
    _namelabel.text=@"Vulcon";
    _namelabel.font=[UIFont systemFontOfSize:12];
    _namelabel.textColor=BlackHexColor;
    _namelabel.alpha=0.5f;
    [self.contentView addSubview:_namelabel];
    
    
    _dianzanBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [_dianzanBt setImage:[UIImage imageWithoriginName:@"dianzan_Image"] forState:UIControlStateNormal];
    [_dianzanBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    [_dianzanBt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_dianzanBt];
    
    
    _dianzanlabe=[[UILabel alloc] init];
    _dianzanlabe.text=@"1.3K";
    _dianzanlabe.textColor=BlackHexColor;
    _dianzanlabe.alpha=0.5f;
   
    _dianzanlabe.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_dianzanlabe];
    
    
    
    
}

//位置坐标
-(void)layoutSubviews{
    
    __weak typeof(self) weakSelf=self;
    
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf).with.offset(11);
        make.left.equalTo(weakSelf).with.offset(25);
        make.right.equalTo(weakSelf).with.offset(-25);
        make.height.equalTo(@133);
    }];
    
    [_miaosulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_mainImageView.mas_bottom).with.offset(11);
        make.centerX.equalTo(_mainImageView);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(_miaosulabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImageView.mas_right).with.offset(6);
        make.centerY.equalTo(_iconImageView);
    }];
    
    [_dianzanlabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).with.offset(-30);
        make.centerY.equalTo(_iconImageView);
       
        
    }];
    
    [_dianzanBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_dianzanlabe.mas_left).with.offset(-7);
        make.centerY.equalTo(_iconImageView);
        make.size.mas_equalTo(CGSizeMake(10, 12));
    }];
    
}



-(void)btClick:(UIButton*)bt{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"点赞提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
    
}

@end
