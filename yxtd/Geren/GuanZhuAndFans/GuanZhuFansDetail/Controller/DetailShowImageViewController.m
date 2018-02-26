//
//  DetailShowImageViewController.m
//  yxtd
//
//  Created by qin on 2018/2/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailShowImageViewController.h"
#import "ShowBigImageView.h"

@interface DetailShowImageViewController ()

@end

@implementation DetailShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ShowBigImageView *showImageView = [[ShowBigImageView alloc]initWithFrame:self.view.bounds byClickTag:self.clickTag appendArray:self.imageViews];
    
    [self.view addSubview:showImageView];
    showImageView.removeImg = ^(){
        
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
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
