//
//  MyUINavigationController.m
//  UitabarController
//
//  Created by qin on 2017/9/11.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MyUINavigationController.h"

@interface MyUINavigationController ()

@end

@implementation MyUINavigationController


//初始化

+(void)initialize{
    
    UIBarButtonItem*item=[UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary*titleDictionary=[NSMutableDictionary dictionary];
    
    titleDictionary[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    
    [item setTitleTextAttributes:titleDictionary forState:UIControlStateNormal];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    
    UIImage*image=[UIImage imageWithoriginName:@"back"];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[self.navigationItem.backBarButtonItem class], nil] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    [[UIBarButtonItem appearanceWhenContainedIn:[self.navigationItem.backBarButtonItem class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
    
    
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
