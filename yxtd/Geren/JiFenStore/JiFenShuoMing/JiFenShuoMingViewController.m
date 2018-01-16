//
//  JiFenShuoMingViewController.m
//  yxtd
//
//  Created by qin on 2018/1/16.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "JiFenShuoMingViewController.h"

@interface JiFenShuoMingViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JiFenShuoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rightBt.hidden=YES;
    
    self.title=@"积分说明";
    
     [self initNavi];
    
    [self addLabel];
    
    
}

#pragma mark -循环创建多个Label
-(void)addLabel{
    
    NSArray*arr=@[@"1.什么是积分？",@"积分是用于跑券用户使用跑券内各种兑换、购买等增值服务的一种统计代码，并非任何代币票券，不能用于跑券服务以外的任何商品或服务。",@"2.如何使用积分？",@"积分可以用于兑换、购买跑券积分商城丰富商品；积分还可以用于参与抽奖活动、兑换重要赛事参赛名额等更多跑券内可使用积分的其他指定活动。",@"3.如何获取积分？",@"方法1：跑步获取 1公里=2积分;\n方法2：参与活动   通过参与跑券内挑战、赛事、排行等各类带有积分奖励的数量以各活动规则公布为准。",@"4.积分有效期有多长？",@"积分有效期最长为一年。即从用户获得积分开始至本自然年最后一天，次年第一天跑券将清空用户获得到未使用的积分。"];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lastLabel = nil;
    for (NSUInteger i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        
        if (i%2==0) {
            
            label.text=arr[i];
            
            label.font=[UIFont boldSystemFontOfSize:15];
            
        }else{
            
            label.text =arr[i] ;
            label.textColor = BlackHexColor;
            label.font=[UIFont systemFontOfSize:12];
            
        }
        
        label.preferredMaxLayoutWidth = KscreenW - 40;
        label.textAlignment = NSTextAlignmentLeft;
        
        [self.scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(self.view).offset(-20);
            
            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(27);
            }
        }];
        
        lastLabel = label;
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.edges.mas_equalTo(self.view);
       // make.top.mas_equalTo(64);
        
       make.edges.mas_equalTo(UIEdgeInsetsMake(65, 0, 0, 0));

        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
        
    }];
    
}


#pragma mark-自定义导航栏
-(void)initNavi{
    
 
    //设置导航条
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 44)];
    navigationBar.tintColor=[UIColor whiteColor];
    navigationBar.translucent = NO;
    [self.view addSubview:navigationBar];
    
    UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    
    //设置左边返回按钮
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //设置标题
    navigationItem.title = @"积分说明";
    
    
    
}

-(void)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
