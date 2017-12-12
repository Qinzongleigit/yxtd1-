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
@property (nonatomic,strong) UIView*bglineH;

@property (nonatomic,strong) UIScrollView*scrollView;

@property (nonatomic,strong) NSArray*labelTextArr;


@end

@implementation DetailedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self performSelector:@selector(HeaderViewDelay) withObject:nil afterDelay:0.1];
    
    
    [self creatCALandKM];
    
    [self creatScrollView];
    
    [self addButton];
   
}
#pragma mark -导航按钮
-(void)addButton{

    UIButton*naviBt=[UIButton buttonWithType:UIButtonTypeCustom];
    naviBt.backgroundColor=COLORWITHRGB(0, 219, 220);
    [naviBt setTitle:@"导航出发" forState:UIControlStateNormal];
    [naviBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    naviBt.titleLabel.font=[UIFont systemFontOfSize:20];
    [naviBt addTarget:self action:@selector(gotoRunVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:naviBt];
    [naviBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
}

#pragma mark -创建集合视图
-(void)creatScrollView{

    
     _labelTextArr=@[@"1. 该使用券可在星巴克连锁分店使用。",@"2. 该使用券限深圳市星巴克商家使用。",@"3. 使用券为现金券，使用时请出示您的ID给服务员，使用后使用券作废。",@"4. 最终解释权为星巴克与跑券官方所有。",@"1. 该使用券可在星巴克连锁分店使用。",@"2. 该使用券限深圳市星巴克商家使用。",@"3. 使用券为现金券，使用时请出示您的ID给服务员，使用后使用券作废。",@"4. 最终解释权为星巴克与跑券官方所有。",@"1. 该使用券可在星巴克连锁分店使用。",@"2. 该使用券限深圳市星巴克商家使用。",@"3. 使用券为现金券，使用时请出示您的ID给服务员，使用后使用券作废。",@"4. 最终解释权为星巴克与跑券官方所有。",@"1. 该使用券可在星巴克连锁分店使用。",@"2. 该使用券限深圳市星巴克商家使用。",@"3. 使用券为现金券，使用时请出示您的ID给服务员，使用后使用券作废。",@"4. 最终解释权为星巴克与跑券官方所有。"];
    self.scrollView=[[UIScrollView alloc] init];
    
    self.scrollView.pagingEnabled=NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator=NO;
    CGFloat sceernWidth=[UIScreen mainScreen].bounds.size.width;
    
    
        UIImageView*lineVImage=[[UIImageView alloc] init];
        lineVImage.backgroundColor=COLORWITHRGB(0, 219, 220);
        [self.scrollView addSubview:lineVImage];
    
       UILabel*Label0=[[UILabel alloc] init];
        Label0.text=@"使用说明";
        Label0.textColor=BlackHexColor;
        Label0.font=[UIFont systemFontOfSize:15];
        [self.scrollView addSubview:Label0];
    
        [lineVImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).with.offset(25);
            make.top.equalTo(@21);
            make.size.mas_equalTo(CGSizeMake(4, 16));
        }];
    
        [Label0 mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.centerY.equalTo(lineVImage);
            make.left.equalTo(lineVImage.mas_right).with.offset(12);
        }];
    
    
    UILabel*lastLabel=nil;
    for (NSInteger i=0; i<_labelTextArr.count; i++) {
        
        UILabel*attentionLabel=[[UILabel alloc] init];
        attentionLabel.numberOfLines=0;
        attentionLabel.text=_labelTextArr[i];
        attentionLabel.font=[UIFont systemFontOfSize:12];
        attentionLabel.preferredMaxLayoutWidth=sceernWidth-30;
        attentionLabel.textAlignment=NSTextAlignmentLeft;
        attentionLabel.textColor=BlackHexColor;
        attentionLabel.alpha=0.5;
        
        [self.scrollView addSubview:attentionLabel];
        
        
        [attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(20);
            // make.right.mas_equalTo(-15);
            if (lastLabel) {
                
                make.top.equalTo(lastLabel.mas_bottom).offset(10);
            }else{
                
                make.top.equalTo(lineVImage.mas_bottom).offset(20);
            }
        }];
        
        lastLabel=attentionLabel;
    }
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(SYRealValueHeight(showViewHeight)+44, 0, 49, 0));
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];
    
    
    
}

#pragma mark -距离和卡路里
-(void)creatCALandKM{
    
    
    _bglineH=[[UIView alloc] init];
    
    _bglineH.backgroundColor=COLORWITHRGB(244, 245, 245);
    [self.view addSubview:_bglineH];
    
    UIImageView*distanceImage=[[UIImageView alloc] init];
    distanceImage.image=[UIImage imageNamed:@"distance_Image"];
    [_bglineH addSubview:distanceImage];
    
    
    UILabel*distanceLabel=[[UILabel alloc] init];
    
   
    if (!self.distanceLabel) {
        
        distanceLabel.text=@"距离太远无法估算";
    }else{
        
         distanceLabel.text=self.distanceLabel;
        
    }
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
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(SYRealValueHeight(showViewHeight));
        make.width.mas_equalTo(self.view);
        
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
    
    

}

#pragma mark 创建移动动画
-(void)HeaderViewDelay{
    
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
        
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5).priorityLow();
        make.bottom.mas_equalTo(@SYRealValueHeight(showViewHeight));
        make.height.equalTo(@SYRealValueHeight(showViewHeight*0.5));
        
    }];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_detailHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
            
             make.bottom.mas_equalTo(-KscreenH+SYRealValueHeight(showViewHeight));
            
            make.height.equalTo(@SYRealValueHeight(showViewHeight*1));
            make.width.mas_equalTo(self.view.mas_width).multipliedBy(1).priorityHigh();
            
             make.width.lessThanOrEqualTo(self.view);
        }];
        
       
        [self.view layoutIfNeeded];
        
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
