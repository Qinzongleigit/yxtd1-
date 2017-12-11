//
//  DetailedViewController.m
//  yxtd
//
//  Created by qin on 2017/10/31.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "DetailedViewController.h"
#import "DetailedView.h"

#define showViewHeight 229

@interface DetailedViewController ()

@property (nonatomic,strong) DetailedView *detailHeaderView;
@property (nonatomic,strong)  UIView*bglineH;

@end

@implementation DetailedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.detailHeaderView = [[DetailedView alloc] init];
    self.detailHeaderView.backgroundColor = [UIColor whiteColor];
    self.detailHeaderView.alpha = 0.9;
    self.detailHeaderView.statNum=4.5;
    ZXNWeakSelf(self)
    self.detailHeaderView.backRunVC  = ^(){
        
        [weakself gotoRunVC];
    };
    
    self.detailHeaderView.locationLabel.text=self.addressLabel;
    
    [self.view addSubview:self.detailHeaderView];
    
    
        [_detailHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
 make.height.equalTo(@SYRealValueHeight(showViewHeight));
            
        }];
  
   
    
//    [_detailHeaderView.superview layoutIfNeeded];
//
//    [UIView animateWithDuration:10 animations:^{
//
//        [_detailHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(@100);
//        }];
//        [_detailHeaderView.superview layoutIfNeeded];
//
//    }];
//
    
    
    _bglineH=[[UIView alloc] init];

    _bglineH.backgroundColor=COLORWITHRGB(244, 245, 245);
    [self.view addSubview:_bglineH];
    
    UIImageView*distanceImage=[[UIImageView alloc] init];
    distanceImage.image=[UIImage imageNamed:@"distance_Image"];
    [_bglineH addSubview:distanceImage];
    
    
    UILabel*distanceLabel=[[UILabel alloc] init];
    
    distanceLabel.text=self.distanceLabel;
    distanceLabel.textColor=BlackHexColor;
    distanceLabel.font=[UIFont systemFontOfSize:12];
    [_bglineH addSubview:distanceLabel];
    
    UIImageView*CALImage=[[UIImageView alloc] init];
    CALImage.image=[UIImage imageNamed:@"calorie_Image"];
    [_bglineH addSubview:CALImage];
    
    UILabel*CALLabel=[[UILabel alloc] init];
    CALLabel.text=@"128CAl";
    CALLabel.textColor=BlackHexColor;
    CALLabel.font=[UIFont systemFontOfSize:12];
    [_bglineH addSubview:CALLabel];
    
    
    
    [_bglineH mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(_detailHeaderView.mas_bottom).with.offset(0);
        make.height.equalTo(@44);
        
    }];
    
    [distanceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bglineH);
        make.left.equalTo(_bglineH).with.offset(69);
    }];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bglineH);
        make.left.equalTo(distanceImage.mas_right).with.offset(6);
    }];
    
    [CALLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(_bglineH);
        make.right.equalTo(_bglineH).with.offset(-60);
    }];
    
    [CALImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_bglineH);
        make.right.equalTo(CALLabel.mas_left).with.offset(-6);
    }];
    
   
    
   [self labelUI];
   
}

-(void)labelUI{
    
    __weak typeof(self.view) weakSelf=self.view;
    
    NSArray*labelTextArr=@[@"1. 该使用券可在星巴克连锁分店使用。",@"2. 该使用券限深圳市星巴克商家使用。",@"3. 使用券为现金券，使用时请出示您的ID给服务员，使用后使用券作废。",@"4. 最终解释权为星巴克与跑券官方所有。"];
    
    UIImageView*lineVImage=[[UIImageView alloc] init];
    lineVImage.backgroundColor=COLORWITHRGB(0, 219, 220);
    [self.view addSubview:lineVImage];
   
    
    UILabel*Label0=[[UILabel alloc] init];
    Label0.text=@"使用说明";
    Label0.textColor=BlackHexColor;
    Label0.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:Label0];
    
    UILabel*Label1=[[UILabel alloc] init];
    Label1.text=labelTextArr[0];
    Label1.textColor=BlackHexColor;
    Label1.alpha=0.5;
    Label1.numberOfLines=0;
    Label1.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:Label1];
    
    UILabel*Label2=[[UILabel alloc] init];
    Label2.text=labelTextArr[1];
    Label2.textColor=BlackHexColor;
    Label2.alpha=0.5;
    Label2.numberOfLines=0;
    Label2.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:Label2];
    
    UILabel*Label3=[[UILabel alloc] init];
    Label3.text=labelTextArr[2];
    Label3.textColor=BlackHexColor;
    Label3.alpha=0.5;
    Label3.numberOfLines=0;
    Label3.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:Label3];
    
    UILabel*Label4=[[UILabel alloc] init];
    Label4.text=labelTextArr[3];
    Label4.textColor=BlackHexColor;
    Label4.alpha=0.5;
    Label4.numberOfLines=0;
    Label4.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:Label4];
    
    
    UIButton*naviBt=[UIButton buttonWithType:UIButtonTypeCustom];
    naviBt.backgroundColor=COLORWITHRGB(0, 219, 220);
    [naviBt setTitle:@"导航出发" forState:UIControlStateNormal];
    [naviBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    naviBt.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:naviBt];
    
    [lineVImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(self.bglineH.mas_bottom).with.offset(21);
        make.size.mas_equalTo(CGSizeMake(4, 16));
    }];

    [Label0 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(lineVImage);
        make.left.equalTo(lineVImage.mas_right).with.offset(12);
    }];
    
    [Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(lineVImage.mas_bottom).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-10);
    }];
    
    [Label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(Label1.mas_bottom).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-10);
    }];
    
    
    [Label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(25);
        make.top.equalTo(Label2.mas_bottom).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-10);
    }];
    
    [Label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.equalTo(weakSelf).with.offset(25);
         make.top.equalTo(Label3.mas_bottom).with.offset(20);
         make.right.equalTo(weakSelf).with.offset(-10);
    }];
    
    
    [naviBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@49);
    }];
  
}



//返回按钮
-(void)gotoRunVC{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
