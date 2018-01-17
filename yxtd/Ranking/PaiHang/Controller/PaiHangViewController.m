//
//  PaiHangViewController.m
//  yxtd
//
//  Created by qin on 2017/9/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "PaiHangViewController.h"
#import "CLTRoundView.h"
#import "PedometerManager.h"
#import "HQPickerView.h"

@interface PaiHangViewController ()<HQPickerViewDelegate>

@property (nonatomic,strong) CLTRoundView *roudView;

@property (nonatomic,strong) UILabel*distanceLabel;

@property (nonatomic,strong) UILabel*kmLabel;

@property (nonatomic,strong) UILabel*timeLabel1;

@property (nonatomic,strong) UIScrollView*scView;


@end

@implementation PaiHangViewController


-(CLTRoundView *)roudView
{
    if (!_roudView) {
        
        _roudView = [[CLTRoundView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 260)];
    }
    
    return _roudView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIScrollView *scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    
    scView.backgroundColor = [UIColor whiteColor];
    
    scView.showsVerticalScrollIndicator = NO;
    
    self.scView=scView;
    
    //设置可以滚动的范围，只能上下滚动
    scView.contentSize = CGSizeMake(0, KscreenH+150);
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    //将仪表盘添加到视图上
    [self.view addSubview:scView];
    
    [scView addSubview:self.roudView];
    
    ZXNWeakSelf(self)
    weakself.roudView.purposeBtClick = ^{
        
        [self pickerViewBt];
    };
    
    [self addLabelToView];
    
    [self getHealthStepData];

    
}

-(void)pickerViewBt{

    self.tabBarController.tabBar.hidden=YES;
    
    HQPickerView *picker = [[HQPickerView alloc]initWithFrame:self.view.bounds];
    picker.delegate = self ;
    picker.customArr = @[@"1000",@"5000",@"10000",@"20000",@"50000"];
    [self.view addSubview:picker];
    
    picker.tabHiddenBt = ^{
     
        self.tabBarController.tabBar.hidden=NO;
    };
}


- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text {
    
    [self.roudView.purposeBt setTitle:text forState:UIControlStateNormal];
}


#pragma mark  获取苹果手机步数和距离数据
-(void)getHealthStepData{
    
    if ([PedometerManager isStepCountingAvailable]) {
        [[PedometerManager shared]
         startPedometerUpdatesTodayWithHandler:^(PedometerData *pedometerData,
                                                 NSError *error) {
             if (!error) {
                
                 self.kmLabel.text = [NSString stringWithFormat:@"%.2fKM",([pedometerData.distance floatValue]/1000)];
                 
                  //步数
                self.roudView.percent=([pedometerData.numberOfSteps floatValue]/[self.roudView.purposeBt.titleLabel.text integerValue]);
                

             }
         }];
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"此设备不支持记步功能"
                                  message:@"仅支持iPhone5s及其以上设备"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
        
        [alertView show];
    }
    
//    HealthManager*manager=[HealthManager shareInstance];
//    [manager authorizeHealthKit:^(BOOL success, NSError *error) {
//        if (success) {
//
//              NSLog(@"success");
//
//            [manager getDistance:^(double value, NSError *error) {
//                NSLog(@"2count-->%.2f", value);
//                NSLog(@"2error-->%@", error.localizedDescription);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.kmLabel.text = [NSString stringWithFormat:@"%.2fKM",value];
//
//                });
//
//
//            }];
//            [manager  getRealTimeStepCountCompletionHandler:^(double value,double time, NSError *error) {
//
//                dispatch_sync(dispatch_get_main_queue(), ^{
//
//
//                    //步数
//                    self.roudView.percent=(value/[self.roudView.purposeBt.titleLabel.text integerValue]);
//
//                    //时间
//                    int h = time / 3600;
//                    int m = ((long)time % 3600)/60;
//                    self.timeLabel1.text=[NSString stringWithFormat:@"%@h %@m", @(h), @(m)];
//                }) ;
//
//            }];
//
//        }else{
//
//             NSLog(@"fail");
//        }
//
//    }];
    
}


#pragma mark 添加label
-(void)addLabelToView{

    __weak typeof(self.scView) weakSelf=self.scView;
    
    UILabel*distanceLabel=[[UILabel alloc] init];
    distanceLabel.text=@"累计距离";
    distanceLabel.textColor=[UIColor colorWithHexString:@"#313a3f" alpha:1];
    distanceLabel.font=[UIFont systemFontOfSize:12];
    self.distanceLabel=distanceLabel;
    [self.scView addSubview:distanceLabel];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(63);
        make.top.equalTo(self.roudView.mas_bottom).with.offset(5);
        
        
    }];
    
    
    UILabel*kmLabel=[[UILabel alloc] init];
    kmLabel.text=@"0.8KM";
    kmLabel.font=[UIFont boldSystemFontOfSize:15];
    self.kmLabel=kmLabel;
    [self.scView addSubview:kmLabel];
    
    [kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(distanceLabel);
        make.top.equalTo(distanceLabel.mas_bottom).with.offset(5);
        
    }];
    
    
    UILabel*timeLabel=[[UILabel alloc] init];
    timeLabel.text=@"累计时间";
    timeLabel.textColor=[UIColor colorWithHexString:@"#313a3f" alpha:1];
    timeLabel.font=[UIFont systemFontOfSize:12];
    [self.scView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(distanceLabel);
        make.right.equalTo(weakSelf.mas_right).with.offset(KscreenW-67);
        
    }];
    
    
    UILabel*timeLabel1=[[UILabel alloc] init];
    timeLabel1.text=@"1.5H";
    timeLabel1.font=[UIFont boldSystemFontOfSize:15];
    [self.scView addSubview:timeLabel1];
    self.timeLabel1=timeLabel1;
    [timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(timeLabel);
        make.top.equalTo(timeLabel.mas_bottom).with.offset(5);
        
    }];
    
    
    /**步数排行
     */
    UIView*lineH=[[UIView alloc] init];
    lineH.backgroundColor=btnLineColor;
    [self.scView addSubview:lineH];
    
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(kmLabel.mas_bottom).with.offset(27);
        make.height.equalTo(@13);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(KscreenW);
       
        
    }];
    
    
    
    UIImageView*iconImage=[[UIImageView alloc] init];
    iconImage.image=[UIImage imageNamed:@"rank_paihang"];
    [self.scView addSubview:iconImage];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(23);
        make.top.equalTo(lineH.mas_bottom).with.offset(25);
        
        
    }];
    
    
    UILabel*paiHangLabel=[[UILabel alloc] init];
    paiHangLabel.text=@"本周步数排行榜";
    paiHangLabel.textColor=BlackHexColor
    paiHangLabel.font=[UIFont systemFontOfSize:15];
    [self.scView addSubview:paiHangLabel];
    [paiHangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(iconImage);
        make.left.equalTo(iconImage.mas_right).with.offset(10);
        
    }];
    
    UILabel*Label=[[UILabel alloc] init];
    Label.text=@"2";
    Label.font=[UIFont boldSystemFontOfSize:30];
    [self.scView addSubview:Label];
    [Label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(paiHangLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(82);
        
    }];
    
    
    UILabel*mingciLabel=[[UILabel alloc] init];
    mingciLabel.text=@"名次";
    mingciLabel.font=[UIFont systemFontOfSize:12];
    mingciLabel.textColor=[UIColor colorWithHexString:@"#313a3f" alpha:1];
    [self.scView addSubview:mingciLabel];
    [mingciLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(Label);
        make.top.equalTo(Label.mas_bottom).with.offset(17);
       
        
    }];
 
    
    UILabel*stepLabel1=[[UILabel alloc] init];
    stepLabel1.text=@"23565";
    stepLabel1.font=[UIFont boldSystemFontOfSize:30];
    [self.scView addSubview:stepLabel1];
    [stepLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(Label);
        make.right.equalTo(weakSelf.mas_right).with.offset(KscreenW-42);
        
    }];

    UILabel*stepLabel=[[UILabel alloc] init];
    stepLabel.text=@"步数";
    stepLabel.textColor=[UIColor colorWithHexString:@"#313a3f" alpha:1];
    stepLabel.font=[UIFont systemFontOfSize:12];
    [self.scView addSubview:stepLabel];
    
    [stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(stepLabel1);
        make.top.equalTo(stepLabel1.mas_bottom).with.offset(17);

        
    }];
    
    

    /** 优惠券排行
     */
    UIView*phView=[[UIView alloc] init];
    phView.backgroundColor=btnLineColor;
    [self.scView addSubview:phView];
    [phView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(stepLabel.mas_bottom).with.offset(27);
        make.height.equalTo(@13);
        make.left.equalTo(weakSelf).with.offset(0);
        make.right.equalTo(weakSelf).with.offset(KscreenW);
        
    }];
    
    UIImageView*youhuiIcon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"youhui_Icon"]];
    [self.scView addSubview:youhuiIcon];
    
    [youhuiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf).with.offset(23);
        make.top.equalTo(phView.mas_bottom).with.offset(25);
    }];
    
    
    UILabel*couponsLabel=[[UILabel alloc] init];
    couponsLabel.text=@"本周获取优惠券排行";
    couponsLabel.textColor=BlackHexColor
    couponsLabel.font=[UIFont systemFontOfSize:15];
    [self.scView addSubview:couponsLabel];
    [couponsLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(youhuiIcon);
        make.left.equalTo(youhuiIcon.mas_right).with.offset(10);

    }];

    UILabel*couponsLabel1=[[UILabel alloc] init];
    couponsLabel1.text=@"2";
    couponsLabel1.font=[UIFont boldSystemFontOfSize:30];
    [self.scView addSubview:couponsLabel1];
    [couponsLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(couponsLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(82);

    }];


    UILabel*mingciLabel1=[[UILabel alloc] init];
    mingciLabel1.text=@"数量";
    mingciLabel1.font=[UIFont systemFontOfSize:12];
    mingciLabel1.textColor=[UIColor colorWithHexString:@"#313a3f" alpha:1];
    [self.scView addSubview:mingciLabel1];
    [mingciLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(couponsLabel1);
        make.top.equalTo(couponsLabel1.mas_bottom).with.offset(17);


    }];


    UILabel*numberLabel=[[UILabel alloc] init];
    numberLabel.text=@"100";
    numberLabel.font=[UIFont boldSystemFontOfSize:30];
    [self.scView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(couponsLabel1);
        make.right.equalTo(weakSelf.mas_right).with.offset(KscreenW-42);

    }];

    UILabel*numberLabel1=[[UILabel alloc] init];
    numberLabel1.text=@"步数";
    numberLabel1.textColor=[UIColor colorWithHexString:@"#313a3f" alpha:1];
    numberLabel1.font=[UIFont systemFontOfSize:12];
    [self.scView addSubview:numberLabel1];

    [numberLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(numberLabel);
        make.top.equalTo(numberLabel.mas_bottom).with.offset(17);


    }];


    
    
    
}







@end
