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

@property (nonatomic,strong) UITextField*passwordText;

@property (nonatomic,strong) UIButton*sureBt;

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
    
    
    //左侧视图:leftView
    UILabel*leftlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    leftlabel.text=@"+86";
    leftlabel.font=[UIFont systemFontOfSize:15];
    leftlabel.textAlignment=NSTextAlignmentLeft;
    leftlabel.textColor=[UIColor blackColor];
    
    UIView*lineV=[[UIView alloc] initWithFrame:CGRectMake(33, 8, 1, 14)];
    lineV.backgroundColor=[UIColor greenColor];
    [leftlabel addSubview:lineV];
    
    
    
    UITextField*phoneText=[[UITextField alloc] init];
    self.phoneText=phoneText;
    phoneText.delegate=self;
    phoneText.placeholder=@"输入手机号";
    [phoneText setBackground:[UIImage imageNamed:@"addressTextfiled_Image"]];
   phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
    phoneText.leftView=leftlabel;
    phoneText.leftViewMode=UITextFieldViewModeAlways;
    
    [self.view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(weakSelf).with.offset(SYRealValueWidth(77));
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(60);
        make.height.equalTo(@50);
    }];
    
    //验证码按钮
    UIButton *sendCodeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCodeBt=sendCodeBt;
    [sendCodeBt setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBt.titleLabel.font=[UIFont systemFontOfSize:15];
    [sendCodeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendCodeBt setBackgroundColor:COLORWITHRGB(49, 58, 63)];
    sendCodeBt.layer.cornerRadius=5;
    sendCodeBt.clipsToBounds=YES;
    [sendCodeBt addTarget:self action:@selector(sendCodeBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendCodeBt];
    
    [sendCodeBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(phoneText.mas_bottom).with.offset(15);
        make.width.height.equalTo(phoneText);
        make.centerX.equalTo(phoneText);
    }];

    
    //手机验证码输入框
    
    UITextField*codeText=[[UITextField alloc] init];
    self.codeText=codeText;
    codeText.delegate=self;
    codeText.placeholder=@"手机验证码";
    codeText.keyboardType=UIKeyboardTypeNumberPad;
    codeText.clearButtonMode=UITextFieldViewModeWhileEditing;
    [codeText setBackground:[UIImage imageNamed:@"addressTextfiled_Image"]];
    [self.view addSubview:codeText];
    [codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(sendCodeBt.mas_bottom).with.offset(15);
        make.width.height.equalTo(phoneText);
        make.centerX.equalTo(phoneText);
    }];
    
    
    //密码
    UITextField*passwordText=[[UITextField alloc] init];
    self.passwordText=passwordText;
    passwordText.delegate=self;
    passwordText.placeholder=@"密码";
    passwordText.clearButtonMode=UITextFieldViewModeWhileEditing;
    [passwordText setBackground:[UIImage imageNamed:@"addressTextfiled_Image"]];
    [self.view addSubview:passwordText];
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeText.mas_bottom).with.offset(15);
         make.width.height.equalTo(phoneText);
        make.centerX.equalTo(phoneText);
    }];
    
    
    
    //确认按钮
    UIButton *sureBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBt=sureBt;

    [sureBt setBackgroundColor:COLORWITHRGB(0, 219, 220)];
    sureBt.layer.cornerRadius=5;
    sureBt.clipsToBounds=YES;
    [sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBt];
    
    [sureBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(passwordText.mas_bottom).with.offset(15);
        make.width.height.equalTo(phoneText);
        make.centerX.equalTo(phoneText);
    }];
    
}

#pragma mark 确认更换按钮点击
-(void)sureBtClick{
    
    
}

#pragma mark -发送验证码点击事件
-(void)sendCodeBtClick{
    
    
    
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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
