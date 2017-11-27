//
//  UpdatePhoneNumberViewController.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "UpdatePhoneNumberViewController.h"

@interface UpdatePhoneNumberViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField*phoneText;

@property (nonatomic,strong) UIButton*sendCodeBt;

@property (nonatomic,strong) UITextField*codeText;

@property (nonatomic,strong) UITextField*sureBt;

@end

@implementation UpdatePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initNavi];
    
    
    [self updatePhone];
  
    
    
}

#pragma mark 界面设置
-(void)updatePhone{
    
    __weak typeof(self.view) weakSelf=self.view;
    
    
    UITextField*phoneText=[[UITextField alloc] init];
    self.phoneText=phoneText;
    phoneText.delegate=self;
    phoneText.placeholder=@"请输入手机号";
    [phoneText setBackground:[UIImage imageNamed:@"addressTextfiled_Image"]];
    
    [self.view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(weakSelf).with.offset(77);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(60);
    }];
    
    
}

#pragma mark -初始化导航栏
-(void)initNavi{
    
    self.title=@"更换手机号";
    
    //左边按钮
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem=leftBt;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}


#pragma mark -返回按钮
-(void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];

    
}



@end
