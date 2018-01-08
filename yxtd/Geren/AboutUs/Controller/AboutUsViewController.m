//
//  AboutUsViewController.m
//  yxtd
//
//  Created by qin on 2018/1/8.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView*appImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bld"]];
    appImageView.layer.cornerRadius=5;
    appImageView.clipsToBounds=YES;
    [self.view addSubview:appImageView];
    [appImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.center.mas_equalTo(self.view);
        
    }];
    
    UILabel*versionsLabel=[[UILabel alloc] init];
    versionsLabel.text=@"版本号V1.1";
    versionsLabel.font=[UIFont systemFontOfSize:15];
    versionsLabel.textColor=BlackHexColor;
    [self.view addSubview:versionsLabel];
    [versionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(appImageView);
        make.top.mas_equalTo(appImageView.mas_bottom).offset(5);
    }];
    
    
    
    UILabel*companyName=[[UILabel alloc] init];
    companyName.text=@"深圳易息通达有限公司";
    companyName.font=[UIFont systemFontOfSize:15];
    companyName.textColor=BlackHexColor;
    [self.view addSubview:companyName];
    [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-30);
    }];
    
    
    UILabel*copyrightLabel=[[UILabel alloc] init];
    copyrightLabel.text=@"Copyright@2017";
    copyrightLabel.font=[UIFont systemFontOfSize:12];
    copyrightLabel.textColor=BlackHexColor;
    [self.view addSubview:copyrightLabel];
    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(companyName);
        make.bottom.mas_equalTo(companyName.mas_top).offset(-5);
    }];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
