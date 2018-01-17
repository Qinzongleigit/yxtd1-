//
//  CLTRoundView.m
//  yxtd
//
//  Created by qin on 2017/9/29.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "CLTRoundView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
static CGFloat  lineWidth = 20;   // 线宽


@interface CLTRoundView ()

@property (nonatomic,strong) CAShapeLayer *bottomShapeLayer; // 圆的底层layer

@property (nonatomic,strong)CAShapeLayer *upperShapeLayer;  //圆的更新的layer

@property (nonatomic,strong)CAGradientLayer *gradientLayer;  // 圆的颜色渐变layer

@property (nonatomic,strong) CAShapeLayer *progressLayer;  // 小的进度progressLayer


@property (nonatomic,assign)CGFloat startAngle;  // 开始的弧度
@property (nonatomic,assign)CGFloat endAngle;  // 结束的弧度
@property (nonatomic,assign)CGFloat radius; // 开始角度

@property (nonatomic,assign)CGFloat centerX;  // 中心点 x

@property (nonatomic,assign)CGFloat centerY;  // 中心点 y

@property (nonatomic,strong)UILabel *stepLabel;  //  进度

@property (nonatomic,strong)UILabel *progressLabel;  // 今日步数

@property (nonatomic,strong)UILabel *purposeLabel;  // 今日目标

@property (nonatomic,strong)UILabel *rankingLabel;



@property (nonatomic,assign) NSInteger ratio;  // 记录步数变化 用于数字跳动


@end

@implementation CLTRoundView


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self  drawLayers];
        
    }
    
    return self;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        [self drawLayers];
        
    }
    return self;
}


- (void)drawLayers
{
    self.backgroundColor = [UIColor whiteColor];
    
    
    _startAngle = - 220;  // 启始角度
    _endAngle = 45;  // 结束角度
    
    _centerX = self.frame.size.width / 2;  // 控制圆盘的X轴坐标
    _centerY = self.frame.size.height / 2  + 20; // 控制圆盘的Y轴坐标
    
   // _radius = (self.bounds.size.width - 100 - lineWidth) / 2;  // 圆的半径
    _radius=108;

    [self drawBottomLayer];  // 绘制底部灰色填充layer
    [self drawUpperLayer]; // 绘制底部进度显示 layer
    [self drawGradientLayer];  // 绘制颜色渐变 layer
    
    [_bottomShapeLayer addSublayer:_gradientLayer]; // 将进度渐变layer 添加到 底部layer 上
    
    [_gradientLayer setMask:_upperShapeLayer]; // 设置进度layer 颜色 渐变
    
    [self.layer addSublayer:_bottomShapeLayer];  // 添加到底层的layer 上
    

    [self addSubview:self.stepLabel];
    
    [self addSubview:self.progressLabel];
    
    [self addSubview:self.purposeLabel];
    
    [self addSubview:self.rankingLabel];
    
    [self addSubview:self.purposeBt];
    
    [_purposeBt mas_makeConstraints:^(MASConstraintMaker *make) {

      make.left.equalTo(_purposeLabel.mas_right).with.offset(5);
       make.centerY.equalTo(_purposeLabel);
    }];



}


#pragma mark Label位置显示

-(UILabel*)progressLabel{
    
    
    if (!_progressLabel) {
        
        _progressLabel = [[UILabel alloc]init];
        CGFloat width = 160;
        CGFloat height = 40;
       _progressLabel.frame = CGRectMake((self.frame.size.width - width) / 2, _centerY - height / 2-50, width, height);
        _progressLabel.font = [UIFont systemFontOfSize:20];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = [UIColor colorWithHexString:@"#313a3f" alpha:0.5];
        _progressLabel.font=[UIFont systemFontOfSize:15];
        _progressLabel.text = @"今日步数";

    }
    
    return _progressLabel;
    
}


- (UILabel *)stepLabel
{
    if (!_stepLabel) {
        
        _stepLabel = [[UILabel alloc]init];
        
        CGFloat width = 160;
        CGFloat height = 60;
        _stepLabel.frame = CGRectMake((self.frame.size.width - width) / 2, _centerY - height / 2, width, height);
        _stepLabel.font = [UIFont boldSystemFontOfSize:30];
        _stepLabel.textAlignment = NSTextAlignmentCenter;
        _stepLabel.text = @"0";
    }
    
    return _stepLabel;
}


- (UILabel *)purposeLabel
{
    if (!_purposeLabel) {
        
        _purposeLabel = [[UILabel alloc]init];

        CGFloat width = 80;
        CGFloat height = 30;
        _purposeLabel.frame = CGRectMake((self.frame.size.width - width) / 2-30, _centerY +20, width, height);
        _purposeLabel.font = [UIFont systemFontOfSize:16];
        _purposeLabel.textAlignment = NSTextAlignmentCenter;
        _purposeLabel.textColor = [UIColor lightGrayColor];
        _purposeLabel.text = @"今日目标";
        
    }
    
    return _purposeLabel;
}

-(UIButton*)purposeBt{
    
    
    if (!_purposeBt) {
       _purposeBt=[UIButton buttonWithType:UIButtonTypeCustom];
        [_purposeBt setTitle:@"10000" forState:UIControlStateNormal];
        [_purposeBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _purposeBt.titleLabel.font=[UIFont systemFontOfSize:16];
        [_purposeBt addTarget:self action:@selector(purposeBt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _purposeBt;
}

#pragma mark -目标按钮点击
-(void)purposeBt:(UIButton*)Bt{
    
 
    self.purposeBtClick();
  
}


-(UILabel*)rankingLabel{
    
    if (_rankingLabel==nil) {
        
        CGFloat width = 140;

        CGFloat height = 26;
        
        _rankingLabel=[[UILabel alloc] init];
        _rankingLabel.frame=CGRectMake((self.frame.size.width - width) / 2-5, _centerY +60, width, height);
        _rankingLabel.layer.borderWidth = 0.5;
        _rankingLabel.textColor=BlackHexColor;
        _rankingLabel.text=@"第 3 名";
        _rankingLabel.textAlignment=NSTextAlignmentCenter;
        _rankingLabel.font=[UIFont systemFontOfSize:12];
        _rankingLabel.layer.borderColor = [[UIColor colorWithRed:49.0f/255.0f green:58.0f/255.0f blue:63.0f/255.0f alpha:1.0f] CGColor];
        _rankingLabel.layer.cornerRadius = 12;
  
        [self addSubview:_rankingLabel];
        
    }
    return _rankingLabel;
}

#pragma mark - 绘制圆底部的layer
- (CAShapeLayer *)drawBottomLayer
{
    _bottomShapeLayer = [[CAShapeLayer alloc] init];
    _bottomShapeLayer.frame= self.bounds;
    
    UIBezierPath *path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY) radius:_radius startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle) clockwise:YES];
    
    
    _bottomShapeLayer.path= path.CGPath;
    _bottomShapeLayer.lineCap = kCALineCapButt;
   _bottomShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:5], nil];
    
    //线的高度
    
    _bottomShapeLayer.lineWidth = lineWidth;
   
    _bottomShapeLayer.strokeColor= [UIColor grayColor].CGColor;
    _bottomShapeLayer.fillColor= [UIColor clearColor].CGColor;
    return _bottomShapeLayer;
}


#pragma mark -绘制进度的layer
- (CAShapeLayer *)drawUpperLayer
{
    _upperShapeLayer= [[CAShapeLayer alloc] init];
    _upperShapeLayer.frame= self.bounds;
    
    UIBezierPath *path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY) radius:_radius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle) clockwise:YES];
   //就是这句话在关联彼此
    _upperShapeLayer.path= path.CGPath;
    _upperShapeLayer.strokeStart = 0;
    _upperShapeLayer.strokeEnd =0;
    
    // lineWidth 设置虚线的宽度
    _upperShapeLayer.lineWidth = lineWidth;
    
    //lineCap 线帽样式
    _upperShapeLayer.lineCap = kCALineCapButt;
    //lineDashPattern 线段分割模式 5=线的宽度 10=每条线的间距
    _upperShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:5], nil];
    //strokeColor //设置边框颜色
    _upperShapeLayer.strokeColor= [UIColor redColor].CGColor;
    //fillColor 文本填充色
    _upperShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    
    return _upperShapeLayer;
}
#pragma mark 绘制圆进度渐变色的layer
- (CAGradientLayer *)drawGradientLayer
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY) radius:_radius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle) clockwise:YES];
    
    //设置进度渐变的颜色组成
//    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor purpleColor].CGColor,(id)[UIColor redColor].CGColor, nil];
    
    //两个颜色一样不会发生颜色渐变的效果
     NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor greenColor].CGColor, nil];
    
    // CAGradientLayer 圆的颜色渐变layer
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.shadowPath = path.CGPath;
    _gradientLayer.frame = self.bounds;
    _gradientLayer.startPoint = CGPointMake(0, 1);
    _gradientLayer.endPoint = CGPointMake(1, 0);
    [_gradientLayer setColors:colors];
    
    return _gradientLayer;
}


#pragma mark 显示进度百分比
@synthesize  percent = _percent;

- (CGFloat )percent
{
    return _percent;
}
- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    
    
    if (percent > 1) {
        percent = 1;
    }else if (percent < 0){
        percent = 0;
    }
    
     NSString*stepStr=[NSString stringWithFormat:@"%f",percent];

      self.ratio = [stepStr floatValue]*[self.purposeBt.titleLabel.text integerValue] ;

    
    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0];
    
}


//更新Label 和虚线的进度
- (void)shapeChange
{
    
    // 复原
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    _upperShapeLayer.strokeEnd = 0 ;
    _progressLayer.strokeEnd = 0 ;
    
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:2.f];
    _upperShapeLayer.strokeEnd = _percent;;
    _progressLayer.strokeEnd = _percent;;
    [CATransaction commit];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_percent * 0.002 target:self selector:@selector(updateLabl:) userInfo:nil repeats:YES];
    
    // 将定时器放在主运行循环
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)updateLabl:(NSTimer *)sender
{
    static int flag = 0;
    
    if (flag   == self.ratio) {
  
        [sender invalidate];
        sender = nil;
        
        self.stepLabel.text = [NSString stringWithFormat:@"%d",flag];
        
        flag = 0;
  
        
    }
    else
    {
        self.stepLabel.text = [NSString stringWithFormat:@"%d",flag];
        
    }
    
    flag ++;
    
 
}





@end
