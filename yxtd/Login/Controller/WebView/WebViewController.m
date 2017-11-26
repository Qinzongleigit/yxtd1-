//
//  WebViewController.m
//  yxtd
//
//  Created by qin on 2017/11/15.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (nonatomic,strong) WKWebView*webView;

@end

@implementation WebViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
     [self initNavi];
    
     [self webLoad];
}
#pragma mark-自定义导航栏
-(void)initNavi{
    

    UIView*lineH=[[UIView alloc] initWithFrame:CGRectMake(0, 64, KscreenW, 1)];
    lineH.backgroundColor=btnLineColor;
    [self.view addSubview:lineH];
    
    UIView*naviBgV=[[UIView alloc] init];
    naviBgV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:naviBgV];
    
    
    UIButton*leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(leftBtClick) forControlEvents:UIControlEventTouchUpInside];
    [naviBgV addSubview:leftBt];
    
    
    UILabel*titleLabel=[[UILabel alloc] init];
    titleLabel.text=self.webTitle;
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.textColor=BlackHexColor;
    
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [naviBgV addSubview:titleLabel];
    
    
    [naviBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@64);
    }];
    
    [leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(naviBgV.mas_top).with.offset(32);
        make.left.equalTo(naviBgV.mas_left).with.offset(15);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(naviBgV);
        make.top.equalTo(naviBgV.mas_top).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(100, 17));
    }];
    
}

-(void)leftBtClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma  mark-网页加载
-(void)webLoad{
    
 WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    
  _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 65, KscreenW, KscreenH-65) configuration:config];

    NSURL*url=[NSURL URLWithString:_webUrl];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    //    打开前进或者后退的手势
    _webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:_webView];

}

@end
