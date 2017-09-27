//
//  ForgotPassViewController.m
//  yxtd
//
//  Created by qin on 2017/9/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ForgotPassViewController.h"




@interface ForgotPassViewController ()<UITextFieldDelegate>

@property (nonatomic,weak) UITextField *timeTextField;


@property (nonatomic,weak) UITextField *regTextField;

@property (nonatomic,weak) UITextField *regTextField2;

;

@end

@implementation ForgotPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initNavi];
    
    [self  creatUI];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHid) name:UIKeyboardWillHideNotification object:nil];
    

}

-(void)keyBoardWillShow:(NSNotification*)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
   
    UIButton*sureBt=(UIButton*)[self.view viewWithTag:10086];
    
   sureBt.frame =CGRectMake(30,KscreenH -height-50, self.view.frame.size.width-60, 47);
}

-(void)keyBoardWillHid{
    
    UIButton*sureBt=(UIButton*)[self.view viewWithTag:10086];
    
    sureBt.frame=CGRectMake(30,CGRectGetMaxY(self.timeTextField.frame)+54 , self.view.frame.size.width-60, 47);
}


-(void)creatUI{
    
    
    UIView*lineH=[[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 1)];
    lineH.backgroundColor=btnLineColor;
    [self.view addSubview:lineH];
    
    NSArray *pla = @[@"手机号",@"密码",@"验证码"];
    NSArray *textleftImg = @[@"phoneNumber",@"password"];
    
    CGFloat texfiledH=67;
    
    //-----------------添加文本输入框----------------------------
    //-----------------—_textField---------------------
    UITextField *regTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame) ,texfiledH)];
    
    self.regTextField = regTextField;
    
    
    UITextField *regTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(regTextField.frame), CGRectGetWidth(self.view.frame), texfiledH)];
    self.regTextField2 = regTextField2;
    
    
    //验证码
    UITextField *timeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(regTextField2.frame), CGRectGetWidth(self.view.frame), texfiledH)];
    self.timeTextField = timeTextField;
    
    
    //设置文本框边界风格
    _regTextField.borderStyle = UITextBorderStyleNone;
    _regTextField2.borderStyle = UITextBorderStyleNone;
    _timeTextField.borderStyle = UITextBorderStyleNone;
    
    //设置字体大小
    _regTextField.font = [UIFont systemFontOfSize:15];
    _regTextField2.font = [UIFont systemFontOfSize:15];
    _timeTextField.font = [UIFont systemFontOfSize:15];
    
    
    //背景图片
    _regTextField.background = [UIImage imageWithStretchableName:@"textFieldImage"];
    _regTextField2.background = [UIImage imageWithStretchableName:@"textFieldImage"];
    _timeTextField.background = [UIImage imageWithStretchableName:@"textFieldImage"];
    
    //设置键盘样式
    _regTextField.returnKeyType = UIKeyboardTypeTwitter;
    _regTextField2.returnKeyType = UIKeyboardTypeTwitter;
    
    _regTextField.keyboardType = UIKeyboardTypeNumberPad;
    _timeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //设置密文
    _regTextField2.secureTextEntry = YES;
    
    //设置文本框代理
    _regTextField.delegate = self;
    _regTextField2.delegate = self;
    _timeTextField.delegate=self;
    
    //提示语
    _regTextField.placeholder = pla[0];
    _regTextField2.placeholder = pla[1];
    _timeTextField.placeholder=pla[2];
    
    //清除按钮
    _regTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _regTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _timeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    //自动适应大小
    _regTextField.adjustsFontSizeToFitWidth = YES;
    _regTextField2.adjustsFontSizeToFitWidth = YES;
    _timeTextField.adjustsFontSizeToFitWidth = YES;
    
    //左侧视图:leftView
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    left.image = [UIImage imageNamed:textleftImg[0]];
    UIImageView *left2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    left2.image = [UIImage imageNamed:textleftImg[1]];
    
    UIImageView *left3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    
    _regTextField.leftView = left;
    _regTextField2.leftView = left2;
    _timeTextField.leftView=left3;
    
    //左侧视图显示模式:leftViewMode
    _regTextField.leftViewMode = UITextFieldViewModeAlways;
    _regTextField2.leftViewMode = UITextFieldViewModeAlways;
    _timeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    //发送验证码
    UIButton*sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(CGRectGetMaxX(self.timeTextField.frame)-100,0,100,67);
    [sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -10);
    
    [sendButton setTitleColor:[UIColor colorWithRed:245.0/255.0 green:81.0/255.0 blue:49.0/255.0 alpha:1] forState:UIControlStateNormal];
    sendButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [sendButton addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    _timeTextField.rightView=sendButton;
    _timeTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    UIView*lineR=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(sendButton.frame), 0, 1, texfiledH)];
    lineR.backgroundColor=btnLineColor;
    [_timeTextField addSubview:lineR];
    
    
    
    
    
    UIButton*regButton=[UIButton buttonWithType:UIButtonTypeCustom];
    regButton.frame=CGRectMake(30,CGRectGetMaxY(self.timeTextField.frame)+54 , self.view.frame.size.width-60, 47);
    regButton.tag=10086;
    [regButton setTitle:@"确   认" forState:UIControlStateNormal];
    
    [regButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:214/255.0 blue:215/255.0 alpha:1]];
    regButton.layer.cornerRadius=10;
    regButton.clipsToBounds=YES;
    regButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [regButton setTintColor:[UIColor whiteColor]];
    [regButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
    
    [self.view addSubview:_regTextField];
    [self.view addSubview:_regTextField2];
    [self.view addSubview:_timeTextField];
    
    
    
    
}



#pragma mark   点击return键时候触发
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

#pragma mark--输入框代理事件(限制密码输入过长)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == self.regTextField2 && range.location >= 16)
    {
        return NO;
    }
    
    return YES;
}


#pragma mark --点击屏幕回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)sendClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"验证码发送成功" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];
    
    
    [self.view endEditing:YES];
    
}

-(void)buttonClick{
    
    //放弃第一响应者
    [self giveUpFirstResponder];
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"确认按钮" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];
    
    
    
    
    
}

#pragma mark   放弃第一响应者
- (void)giveUpFirstResponder
{
    if(_regTextField.isEditing)
    {
        [_regTextField resignFirstResponder];
        
    }
    else if(_regTextField2.isEditing)
    {
        
        [_regTextField2 resignFirstResponder];
        
    }else if (_timeTextField.isEditing){
        
        [_timeTextField resignFirstResponder];
    }
}



#pragma mark --设置导航栏
-(void)initNavi{
    
    self.view.backgroundColor=[UIColor colorWithRed: 247.0f/255.0f green:247.0f/255.0f blue:248.0f/255.0f alpha:1.0f];
    
    //设置导航条
    
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44+20)];
    navigationBar.tintColor=[UIColor whiteColor];
    navigationBar.translucent = NO;
    
    [self.view addSubview:navigationBar];
    
    UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    
    //设置左边返回按钮
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"NaviBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    // 自定义导航栏的title，用UILabel实现
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"找回密码";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    // 设置自定义的title
    navigationItem.titleView = titleLabel;
    
    
    
}


-(void)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
