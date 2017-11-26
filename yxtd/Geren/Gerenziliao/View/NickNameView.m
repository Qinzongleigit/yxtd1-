//
//  NickNameView.m
//  yxtd
//
//  Created by qin on 2017/11/22.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "NickNameView.h"


@interface NickNameView ()<UITextViewDelegate>

@property (nonatomic,strong) UIView*btView;

@property (nonatomic,strong) UITextView*textView;

@property (nonatomic,strong) UILabel*placeholderLabel;

@property (nonatomic,strong) UIButton*sureBt;

@end

@implementation NickNameView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        
         [self creatTextView];
        
        //键盘上移
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHid:) name:UIKeyboardWillHideNotification object:nil];

    }
    return self;
}



#pragma mark -键盘出现
-(void)keyBoardWillShow:(NSNotification *)aNotification{

    [UIView animateWithDuration:2.0f animations:^{
        
        self.textView.frame=CGRectMake(30, (KscreenH-130)/2-100, KscreenW-60, 130);
    }];
    
}


//键盘下移
-(void)keyBoardWillHid:(NSNotification *)aNotification{

    [UIView animateWithDuration:2.0f animations:^{
        self.textView.frame=CGRectMake(30, (KscreenH-130)/2, KscreenW-60, 130);
    }];
   
}

#pragma mark -创建textView
-(void)creatTextView{
    
    
    UIView*btView=[[UIView alloc] initWithFrame:self.bounds];
    btView.backgroundColor=[UIColor grayColor];
    btView.alpha=0.8;
    self.btView=btView;
    [self addSubview:btView];
 
    UITextView*textView=[[UITextView alloc] init];
    textView.frame=CGRectMake(30, (KscreenH-130)/2, KscreenW-60, 130);
    self.textView=textView;
    textView.delegate=self;
    textView.layer.cornerRadius=5.0f;
    textView.textAlignment=NSTextAlignmentLeft;
    textView.font=[UIFont systemFontOfSize:15];
    
    [self addSubview:textView];
    [self bringSubviewToFront:textView];
    

    
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 20)];
    _placeholderLabel.backgroundColor=[UIColor clearColor];
    _placeholderLabel.textColor=[UIColor grayColor];
    _placeholderLabel.text=@"请在此修改昵称...";
    _placeholderLabel.font=self.textView.font;
    [self.textView addSubview:_placeholderLabel];
    
   
 
    
    UIButton*sureBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBt=sureBt;
    [sureBt setTitle:@"确 定" forState:UIControlStateNormal];
    sureBt.backgroundColor=COLORWITHRGB(0, 214, 215);
    sureBt.layer.cornerRadius=10;
    sureBt.clipsToBounds=YES;
    [sureBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [sureBt addTarget:self action:@selector(sureBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBt];
    [sureBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(textView);
        make.left.equalTo(self.mas_left).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.top.equalTo(textView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@38);
        
    }];
    
 
    if (!textView.text.length) {
        
        _placeholderLabel.hidden=NO;
        self.sureBt.enabled=NO;
        
    }else{
        
        _placeholderLabel.hidden=YES;
        
        self.sureBt.enabled=YES;
        
        
    }
    
}

#pragma mark -textView数值变化
-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length==0) {
        
        _placeholderLabel.hidden=NO;
        self.sureBt.enabled=NO;
        
    }else{
        
        _placeholderLabel.hidden=YES;
        
        self.sureBt.enabled=YES;
        
    }
}



#pragma mark-确定点击事件
-(void)sureBtClick{


    //昵称回调
    self.nickNameBlock(self.textView.text);

    [self.textView removeFromSuperview];
    [self.btView removeFromSuperview];
    [self.sureBt removeFromSuperview];
    
 
    

}

#pragma mark -屏幕点击回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
}

@end
