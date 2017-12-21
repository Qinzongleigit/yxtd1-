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

@interface ShanJiaGradeViewController ()

@end

@implementation ShanJiaGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self addShangjiaHeaderView];
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
