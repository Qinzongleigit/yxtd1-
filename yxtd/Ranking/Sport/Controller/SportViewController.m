//
//  SportViewController.m
//  yxtd
//
//  Created by qin on 2017/9/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SportViewController.h"
#import "HYSwitch.h"

@interface SportViewController ()
{
        double _earthAngle;
    
        CGFloat _whitePathRadius;

}

@property (nonatomic,strong) UILabel*kmLabel;

@property (nonatomic,strong) UILabel*timeLabel;

@property (nonatomic,strong) UIView*radiusView;

@property (nonatomic,strong) UIView *roundBgV;

@property (nonatomic,strong) CAShapeLayer*smallPathLayer;

@property (nonatomic,strong) CAShapeLayer*pathLayer;

@property (nonatomic,strong) NSTimer *timer;


@property (nonatomic,strong) HYSwitch*switch1;
@property (nonatomic,strong) UIButton*startBt;
@property (nonatomic,strong) UIButton*myButton;


@property (nonatomic,strong) UIView*bgView;

@end

@implementation SportViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView*bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-84)];
    bgView.backgroundColor=[UIColor clearColor];
    self.bgView=bgView;
    [self.view addSubview:bgView];
    
    _earthAngle = -3.1415926;
    //画圆
    [self drawLayers];
    
    [self makeUI];
   
   
}

//画圆
-(void)drawLayers{

    _roundBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, SYRealValueHeight(306))];
    _roundBgV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_roundBgV];
    
    
    _radiusView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 236, 236)];
    _radiusView.center=self.roundBgV.center;
    _radiusView.backgroundColor=COLORWITHRGB(151, 239, 239);
    //加圆角
    _radiusView.layer.mask=[self cornerRadiusWithRect:_radiusView.bounds];
    [self.view addSubview:_radiusView];
    
    
    //内圆
    CGFloat _filletRadius=198;
    
    CAShapeLayer* _filletPathLayer=[[CAShapeLayer alloc] init];
    _filletPathLayer.frame=CGRectMake(0, 0, _filletRadius, _filletRadius);
    _filletPathLayer.position = CGPointMake(_radiusView.frame.size.width/2,_radiusView.frame.size.height/2);
    _filletPathLayer.anchorPoint = CGPointMake(0.5, 0.5);
    _filletPathLayer.backgroundColor = [UIColor clearColor].CGColor;
    _filletPathLayer.borderWidth = 14;
    _filletPathLayer.borderColor = COLORWITHRGB(0, 219, 220).CGColor;
    _filletPathLayer.backgroundColor=[UIColor whiteColor].CGColor;
    _filletPathLayer.cornerRadius = _filletRadius/2;
    [_radiusView.layer addSublayer:_filletPathLayer];
    
    
    //白色圆环
    _whitePathRadius=204;
    CAShapeLayer* _whitePathLayer=[[CAShapeLayer alloc] init];
    _whitePathLayer.frame=CGRectMake(0, 0, _whitePathRadius, _whitePathRadius);
    _whitePathLayer.position = CGPointMake(_radiusView.frame.size.width/2,_radiusView.frame.size.height/2);
    _whitePathLayer.anchorPoint = CGPointMake(0.5, 0.5);
    _whitePathLayer.backgroundColor = [UIColor clearColor].CGColor;
    _whitePathLayer.borderWidth = 3;
    _whitePathLayer.borderColor =[UIColor whiteColor].CGColor;
    _whitePathLayer.cornerRadius = _whitePathRadius/2;
    [_radiusView.layer addSublayer:_whitePathLayer];
    
    //小圆
    CGFloat _smallRadius=23;
    _smallPathLayer=[[CAShapeLayer alloc] init];
    
    _smallPathLayer.frame=CGRectMake(0, 0, _smallRadius, _smallRadius);
    _smallPathLayer.position = CGPointMake(_radiusView.frame.size.width/2-_whitePathRadius/2, _radiusView.frame.size.height/2);
    _smallPathLayer.anchorPoint = CGPointMake(0.5, 0.5);
    _smallPathLayer.backgroundColor = [UIColor clearColor].CGColor;
    _smallPathLayer.borderWidth = 3;
    _smallPathLayer.borderColor = [UIColor greenColor].CGColor;
    _smallPathLayer.backgroundColor=[UIColor whiteColor].CGColor;
    _smallPathLayer.cornerRadius = _smallRadius/2;
    [_radiusView.layer addSublayer:_smallPathLayer];
    
    //小圆圆环
    CGFloat _smallPathRadius=29;
    _pathLayer=[[CAShapeLayer alloc] init];
    
    _pathLayer.frame=CGRectMake(0, 0, _smallPathRadius, _smallPathRadius);
    _pathLayer.position = CGPointMake(_radiusView.frame.size.width/2-_whitePathRadius/2, _radiusView.frame.size.height/2);
    _pathLayer.anchorPoint = CGPointMake(0.5, 0.5);
    _pathLayer.backgroundColor = [UIColor clearColor].CGColor;
    _pathLayer.borderWidth = 5;
    _pathLayer.borderColor = [UIColor whiteColor].CGColor;
    _pathLayer.cornerRadius = _smallPathRadius/2;
    [_radiusView.layer addSublayer:_pathLayer];
    
    
    _kmLabel=[[UILabel alloc] init];
    _kmLabel.text=@"11.25";
    _kmLabel.font=[UIFont systemFontOfSize:53];
    _kmLabel.textColor=BlackHexColor;
    _kmLabel.textAlignment=NSTextAlignmentCenter;
    [_radiusView addSubview:self.kmLabel];
    [self.kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(_radiusView);
        
    }];
    
    
    UILabel*mLabel=[[UILabel alloc] init];
    mLabel.text=@"KM";
    mLabel.font=[UIFont systemFontOfSize:15];
    mLabel.textColor=BlackHexColor;
    mLabel.alpha=0.5;
    mLabel.textAlignment=NSTextAlignmentCenter;
    [_radiusView addSubview:mLabel];
    [mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_kmLabel);
        make.top.equalTo(_kmLabel.mas_bottom).with.offset(16);
    }];
    
    
    
}


#pragma mark-绕圆环运动
- (void)rotate
{
    _earthAngle = _earthAngle + 1 * 3.1415926 / 180;
    _smallPathLayer.position = CGPointMake(_radiusView.frame.size.width/2 + _whitePathRadius/2 * cos(_earthAngle), _radiusView.frame.size.height/2 + _whitePathRadius/2 * sin(_earthAngle));
    _pathLayer.position = _smallPathLayer.position;
    
}

#pragma mark -绘制背景圆
-(CAShapeLayer*)cornerRadiusWithRect:(CGRect)rect
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:rect.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = rect;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}

#pragma mark-圆尾部布局
-(void)makeUI{
    
    __weak typeof(_bgView) weakSelf=_bgView;
    
    UIView*lineBgH=[[UIView alloc] init];
    lineBgH.backgroundColor=btnLineColor;
    [self.bgView addSubview:lineBgH];
    
    [lineBgH mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.roundBgV.mas_bottom).with.offset(0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@70);
        
    }];
    
    NSMutableArray*labelArray=[NSMutableArray new];
    NSMutableArray*labelArray1=[NSMutableArray new];
    NSArray*titlelabeArr=@[@"14'32“",@"00:25:00",@"523"];
    NSArray*titlelabeArr1=@[@"配速",@"时间",@"消耗"];
    UILabel*lineLabel;
    for (int i=0; i<titlelabeArr.count; i++) {
        
        lineLabel=[UILabel new];
        lineLabel.backgroundColor=[UIColor whiteColor];
        lineLabel.text=titlelabeArr[i];
        lineLabel.textAlignment=NSTextAlignmentCenter;
        lineLabel.textColor=[UIColor blackColor];
        lineLabel.font=[UIFont systemFontOfSize:19];
        [lineBgH addSubview:lineLabel];
        [labelArray addObject:lineLabel];
        
        
        UILabel*lineLabel1=[UILabel new];
        lineLabel1.backgroundColor=[UIColor whiteColor];
        lineLabel1.text=titlelabeArr1[i];
        lineLabel1.textAlignment=NSTextAlignmentCenter;
        lineLabel1.font=[UIFont systemFontOfSize:12];
        lineLabel1.textColor=[UIColor blackColor];
        
        [lineBgH addSubview:lineLabel1];
        [labelArray1 addObject:lineLabel1];
    }
    //水平方向控件间隔固定等间隔
    [labelArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [labelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@1);
        make.height.equalTo(@40);
    }];
    
    [labelArray1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [labelArray1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineLabel.mas_bottom).with.offset(0);
        make.height.equalTo(@28);
    }];
    
    
    
    
//    UIView*lineH=[[UIView alloc] init];
//    lineH.backgroundColor=btnLineColor;
//    [self.bgView addSubview:lineH];
//    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).with.offset(0);
//        make.right.equalTo(weakSelf).with.offset(0);
//        make.height.mas_equalTo(@1);
//        make.top.equalTo(_roundBgV.mas_bottom).with.offset(0);
//
//    }];
//
//    UILabel*label=[[UILabel alloc] init];
//    label.text=@"配速";
//    label.font=[UIFont systemFontOfSize:12];
//    label.textColor=BlackHexColor;
//    [self.bgView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(weakSelf).with.offset(16);
//        make.top.equalTo(lineH.mas_bottom).with.offset(9);
//
//    }];
//
//
//    UIView*lineV=[[UIView alloc] init];
//    lineV.backgroundColor=btnLineColor;
//    [self.bgView addSubview:lineV];
//    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(lineH);
//         make.top.equalTo(lineH.mas_bottom).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(1, 70));
//    }];
//
//    UILabel*skLabel=[[UILabel alloc] init];
//    skLabel.text=@"14'22";
//    skLabel.font=[UIFont systemFontOfSize:25];
//    skLabel.textColor=BlackHexColor;
//    [self.bgView addSubview:skLabel];
//    [skLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(lineV.mas_left).with.offset(-38);
//        make.top.equalTo(lineH.mas_bottom).with.offset(16);
//
//    }];
//
//    UILabel*skLabel1=[[UILabel alloc] init];
//    skLabel1.text=@"分钟/公里";
//    skLabel1.font=[UIFont systemFontOfSize:12];
//    skLabel1.textColor=BlackHexColor;
//    [self.bgView addSubview:skLabel1];
//    [skLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerX.equalTo(skLabel);
//        make.top.equalTo(skLabel.mas_bottom).with.offset(8);
//
//    }];
//
//
//    UILabel*KLable=[[UILabel alloc] init];
//    KLable.text=@"热量";
//    KLable.font=[UIFont systemFontOfSize:12];
//    KLable.textColor=BlackHexColor;
//    [self.bgView addSubview:KLable];
//    [KLable mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(lineV.mas_right).with.offset(17);
//        make.top.equalTo(lineH).with.offset(9);
//
//    }];
//
//
//    UILabel*calorieLable=[[UILabel alloc] init];
//    calorieLable.text=@"20";
//    calorieLable.font=[UIFont systemFontOfSize:25];
//    calorieLable.textColor=BlackHexColor;
//
//
//    [self.bgView addSubview:calorieLable];
//    [calorieLable mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(lineV.mas_right).with.offset(77);
//        make.top.equalTo(lineH).with.offset(16);
//
//    }];
//
//    UILabel*KLable1=[[UILabel alloc] init];
//    KLable1.text=@"大卡";
//    KLable1.font=[UIFont systemFontOfSize:12];
//    KLable1.textColor=BlackHexColor;
//    [self.bgView addSubview:KLable1];
//    [KLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerX.equalTo(calorieLable);
//        make.top.equalTo(calorieLable.mas_bottom).with.offset(8);
//
//    }];
//
//
//    UIView*lineBottomH=[[UIView alloc] init];
//    lineBottomH.backgroundColor=btnLineColor;
//    [self.bgView addSubview:lineBottomH];
//    [lineBottomH mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).with.offset(0);
//        make.right.equalTo(weakSelf).with.offset(0);
//        make.height.mas_equalTo(@1);
//        make.top.equalTo(lineV.mas_bottom).with.offset(0);
//
//    }];
    
    
    UIButton*startBt=[UIButton buttonWithType:UIButtonTypeCustom];

    self.startBt=startBt;
    [startBt setTitle:@"开始" forState:UIControlStateNormal];
    [startBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBt.backgroundColor=COLORWITHRGB(0, 219, 220);
    startBt.layer.cornerRadius=43/2;
    startBt.layer.masksToBounds=YES;
    [startBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:startBt];
    
    [startBt mas_makeConstraints:^(MASConstraintMaker *make) {
        if (KscreenH<=FourInchHeight) {
            make.top.equalTo(lineBgH.mas_bottom).with.offset(18);

        }else{
            make.top.equalTo(lineBgH.mas_bottom).with.offset(37);
            
        }
        
        make.size.mas_equalTo(CGSizeMake(SYRealValueWidth(218),43));
      
        make.centerX.equalTo(weakSelf);
        
        
    }];
    
    
    UIView*bgHView=[[UIView alloc] init];
    bgHView.backgroundColor=COLORWITHRGB(244 , 245, 245);
    [self.bgView addSubview:bgHView];
    [bgHView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-15);
       make.bottom.equalTo(weakSelf).with.offset(-13);
  
        make.height.equalTo(@27);
    }];
    
    
    UIImageView*mapImage=[[UIImageView alloc] init];
    mapImage.image=[UIImage imageWithoriginName:@"map_Image"];
    [bgHView addSubview:mapImage];
    [mapImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bgHView).with.offset(20);
        make.top.equalTo(bgHView).with.offset(6);
        
    }];
    
    UILabel*mapLabel=[[UILabel alloc] init];
    mapLabel.text=@"显示地图";
    mapLabel.textColor=BlackHexColor;
    mapLabel.font=[UIFont systemFontOfSize:12];
    [bgHView addSubview:mapLabel];
    
    [mapLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(mapImage);
        make.left.equalTo(mapImage.mas_right).with.offset(10);
    }];

    UIView*hyView=[[UIView alloc] init];
    hyView.backgroundColor=[UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
    hyView.layer.cornerRadius=16/2;
    hyView.clipsToBounds=YES;
    [bgHView addSubview:hyView];
    [hyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(bgHView).with.offset(-9);
        make.centerY.equalTo(bgHView);
        make.size.mas_equalTo(CGSizeMake(38, 16));
        
    }];
    
    
    
    HYSwitch*switch1=[[HYSwitch alloc] init];
    self.switch1=switch1;
    switch1.offColor = [UIColor whiteColor];
    switch1.buttonColor = [UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
    [hyView addSubview:switch1];

    [switch1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(hyView).with.offset(1);
        make.centerY.equalTo(bgHView);
        make.size.mas_equalTo(CGSizeMake(36, 14));
    }];
    
    switch1.action = ^(BOOL isOn) {
           //关
        if (isOn==0) {
            
            self.switch1.buttonColor = [UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
             hyView.backgroundColor=[UIColor colorWithRed:0/255.0 green:219/255.0 blue:220/255.0 alpha:1.0];
            //开
        }else{
            self.switch1.buttonColor = [UIColor blackColor];
             self.switch1.onColor = [UIColor whiteColor];
            hyView.backgroundColor=[UIColor blackColor];
            
        }
    };
    

}



-(void)buttonClick:(UIButton*)bt{
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //隐藏按钮
        self.startBt.backgroundColor =[UIColor whiteColor];
        self.startBt.layer.borderWidth = 2;
        self.startBt.layer.borderColor = COLORWITHRGB(0, 219, 220).CGColor;

    } completion:^(BOOL finished) {

        //开启定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(rotate) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        

        self.startBt.hidden = YES;

        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0,0 , 43, 43);
        button.layer.cornerRadius=43/2;
        button.clipsToBounds=YES;
        button.center=self.startBt.center;
        [button setImage:[UIImage imageNamed:@"run_Image"] forState:UIControlStateNormal];
        self.myButton=button;
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

    }];

    //缩小动画
    [self scaleLayerAnimtaion];
    
}


//放大动画
-(void)buttonClick{
    
    [_timer invalidate];
    _timer = nil;
    
    
    self.myButton.hidden=YES;
    self.startBt.hidden = NO;
    self.startBt.backgroundColor =COLORWITHRGB(0, 219, 220);
    self.startBt.layer.borderWidth = 0;
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.duration = 0.5;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SYRealValueWidth(218), 43)];
    
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.startBt.layer addAnimation:anima forKey:nil];
    
}

//缩放动画
- (void)scaleLayerAnimtaion {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anima.duration = 0.5;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 43, 43)];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.startBt.layer addAnimation:anima forKey:nil];
}


@end
