//
//  UpdatePhoneNumberViewController.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "UpdatePhoneNumberViewController.h"
#import "SmsParam.h"
#import "SmsHttp.h"

@interface UpdatePhoneNumberViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField*phoneText;

@property (nonatomic,strong) UIButton*sendCodeBt;

@property (nonatomic,strong) UITextField*codeText;

@property (nonatomic,strong) UITextField*passwordText;

@property (nonatomic,strong) UIButton*sureBt;

@property (nonatomic,strong) UILabel *countLabel;

@property (nonatomic,strong) NSTimer *timer;

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
    lineV.backgroundColor=COLORWITHRGB(173, 176, 178);
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
    [codeText setBackground:[UIImage imageWithoriginName:@"addressTextfiled_Image"]];
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
    [sureBt setImage:[UIImage imageWithoriginName:@"dagou_Image"] forState:UIControlStateNormal];
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


#pragma mark--注册手机号、密码验证
- (NSInteger)checkOutPhoneAndCode{
    
    if (!_phoneText.text.length)
    {
        [MBProgressHUD showError:@"请输入手机号"];
        
        _phoneText.text = nil;
        
        [_phoneText becomeFirstResponder];
        
        return 0;
    }
    if (_phoneText.text.length != 11)
    {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        
        _phoneText.text = nil;
        
        [_phoneText becomeFirstResponder];
        
        return 0;
    }if (!_codeText.text.length) {
        
        [MBProgressHUD showError:@"请输入正确的验证码"];
        _codeText.text = nil;
        
        [_codeText becomeFirstResponder];
        
        return 0;
    }
    if (!_passwordText.text.length) {
        
        [MBProgressHUD showError:@"请输入密码"];
        _passwordText.text = nil;
        
        [_passwordText becomeFirstResponder];
        
        return 0;
        
    }if (_passwordText.text.length<6)
    {
        [MBProgressHUD showError:@"请输入6~16位的密码"];
        
        _passwordText.text = nil;
        
        [_passwordText becomeFirstResponder];
        
        return 0;
        
    }
    
    return 1;
}

#pragma mark 确认更换按钮点击
-(void)sureBtClick{
    
    if (![self checkOutPhoneAndCode]) return;
    
    _sureBt.userInteractionEnabled=NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
        //把手机号回调到个人资料
        self.gotoGeRenZiLiao(_phoneText.text);
        
//        RegisterParam*param=[[RegisterParam alloc] init];
//
//        param.mobile=self.regTextField.text;
//        param.password=self.regTextField2.text;
//        param.smskey=self.timeTextField.text;
//
//        [RegisterHttp httpForRegister:param success:^(id responseObject) {
//
//
//            NSLog(@"注册返回数据================== %@",responseObject);
//
//            NSString *code = responseObject[@"code"];
//
//            if (code.integerValue == 200)
//            {
//                [MBProgressHUD showSuccess:responseObject[@"msg"]];
//
//                //界面跳转用的
//                //MineViewController*mineVc=[[MineViewController alloc] init];
//                //[self presentViewController:mineVc animated:YES completion:nil];
//
//
//                //返回登录界面
//                [self setLoginView];
//
//                [self giveUpFirstResponder];
//
//                UIButton *selectBt =(UIButton  *)[ self.view viewWithTag:100];
//                selectBt.selected = YES;
//
//                UIButton *selectBt1 =(UIButton  *)[ self.view viewWithTag:101];
//                selectBt1.selected = NO;
//
//
//
//
//            }else
//            {
//
//                [MBProgressHUD showError:responseObject[@"msg"]];
//            }
//
//            _regButton.userInteractionEnabled=YES;
//
//        } failure:^(NSError *error) {
//
//            _regButton.userInteractionEnabled=YES;
//
//            [MBProgressHUD showError:@"注册失败，请检查原因"];
//
//        }];
//
        
        
    });
    
    
}


#pragma mark 检测手机号是否输入正确
- (NSInteger)checkOutNumber{
    
    if (_phoneText.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入手机号"];
        
        
        _phoneText.text = nil;
        
        [_phoneText becomeFirstResponder];
        
        return 0;
    }
    if (_phoneText.text.length != 11)
    {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        
        _phoneText.text = nil;
        
        [_phoneText becomeFirstResponder];
        
        return 0;
    }
    
    return 1;
}


#pragma mark -发送验证码点击事件
-(void)sendCodeBtClick{
    
     if (![self checkOutNumber]) return;
    
    self.sendCodeBt.userInteractionEnabled=NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        SmsParam*param=[[SmsParam alloc] init];
        
        param.phone=self.phoneText.text;
        
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
            self.sendCodeBt.userInteractionEnabled = YES;
            
        } failure:^(NSError *error) {
            
            
            self.sendCodeBt.userInteractionEnabled = YES;
            
            [MBProgressHUD showError:@"获取验证码失败"];
            
        }];
        
    });
    
}


#pragma mark - 发送验证码成功调此方法

static int countNumber;

- (void)sendHttpUpdatePhoneNumberSuccess
{
    
    [self.sendCodeBt setBackgroundColor:[UIColor clearColor]];
    
    countNumber=120;
    
    [self.sendCodeBt setTitle:@"" forState:UIControlStateNormal];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:self.sendCodeBt.frame];
    
    countLabel.layer.cornerRadius = 5;
    
    countLabel.layer.masksToBounds = YES;
    
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    countLabel.backgroundColor = [UIColor lightGrayColor];
    
    countLabel.textColor = [UIColor whiteColor];
    
    countLabel.font = [UIFont systemFontOfSize:13];
    
    [self.sendCodeBt.superview addSubview:countLabel];
    
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
        
        [self.sendCodeBt setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self.sendCodeBt setBackgroundColor:COLORWITHRGB(49, 58, 63)];
        self.sendCodeBt.userInteractionEnabled = YES;
    }
    
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
