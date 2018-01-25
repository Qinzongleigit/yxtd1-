//
//  LoginViewController.m
//  yxtd
//
//  Created by qin on 2017/9/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgotPassViewController.h"
#import "MyTabarController.h"
#import "SmsParam.h"
#import "SmsHttp.h"
#import "RegisterParam.h"
#import "RegisterHttp.h"
#import "LoginParam.h"
#import "LoginHttp.h"
#import "WebViewController.h"
#import "MineViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>


@property (nonatomic,weak) UITextField *textField;
/**
 *  密码textfield
 */
@property (nonatomic,weak) UITextField *textField2;

@property (nonatomic,weak) UITextField *timeTextField;


@property (nonatomic,weak) UITextField *regTextField;

@property (nonatomic,weak) UITextField *regTextField2;

;

@property (nonatomic,strong) UIButton *headerIcon;

@property (nonatomic,strong) UIImageView*headerImage;

@property (nonatomic,strong) UIButton*sendButton;

@property (nonatomic,strong) UIButton*regButton;

@property (nonatomic,strong) UIButton*logButton;

@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic,strong) NSTimer *timer;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //添加相关控件
    [self addView];
    
    //添加登录注册按钮
    [self createLogBtn];
    
    [self setLoginView];
    
    
    //键盘出现坐标上移
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHid) name:UIKeyboardWillHideNotification object:nil];
    

   
}

#pragma mark -键盘出现
-(void)keyBoardWillShow:(NSNotification *)aNotification{
    
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.view.frame=CGRectMake(0, -height, KscreenW, KscreenH);
    
   
    
}


//键盘下移
-(void)keyBoardWillHid{
    
    self.view.frame=CGRectMake(0, 0, KscreenW, KscreenH);
    
    
}


#pragma mark - 创建登录和注册按钮
- (void)createLogBtn
{
    
    
    NSArray*titleArr=@[@"登录",@"注册"];
    
    for (int i=0; i<titleArr.count; i++) {
        
        //登录
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(self.view.frame.size.width/2*i, CGRectGetMaxY(self.headerImage.frame), self.view.frame.size.width/2, 60);
        [bt setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
        UIColor*color=BlackHexColor
        [bt setTitleColor:color forState:UIControlStateNormal];
      
       //图片偏移
       [bt setImage:[UIImage imageWithoriginName:@"bgButtonImage"] forState:UIControlStateSelected];
       bt.imageEdgeInsets=UIEdgeInsetsMake(-68, 0, 0, -40);
        
        bt.titleLabel.font=[UIFont systemFontOfSize:17];
        [bt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
        bt.tag=100+i;
        
        [self.view addSubview:bt];
        
        if (bt.tag==100) {
            
            bt.selected=YES;
        }
        
        
    }
    
    //中间竖线
    UIView *btnLineC = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 , CGRectGetMaxY(self.headerImage.frame), 1, 60 )];
    
    btnLineC.backgroundColor =btnLineColor;
    
    [self.view addSubview:btnLineC];
    
    //底部横线
    UIView *btnLineR = [[UIView alloc] initWithFrame:CGRectMake( 0,CGRectGetMaxY(btnLineC.frame) , self.view.frame.size.width, 1)];
    
    btnLineR.backgroundColor = btnLineColor;
    
    [self.view addSubview:btnLineR];
    
    
}



#pragma mark---登录按钮点击事件
-(void)btClick:(UIButton*)Bt{
  
    for(int i=100 ;i<102;i++)
    {
        UIButton *selectButton =(UIButton  *)[ self.view viewWithTag:i];
        selectButton.selected = NO;
    }
    Bt.selected = YES;
   

    if (Bt.tag==100) {
       
        [self setLoginView];
        
    }else{
        
      
        [self setRegisterView];
        
    }
    
    
}

#pragma mark--注册控件
-(void)setRegisterView{
    
    UIButton*button=(UIButton*)[self.view viewWithTag:101];
   
    UIView*regiserView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+1, KscreenW, 500)];
    regiserView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:regiserView];
    
    NSArray *pla = @[@"请输入手机号",@"请输入密码",@"验证码"];
    NSArray *textleftImg = @[@"phoneNumber",@"password",@""];
    
    //-----------------添加文本输入框----------------------------
    //-----------------—_textField---------------------
    UITextField *regTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame) - 20 , 67)];
    
    self.regTextField = regTextField;
    
    
    UITextField *regTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(regTextField.frame), CGRectGetWidth(self.view.frame) - 20, 67)];
    self.regTextField2 = regTextField2;
    
    
    //验证码
    UITextField *timeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(regTextField2.frame), CGRectGetWidth(self.view.frame) - 20, 67)];
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
    _regTextField.placeholder  = pla[0];
    _regTextField2.placeholder = pla[1];
    _timeTextField.placeholder =pla[2];
    
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
    
    UIImageView *left3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    _regTextField.leftView = left;
    _regTextField2.leftView = left2;
    _timeTextField.leftView=left3;
    
    //左侧视图显示模式:leftViewMode
    _regTextField.leftViewMode = UITextFieldViewModeAlways;
    _regTextField2.leftViewMode = UITextFieldViewModeAlways;
    _timeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    //发送验证码
    UIButton*sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton=sendButton; sendButton.frame=CGRectMake(CGRectGetMaxX(self.timeTextField.frame)-90,1,90,65);
    [sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];

    [sendButton setTitleColor:[UIColor colorWithRed:245.0/255.0 green:81.0/255.0 blue:49.0/255.0 alpha:1] forState:UIControlStateNormal];
    sendButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _timeTextField.rightView=sendButton;
    _timeTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    UIView*lineR=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.timeTextField.frame)-105, 0, 1, 67)];
    lineR.backgroundColor=btnLineColor;
    [_timeTextField addSubview:lineR];


    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"点击注册表示同意用户协议"];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, attributedString.length)];
    //添加横线
    [attributedString addAttribute:NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                             range:NSMakeRange(8, 4)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#313a3f" alpha:0.5] range:NSMakeRange(0, 8)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:76.0f/255.0f green:132.0f/255.0f blue:195.0f/255.0f alpha:1.0f] range:NSMakeRange(8, 4)];
    
    UILabel*userlabel=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(self.timeTextField.frame)+20, 150, 10)];
    
    userlabel.attributedText=attributedString;
    userlabel.userInteractionEnabled=YES;
    
    
    //用户协议
    UIButton *userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(CGRectGetMaxX(userlabel.frame)-80, 0, 65, 12);
    
    [userButton setBackgroundColor:[UIColor clearColor]];
    [userButton addTarget:self action:@selector(userButton) forControlEvents:UIControlEventTouchUpInside];
    [userlabel addSubview:userButton];
    
    
    
    
    UIButton*regButton=[UIButton buttonWithType:UIButtonTypeCustom];
    regButton.frame=CGRectMake(0,self.view.frame.size.height-64,self.view.frame.size.width, 64);
    [regButton setTitle:@"注册" forState:UIControlStateNormal];
    self.regButton=regButton;
    [regButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:214/255.0 blue:215/255.0 alpha:1]];
    [regButton setTintColor:[UIColor whiteColor]];
    [regButton addTarget:self action:@selector(regButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
    
    
    [regiserView addSubview:userlabel];
    [regiserView addSubview:_regTextField];
    [regiserView addSubview:_regTextField2];
    [regiserView addSubview:_timeTextField];
    
    
  
    
}

#pragma mark--注册手机号、密码验证
- (NSInteger)checkOutRegiser{
    
    if (!_regTextField.text.length)
    {
        [MBProgressHUD showError:@"请输入手机号"];

        _regTextField.text = nil;
        
        [_regTextField becomeFirstResponder];
        
        return 0;
    }
    if (_regTextField.text.length != 11)
    {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        
        _regTextField.text = nil;
        
        [_regTextField becomeFirstResponder];
        
        return 0;
    }if (!_regTextField2.text.length) {
        
        [MBProgressHUD showError:@"请输入密码"];
        _regTextField2.text = nil;
        
        [_regTextField2 becomeFirstResponder];
        
        return 0;
        
    }if (_regTextField2.text.length<6)
    {
        [MBProgressHUD showError:@"请输入6~16位的密码"];
        
        _regTextField2.text = nil;
        
        [_regTextField2 becomeFirstResponder];
        
        return 0;
        
    }if (!_timeTextField.text.length) {
        
         [MBProgressHUD showError:@"请输入正确的验证码"];
        _timeTextField.text = nil;
        
        [_timeTextField becomeFirstResponder];
        
        return 0;
    }
    
    return 1;
}
#pragma mark -注册按钮点击
-(void)regButtonClick{
    
   
    if (![self checkOutRegiser]) return;
    
    _regButton.userInteractionEnabled=NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
      
        RegisterParam*param=[[RegisterParam alloc] init];
        
        param.phone=self.regTextField.text;
        param.password=self.regTextField2.text;
        param.smskey=self.timeTextField.text;
        
        [RegisterHttp httpForRegister:param success:^(id responseObject) {
 
            
               NSLog(@"注册返回数据================== %@",responseObject);
            
            NSString *code = responseObject[@"code"];

            if (code.integerValue == 200)
            {
                [MBProgressHUD showSuccess:responseObject[@"msg"]];
                
                
                //返回登录界面
                [self setLoginView];
                
                [self giveUpFirstResponder];
                
                UIButton *selectBt =(UIButton  *)[ self.view viewWithTag:100];
                selectBt.selected = YES;
                
                UIButton *selectBt1 =(UIButton  *)[ self.view viewWithTag:101];
                selectBt1.selected = NO;
                
                
             
                
            }else
            {
  
                [MBProgressHUD showError:responseObject[@"msg"]];
                
            }

              _regButton.userInteractionEnabled=YES;
            
        } failure:^(NSError *error) {
 
              _regButton.userInteractionEnabled=YES;
            
            [MBProgressHUD showError:@"注册失败，请检查原因"];
            
        }];
            

        
    });
    
    
}

#pragma mark --用户协议点击

-(void)userButton{

    WebViewController*web=[[WebViewController alloc] init];
    web.webTitle=@"用户协议";
    
    web.webUrl=UserAgreement;
    
    [self presentViewController:web animated:YES completion:nil];
   
    
}

#pragma mark---发送验证码
static int countNumber;

-(void)sendButtonClick{

    if (![self checkOutNumber]) return;
    
   self.sendButton.userInteractionEnabled=NO;
    
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

       SmsParam*param=[[SmsParam alloc] init];

       param.phone=self.regTextField.text;

       [SmsHttp httpSms:param success:^(id responseObject) {

           NSLog(@"短信验证码返回数据=======================: %@",responseObject);
           
          NSString *status = responseObject[@"code"];
     
           if (status.integerValue == 200)
           {
               [MBProgressHUD showSuccess:responseObject[@"msg"]];

               [self sendHttpUpdatePhoneNumberSuccess];

           }else
           {
               
               [MBProgressHUD showError:responseObject[@"msg"]];
           }
           self.sendButton.userInteractionEnabled = YES;

       } failure:^(NSError *error) {


           self.sendButton.userInteractionEnabled = YES;

           [MBProgressHUD showError:@"获取验证码失败"];

       }];
       
    });
 
    
}


#pragma mark - 发送验证码成功调此方法
- (void)sendHttpUpdatePhoneNumberSuccess
{
    
    [self.sendButton setBackgroundColor:[UIColor clearColor]];
    
    countNumber=120;
    
    [self.sendButton setTitle:@"" forState:UIControlStateNormal];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:self.sendButton.frame];
    
    countLabel.layer.cornerRadius = 5;
    
    countLabel.layer.masksToBounds = YES;
    
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    countLabel.backgroundColor = [UIColor lightGrayColor];
    
    countLabel.textColor = [UIColor whiteColor];
    
    countLabel.font = [UIFont systemFontOfSize:13];
    
    [self.sendButton.superview addSubview:countLabel];
    
    self.countLabel = countLabel;
    
    self.countLabel.text = [NSString stringWithFormat:@"(%d)重新获取", countNumber];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownGetAuthCode) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 定时器事件
- (void)countDownGetAuthCode
{
   
    if (countNumber>0) {
        
        countNumber--;
        self.countLabel.text = [NSString stringWithFormat:@"(%d)重新获取", countNumber];
    }else{
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        [self.countLabel removeFromSuperview];
        
        self.countLabel = nil;
        
        [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self.sendButton setBackgroundColor:[UIColor whiteColor]];
        
        self.sendButton.userInteractionEnabled = YES;
    }
    
}


#pragma mark 检测手机号是否输入正确
- (NSInteger)checkOutNumber{
    
    if (_regTextField.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入手机号"];
        
        
        _regTextField.text = nil;
        
        [_regTextField becomeFirstResponder];
        
        return 0;
    }
    if (_regTextField.text.length != 11)
    {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        
        _regTextField.text = nil;
        
        [_regTextField becomeFirstResponder];
        
        return 0;
    }
    
    return 1;
}

#pragma mark--忘记密码点击事件
-(void)touchForgetPassword{
    
 ForgotPassViewController*forgetVC=[[ForgotPassViewController alloc] init];
    [self presentViewController:forgetVC animated:YES completion:nil];
    
}

#pragma mark   登录控件
- (void)setLoginView
{
    
    UIButton*button=(UIButton*)[self.view viewWithTag:100];
    UIView*loginView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)+1, KscreenW, 500)];
    loginView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:loginView];

    NSArray *pla = @[@"手机号",@"密码"];
    NSArray *textleftImg = @[@"phoneNumber",@"password"];
    
    //-----------------添加文本输入框----------------------------
    //-----------------—_textField---------------------
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame) - 20 , 67)];
    self.textField = textField;
    
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(textField.frame), CGRectGetWidth(self.view.frame) - 20, 67)];
    self.textField2 = textField2;
    
    //设置文本框边界风格
    _textField.borderStyle = UITextBorderStyleNone;
    _textField2.borderStyle = UITextBorderStyleNone;
    
    
    //设置字体大小
    _textField.font = [UIFont systemFontOfSize:15];
    _textField2.font = [UIFont systemFontOfSize:15];
    
    
    //背景图片
    _textField.background = [UIImage imageWithStretchableName:@"textFieldImage"];
    _textField2.background = [UIImage imageWithStretchableName:@"textFieldImage"];
    
    //设置键盘样式
    _textField.returnKeyType = UIKeyboardTypeTwitter;
    _textField2.returnKeyType = UIKeyboardTypeTwitter;
    
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    
    //设置密文
    _textField2.secureTextEntry = YES;
    
    //设置文本框代理
    _textField.delegate = self;
    _textField2.delegate = self;
    
    //提示语
    _textField.placeholder = pla[0];
    _textField2.placeholder = pla[1];
    
    //清除按钮
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //_textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    //自动适应大小
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField2.adjustsFontSizeToFitWidth = YES;
    
    //左侧视图:leftView
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    left.image = [UIImage imageNamed:textleftImg[0]];
    UIImageView *left2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    left2.image = [UIImage imageNamed:textleftImg[1]];
    
    _textField.leftView = left;
    _textField2.leftView = left2;
    
    //左侧视图显示模式:leftViewMode
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField2.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    //---------------忘记密码按钮---------------------
    UIButton *forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    
    forgetPassword.frame = CGRectMake(self.view.frame.size.width-70-15, 0, 70, 67);
    
    [forgetPassword setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    forgetPassword.titleLabel.font = [UIFont italicSystemFontOfSize:15];
    
    [forgetPassword setTitleColor:[UIColor colorWithHexString:@"#313a3f" alpha:0.3] forState:UIControlStateNormal];
   
    [forgetPassword addTarget:self action:@selector(touchForgetPassword) forControlEvents:UIControlEventTouchUpInside];
    
    
    _textField2.rightView=forgetPassword;
    _textField2.rightViewMode=UITextFieldViewModeAlways;
    
    [loginView addSubview:_textField];
    [loginView addSubview:_textField2];
    
    
    //登录
    UIButton*logButton=[UIButton buttonWithType:UIButtonTypeCustom];
    logButton.frame=CGRectMake(0,KscreenH-64 , self.view.frame.size.width, 64);
    [logButton setTitle:@"登录" forState:UIControlStateNormal];
    self.logButton=logButton;
    [logButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:214/255.0 blue:215/255.0 alpha:1]];
    [logButton setTintColor:[UIColor whiteColor]];
    [logButton addTarget:self action:@selector(logClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logButton];
    
    
    
    
}

#pragma mark -登录密码、手机号验证
-(NSInteger)checkOutLogin{
 
    if (!_textField.text.length)
    {
        [MBProgressHUD showError:@"请输入手机号"];
        
        _textField.text = nil;
        
        [_textField becomeFirstResponder];
        
        return 0;
    }
    if (_textField.text.length != 11)
    {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        
        _textField.text = nil;
        
        [_textField becomeFirstResponder];
        
        return 0;
    }if (!_textField2.text.length) {
        
        [MBProgressHUD showError:@"请输入密码"];
        _textField2.text = nil;
        
        [_textField2 becomeFirstResponder];
        
        return 0;
        
    }if (_textField2.text.length<6)
    {
        [MBProgressHUD showError:@"请输入6~16位的密码"];
        
        _textField2.text = nil;
        
        [_textField2 becomeFirstResponder];
        
        return 0;
        
    }
    
    return 1;
}
    


#pragma mark-登录按钮点击

-(void)logClick{

 
    if (![self checkOutLogin]) return;
    
    self.logButton.userInteractionEnabled=NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        

       LoginParam *param=[[LoginParam alloc] init];

        param.phone=self.textField.text;

        param.password=self.textField2.text;

        [LoginHttp httpLogin:param success:^(id responseObject) {

            NSLog(@"登录:========================:%@",responseObject);

            NSString *code = responseObject[@"code"];


            if (code.integerValue == 200)
            {
                [MBProgressHUD showSuccess:responseObject[@"msg"]];


                //跳转到跑券界面
                MyTabarController*myTab=[[MyTabarController alloc] init];
                // [myTab setSelectedIndex:0];
                
                [self presentViewController:myTab animated:YES completion:nil];

            }else
            {


                [MBProgressHUD showError:responseObject[@"msg"]];
            }
            self.logButton.userInteractionEnabled = YES;

        } failure:^(NSError *error) {


            self.logButton.userInteractionEnabled = YES;

            [MBProgressHUD showError:@"登录失败"];

        }];




   });

    
    
}



#pragma mark   放弃第一响应者
- (void)giveUpFirstResponder
{
    if(_textField.isEditing||_regTextField.isEditing)
    {
        [_textField resignFirstResponder];
        
        [_regTextField resignFirstResponder];
        
    }
    else if(_textField2.isEditing||_regTextField2.isEditing)
    {
        
        [_textField2 resignFirstResponder];
        
        [_regTextField2 resignFirstResponder];
        
    }else if (_timeTextField.isEditing){
        
        [_timeTextField resignFirstResponder];
    }
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
    
    if ((textField == self.textField2||(textField==self.regTextField2)) && range.location >= 16)
    {
        return NO;
    }
    
    return YES;
}


#pragma  mark   滚动视图的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //放弃第一响应者
    [self giveUpFirstResponder];
}

#pragma mark     添加头部控件
- (void)addView
{
    
    CGFloat headerH=0;
    
    if (KscreenH<=FourInchHeight) {
        
        headerH=200;
    }else if (KscreenH==FourPointSevenInchHeight){
        
        headerH=252;
    }else{
        
        headerH=300;
    }
    //----创建一个UIView并放在UIScrollView上，将某些控件加在上面，-----
    UIImageView*headerImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, headerH)];
    self.headerImage=headerImage;
    headerImage.image=[UIImage imageWithoriginName:@"loginHeaderImage"];
    [self.view addSubview:headerImage];
    
    
    //----------------头像-----------------
    CGFloat headerIconW = 90;
    
    CGFloat headerIconH = headerIconW;
    
    _headerIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerIcon.frame = CGRectMake((CGRectGetWidth(headerImage.frame) - headerIconW)/2, (CGRectGetHeight(headerImage.frame) - headerIconH)/2+10, headerIconW, headerIconH);
    
    [_headerIcon setBackgroundImage:[UIImage imageNamed:@"iconImage"] forState:UIControlStateNormal];
    
    [_headerIcon addTarget:self action:@selector(touchHeaderIconBtn) forControlEvents:UIControlEventTouchUpInside];
    _headerIcon.backgroundColor = [UIColor whiteColor];
    
    _headerIcon.layer.cornerRadius =10;
    _headerIcon.clipsToBounds=YES;
    
    _headerIcon.clipsToBounds = YES;
    
    [headerImage addSubview:_headerIcon];
    
   
    
    
    NSInteger width = 0;
    
    NSInteger height = width;
    
    width = 22;
    
    height = width;
    
    
    //-----------------------左边按钮--------------------------
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(17,31,22,22);
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"leftLoginImage"] forState:UIControlStateNormal];

    [rightBtn addTarget:self action:@selector(touchrightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    
    
    
    //------------------------暂不登录--------------------------------------
    UIButton *notLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    
    notLogin.frame = CGRectMake(KscreenW-80-16,34,80,20);
    notLogin.titleLabel.textAlignment=NSTextAlignmentCenter;
    [notLogin setTitle:@"暂不登录" forState:UIControlStateNormal];

    [notLogin setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6f] forState:UIControlStateNormal];
    notLogin.titleLabel.font=[UIFont systemFontOfSize:15];
    [notLogin addTarget:self action:@selector(touchNotLogin:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:notLogin];
    
    
}

#pragma mark - 点击暂不登录按钮
- (void)touchNotLogin:(UIButton*)notLogBt
{
    
    
    MyTabarController*tab=[[MyTabarController alloc] init];

    [self presentViewController:tab animated:YES completion:nil];
    
}


-(void)touchrightBtn{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"暂时不做功能" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

}


#pragma mark     点击头像触发事件
- (void)touchHeaderIconBtn
{
    
    NSLog(@"-----头像点击了一次-----");
    
}





#pragma mark - 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden=YES;
    
    //修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //修改电池条
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

#pragma mark - 视图即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}







@end
