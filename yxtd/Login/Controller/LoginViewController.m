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



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //添加相关控件
    [self addView];
    
    //添加登录注册按钮
    [self createLogBtn];
    
    [self setUpTextfileView];
    
    
    //键盘出现坐标上移
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHid) name:UIKeyboardWillHideNotification object:nil];
    

   
}

-(void)keyBoardWillShow:(NSNotification *)aNotification{
    
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.view.frame=CGRectMake(0, -height, KscreenW, KscreenH);
    
   
    
}



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
       
        [self setUpTextfileView];
        
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
    sendButton.frame=CGRectMake(CGRectGetMaxX(self.timeTextField.frame)-100,0,100,67);
    [sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, -15);
    
    [sendButton setTitleColor:[UIColor colorWithRed:245.0/255.0 green:81.0/255.0 blue:49.0/255.0 alpha:1] forState:UIControlStateNormal];
    sendButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _timeTextField.rightView=sendButton;
    _timeTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    UIView*lineR=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(sendButton.frame), 0, 1, 67)];
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
    
    [regButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:214/255.0 blue:215/255.0 alpha:1]];
    [regButton setTintColor:[UIColor whiteColor]];
    [regButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
    
    
    [regiserView addSubview:userlabel];
    [regiserView addSubview:_regTextField];
    [regiserView addSubview:_regTextField2];
    [regiserView addSubview:_timeTextField];
    
    
}


-(void)buttonClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"注册按钮" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];
    
}

#pragma mark --用户协议点击

-(void)userButton{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"用户协议" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];
    
}

#pragma mark---发送验证码
-(void)sendButtonClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"验证码发送成功" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
    
}


#pragma mark--忘记密码点击事件
-(void)touchForgetPassword{
    
    
    ForgotPassViewController*forgetVC=[[ForgotPassViewController alloc] init];
    
    [self presentViewController:forgetVC animated:YES completion:nil];
    
    
}


#pragma mark   登录控件
- (void)setUpTextfileView
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
    
    [logButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:214/255.0 blue:215/255.0 alpha:1]];
    [logButton setTintColor:[UIColor whiteColor]];
    [logButton addTarget:self action:@selector(logClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logButton];
    
    
    
    
}

-(void)logClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"登录点击" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];
    
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
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"rightLoginImage"] forState:UIControlStateNormal];

    [rightBtn addTarget:self action:@selector(touchrightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
    
    
    
    //------------------------暂不登录--------------------------------------
    UIButton *notLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    
    notLogin.frame = CGRectMake(KscreenW-80-16,34,80,15);
    
    [notLogin setTitle:@"暂不登录" forState:UIControlStateNormal];
    [notLogin setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6f] forState:UIControlStateNormal];
    notLogin.titleLabel.font=[UIFont systemFontOfSize:15];
    [notLogin addTarget:self action:@selector(touchNotLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:notLogin];
    
    
}

#pragma mark - 点击暂不登录按钮
- (void)touchNotLogin
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
