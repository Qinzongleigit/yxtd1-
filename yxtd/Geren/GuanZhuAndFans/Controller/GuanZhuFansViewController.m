//
//  GuanZhuFansViewController.m
//  yxtd
//
//  Created by qin on 2018/1/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "GuanZhuFansViewController.h"
#import "TitleView.h"

@interface GuanZhuFansViewController ()

@property (nonatomic,strong) TitleView*titleView;

@end

@implementation GuanZhuFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    TitleView*titleView =[[TitleView alloc] init];
    titleView.backgroundColor=[UIColor clearColor];
    self.titleView=titleView;
    self.navigationItem.titleView = self.titleView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
