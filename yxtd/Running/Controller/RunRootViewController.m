//
//  RunRootViewController.m
//  yxtd
//
//  Created by qin on 2017/10/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RunRootViewController.h"
#import "RunLocationGaoDeManager.h"

@interface RunRootViewController ()

@end

@implementation RunRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     [self.view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
    
    
    

    
}



//当前城市
- (NSString *)currentCity{
    
    RunLocationGaoDeManager *current = [RunLocationGaoDeManager sharedManager];
    return current.current_city;
}
//当前的经纬度
- (NSString *)show_longitude{//118.727559
    return @"118.727559";
}
- (NSString *)show_latitude{//32.038987
    return @"32.038987";
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
