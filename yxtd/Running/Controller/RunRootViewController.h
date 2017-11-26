//
//  RunRootViewController.h
//  yxtd
//
//  Created by qin on 2017/10/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunRootViewController : UIViewController

//当前城市
@property (nonatomic,strong) NSString *currentCity;
//当前的经纬度
@property (nonatomic,strong) NSString *show_longitude;
@property (nonatomic,strong) NSString *show_latitude;


@end
