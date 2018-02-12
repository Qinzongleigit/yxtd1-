//
//  DetailHeaderView.h
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailFansAndFocusModel.h"

@interface DetailHeaderView : UIView

@property (nonatomic,strong) void(^buttonBackBlock)(void);

@property (nonatomic,strong) DetailFansAndFocusModel*model;

@property (nonatomic,strong) NSString*user_id;
@property (nonatomic,strong)
NSString*is_admin;

@end
