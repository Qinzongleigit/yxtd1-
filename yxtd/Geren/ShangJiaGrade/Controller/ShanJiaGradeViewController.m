//
//  ShanJiaGradeViewController.m
//  yxtd
//
//  Created by qin on 2017/12/21.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ShanJiaGradeViewController.h"
#import "ShangJiaGradeHeaderView.h"
#import "FoodDetailsViewController.h"
#import "RatingStarView.h"

@interface ShanJiaGradeViewController ()

@property (nonatomic,strong) NSArray*arr;

@property (nonatomic,strong)  UILabel*ratingLabel;

@property (nonatomic,strong) UILabel*starLabel;

@end

@implementation ShanJiaGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
      self.arr=@[@"很差,不推荐",@"凑合,可考虑",@"一般,还值得",@"不错,要推荐",@"完美,不错过"];
    
    [self addShangjiaHeaderView];
    
    [self ratingStarView];
}

#pragma mark -商家评价
-(void)ratingStarView{
    
    
   RatingStarView*ratingView=[[RatingStarView alloc] initWithRatingBarFrame:CGRectMake((KscreenW-210)/2, 260, 210, 50) unselImg:@"ico_star" selImg:@"ico_star1" ratingStarNum:0 isEable:YES];
   
    ratingView.starNumBlock = ^(NSInteger starNum){
        
        [self number:starNum];
        
    };
    
    [self.view addSubview:ratingView];
    
    
    UILabel*ratingLabel=[[UILabel alloc] init];
    ratingLabel.text=@"请滑动星星评分";
    ratingLabel.font=[UIFont systemFontOfSize:15];
    self.ratingLabel=ratingLabel;
    ratingLabel.textColor=BlackHexColor;
    [self.view addSubview:ratingLabel];
    [ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(ratingView);
        make.top.mas_equalTo(ratingView.mas_bottom).offset(20);
    }];
  
  
    
    UILabel*starLabel=[[UILabel alloc] init];
    starLabel.text=@" ";
    starLabel.font=[UIFont systemFontOfSize:22];
    self.starLabel=starLabel;
    starLabel.textColor=COLORWITHRGB(0, 219, 220);
    [self.view addSubview:starLabel];
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(ratingLabel);
        make.right.mas_equalTo(ratingLabel.mas_left).offset(-10);
    }];
    
    UIView*grayView=[[UIView alloc] init];
    grayView.backgroundColor=btnLineColor;
    [self.view addSubview:grayView];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(KscreenW);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(12); make.top.mas_equalTo(starLabel.mas_bottom).offset(23);
    }];
    
    
}


//评价了几颗星
-(void)number:(NSInteger) index{
    
  self.starLabel.text=[NSString stringWithFormat:@"%ld 星",index];
    
    switch (index) {
        case 1:
            self.ratingLabel.text=_arr[0];
            break;
        case 2:
            self.ratingLabel.text=_arr[1];
            break;
            
        case 3:
            self.ratingLabel.text=_arr[2];
            break;
            
        case 4:
            self.ratingLabel.text=_arr[3];
            
            break;
            
        case 5:
            self.ratingLabel.text=_arr[4];
            break;
            
        default:
            break;
    }
    
}


#pragma mark -添加头部视图
-(void)addShangjiaHeaderView{
    
    ShangJiaGradeHeaderView*gradeView=[[ShangJiaGradeHeaderView alloc] init];
    gradeView.backgroundColor=[UIColor whiteColor];
  
    [self.view addSubview:gradeView];
    
    [gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(230);
        make.width.mas_equalTo(KscreenW);
    }];
    
    gradeView.buttonAction = ^(NSInteger tag) {
        
        if (tag==100) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else if (tag==101){
            
            FoodDetailsViewController*detailVC=[[FoodDetailsViewController alloc] init];
            
            [self presentViewController:detailVC animated:YES completion:nil];
            
        }
    };
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
