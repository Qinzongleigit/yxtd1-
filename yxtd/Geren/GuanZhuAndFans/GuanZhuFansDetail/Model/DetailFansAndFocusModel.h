//
//  DetailFansAndFocusModel.h
//  yxtd
//
//  Created by 覃宗雷 on 2018/2/10.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DetailArrayModel.h"

@interface DetailFansAndFocusModel : JSONModel

@property (nonatomic,copy) NSString*is_focus;
@property (nonatomic,copy) NSString*nickname;
@property (nonatomic,copy) NSString*avatar;
@property (nonatomic,copy) NSString*friends;
@property (nonatomic,copy) NSString*fans;

@property (nonatomic,strong) DetailArrayModel*model;







@end
