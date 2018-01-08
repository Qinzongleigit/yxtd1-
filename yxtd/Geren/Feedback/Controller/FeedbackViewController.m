//
//  FeedbackViewController.m
//  yxtd
//
//  Created by qin on 2018/1/8.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@property (nonatomic,strong) UILabel*typeLabel;
@property (nonatomic,strong) UIButton*feedbackButton;
@property (nonatomic,strong) UIView*bgView;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLORWITHRGB(244, 245, 245);
    
    self.title=@"意见反馈";
    
    [self.rightBt setBackgroundImage:nil forState:UIControlStateNormal];
    [self.rightBt setTitle:@"反馈记录" forState:UIControlStateNormal];
    self.rightBt.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
    
    [self feedbackButtonView];
    
    
    [self feedbackDescription];

   
    
}

#pragma mark -反馈描述
-(void)feedbackDescription{
    
    UILabel*feedbackLabel=[[UILabel alloc] init];
    feedbackLabel.text=@"反馈描述";
    feedbackLabel.font=[UIFont systemFontOfSize:15];
    feedbackLabel.textColor=BlackHexColor;
    [self.view addSubview:feedbackLabel];
    [feedbackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(10);
    }];
    
    
    UIView*feedbackBgView=[[UIView alloc] init];
    feedbackBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:feedbackBgView];
    [feedbackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(190);
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(feedbackLabel.mas_bottom).offset(10);
    }];
    
    
}


#pragma mark -分类标签标题
-(void)feedbackButtonView{
    
    UILabel*typeLabel=[[UILabel alloc] init];
    self.typeLabel=typeLabel;
    typeLabel.text=@"分类标签标题";
    typeLabel.font=[UIFont systemFontOfSize:15];
    typeLabel.textColor=BlackHexColor;
    [self.view addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    
    
    UIView*bgView=[[UIView alloc] init];
    bgView.backgroundColor=[UIColor whiteColor];
    self.bgView=bgView;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(typeLabel.mas_bottom).offset(10);
    }];
    
    NSMutableArray*cellArray=[NSMutableArray new];
    
    NSArray*buttonArr=@[@"功能建议",@"bug提交",@"商家问题"];
    
    for (int i=0; i<buttonArr.count; i++) {
        
        UIButton*feedbackButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.feedbackButton=feedbackButton;
        feedbackButton.backgroundColor=[UIColor whiteColor];
        [feedbackButton setTitle:buttonArr[i] forState:UIControlStateNormal];
        feedbackButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [feedbackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       [feedbackButton setTitleColor:COLORWITHRGB(0, 219, 220) forState:UIControlStateSelected];
        
        feedbackButton.layer.borderWidth=1;
        feedbackButton.layer.borderColor=[UIColor blackColor].CGColor;
       
        feedbackButton.layer.cornerRadius=5;
        feedbackButton.clipsToBounds=YES;
        feedbackButton.tag=1000+i;
        [bgView addSubview:feedbackButton];
        
        [feedbackButton addTarget:self action:@selector(feedbackAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cellArray addObject:feedbackButton];
    }
    //水平方向控件间隔固定等间隔
    [cellArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:SYRealValueWidth(30) leadSpacing:SYRealValueWidth(46) tailSpacing:SYRealValueWidth(46)];
    
    [cellArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.height.equalTo(@38);
    }];
    
    
}

#pragma mark -分类标签按钮点击事件
-(void)feedbackAction:(UIButton*)btn{
    
   
    for(int i=1000 ;i<1003;i++)
    {
        UIButton *selectButton =(UIButton  *)[ self.view viewWithTag:i];
        selectButton.selected = NO;
        selectButton.layer.borderColor=[UIColor blackColor].CGColor;
    }
    
    btn.layer.borderColor=COLORWITHRGB(0, 219, 220).CGColor;
  
     btn.selected = YES;
    
    
}


-(void)leftBtnClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)rightBtnClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"反馈记录提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
