//
//  JSQuanShowView.m
//  yxtd
//
//  Created by qin on 2017/10/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JSQuanShowView.h"
#import "StarView.h"

@implementation JSQuanShowView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       [self setUpView];
  
    }
    return self;
}

-(void)setUpView{
    
    _bgImageView=[[UIImageView alloc] init];
    _bgImageView.backgroundColor=[UIColor grayColor];
    _bgImageView.userInteractionEnabled=YES;
    [self addSubview:_bgImageView];
    
    
    _brandImageView=[[UIImageView alloc] init];
    _brandImageView.backgroundColor=[UIColor purpleColor];
    _brandImageView.layer.cornerRadius=59/2;
    _brandImageView.clipsToBounds=YES;
    [self addSubview:_brandImageView];
    
    _brandNameLabel=[[UILabel alloc] init];
    _brandNameLabel.text=@"STATERFELL";
    _brandNameLabel.textColor=[UIColor whiteColor];
    _brandNameLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:_brandNameLabel];
    
    _hotImageView=[[UIImageView alloc] init];
    _hotImageView.image=[UIImage imageNamed:@"hot_Image"];
    [self addSubview:_hotImageView];
    
    _namelabel=[[UILabel alloc] init];
    _namelabel.textColor=[UIColor whiteColor];
    _namelabel.text=@"10元现金券";
    _namelabel.font=[UIFont systemFontOfSize:18];
    [self addSubview:_namelabel];
    
    _lineView=[[UIView alloc] init];
    _lineView.backgroundColor=btnLineColor;
    [self addSubview:_lineView];
    
    
    _dateLabel=[[UILabel alloc] init];
    _dateLabel.text=@"有效期：2017-09-15  00：00  至\n 2017-10-09   23：59";
    _dateLabel.textColor=[UIColor whiteColor];
    _dateLabel.font=[UIFont systemFontOfSize:10];
    _dateLabel.numberOfLines=0;
    [self addSubview:_dateLabel];
    
    
    
    _starBgView=[[UIView alloc] init];
    _starBgView.backgroundColor=[UIColor clearColor];
    [self addSubview:_starBgView];
    
    
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoDetailView)];
    tap.numberOfTapsRequired = 1;
    [_bgImageView addGestureRecognizer:tap];
    
   
    
}

//星星评分
-(void)setStatNum:(float)statNum{

    StarView*starVC=[[StarView alloc] initWithFrame:CGRectMake(0, 0, 54, 10) withFloatNum:statNum];
    [_starBgView addSubview:starVC];


}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    __weak typeof(self) weakSelf=self;
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(28);
        make.top.equalTo(weakSelf).with.offset(17);
        make.size.mas_equalTo(CGSizeMake(59, 59));
    }];
    
    
    [_brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_brandImageView);
        make.top.equalTo(_brandImageView.mas_bottom).with.offset(12);
    }];
    
    [_hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf).with.offset(7);
        make.right.equalTo(weakSelf).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(23, 13));
        
    }];
    
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf).with.offset(-22);
        make.top.equalTo(_hotImageView.mas_bottom).with.offset(12);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_brandImageView.mas_right).with.offset(33);
        make.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(_namelabel.mas_bottom).with.offset(7);
        make.height.equalTo(@1);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_brandImageView.mas_right).with.offset(41);
        make.right.equalTo(weakSelf).with.offset(-35);
        make.top.equalTo(_lineView.mas_bottom).with.offset(7);
    }];
    
    [_starBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf).with.offset(-5);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(54, 10));
    }];
}






//        self.label_address = [[UILabel alloc]init];
//        self.label_address.text = @"南大苏富特科技创意园";
//        self.label_address.font = [UIFont systemFontOfSize:14];
//        self.label_address.textColor = blackkColor;
//        //        self.label_address.backgroundColor = ZXNRandom;
//        [self addSubview:self.label_address];
//        [self.label_address mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@16);
//            make.top.equalTo(@16);
//            make.right.equalTo(@-16);
//            make.height.equalTo(@16);
//        }];
//
//
//        UIView *view_line = [[UIView alloc]init];
//        view_line.backgroundColor = lightTextColor;
//        [self addSubview:view_line];
//        [view_line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@0);
//            make.top.equalTo(self.label_address.mas_bottom).offset(16);
//            make.right.equalTo(@0);
//            make.height.equalTo(@1);
//        }];
//
//        //距离
//        self.label_distance = [[UILabel alloc]init];
//
//        self.label_distance.text = @"48米";
//        self.label_distance.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.label_distance];
//        [self.label_distance mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@0);
//            make.top.equalTo(view_line.mas_bottom).offset(10);
//            make.right.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        UILabel *distance = [[UILabel alloc]init];
//        //        distance.backgroundColor = ZXNRandom;
//        distance.text = @"距离起始位置";
//        distance.textColor = textLightColor;
//        distance.font = [UIFont systemFontOfSize:14];
//        distance.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:distance];
//        [distance mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@0);
//            make.top.equalTo(self.label_distance.mas_bottom).offset(10);
//            make.right.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        //时间
//        self.label_minutes = [[UILabel alloc]init];
//
//        self.label_minutes.text = @"1分钟";
//        self.label_minutes.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.label_minutes];
//        [self.label_minutes mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@0);
//            make.top.equalTo(view_line.mas_bottom).offset(10);
//            make.left.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        UILabel *minutes = [[UILabel alloc]init];
//        minutes.text = @"距离起始位置";
//        minutes.textColor = textLightColor;
//        minutes.font = [UIFont systemFontOfSize:14];
//        minutes.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:minutes];
//        [minutes mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@0);
//            make.top.equalTo(self.label_minutes.mas_bottom).offset(10);
//            make.left.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        //导航
//        UIButton *button = [[UIButton alloc]init];
//        button.backgroundColor = naviColor;
//        button.layer.cornerRadius = 5;
//        button.layer.masksToBounds = YES;
//        [button setTitle:@"导航" forState:0];
//        [button addTarget:self action:@selector(gotoPlace) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@-16);
//            make.top.equalTo(minutes.mas_bottom).offset(10);
//            make.left.equalTo(@16);
//            make.height.equalTo(@40);
//        }];
//
//        //可借
//        self.label_availTotal = [[UILabel alloc]init];
//        //        self.label_availTotal.backgroundColor = ZXNRandom;
//        self.label_availTotal.text = @"20个";
//        self.label_availTotal.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.label_availTotal];
//        [self.label_availTotal mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@0);
//            make.top.equalTo(button.mas_bottom).offset(10);
//            make.right.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        UILabel *availTotal = [[UILabel alloc]init];
//        //        availTotal.backgroundColor = ZXNRandom;
//        availTotal.text = @"可借数量";
//        availTotal.textColor = textLightColor;
//        availTotal.font = [UIFont systemFontOfSize:14];
//        availTotal.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:availTotal];
//        [availTotal mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@0);
//            make.top.equalTo(self.label_availTotal.mas_bottom).offset(10);
//            make.right.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        //可还
//        self.label_emptyTotal = [[UILabel alloc]init];
//        //        self.label_emptyTotal.backgroundColor = ZXNRandom;
//        self.label_emptyTotal.text = @"34个";
//        self.label_emptyTotal.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.label_emptyTotal];
//        [self.label_emptyTotal mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@0);
//            make.top.equalTo(button.mas_bottom).offset(10);
//            make.left.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//
//        UILabel *emptyTotal = [[UILabel alloc]init];
//        //        emptyTotal.backgroundColor = ZXNRandom;
//        emptyTotal.text = @"可还数量";
//        emptyTotal.textColor = textLightColor;
//        emptyTotal.font = [UIFont systemFontOfSize:14];
//        emptyTotal.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:emptyTotal];
//        [emptyTotal mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@0);
//            make.top.equalTo(self.label_emptyTotal.mas_bottom).offset(10);
//            make.left.equalTo(self.mas_centerX);
//            make.height.equalTo(@16);
//        }];
//    }
//    return self;
//}

- (void)gotoDetailView{
    
    self.gotoDetailVC();
}

@end
