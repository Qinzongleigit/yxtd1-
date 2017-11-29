//
//  NaviBarRootViewController.h
//  yxtd
//
//  Created by qin on 2017/11/29.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviBarRootViewController : UIViewController

@property (nonatomic,strong) UIButton*leftBt;
@property (nonatomic,strong) UIButton*rightBt;



-(void)leftBtnClick;

-(void)rightBtnClick;

@end
