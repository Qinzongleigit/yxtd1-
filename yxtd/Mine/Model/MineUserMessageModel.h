//
//  MineUserMessageModel.h
//  yxtd
//
//  Created by qin on 2018/1/29.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MineUserMessageModel : JSONModel

@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *dynum;
@property (nonatomic,copy) NSString *fans;
@property (nonatomic,copy) NSString *friends;

@property (nonatomic,copy) NSString *nickname;

@property (nonatomic,strong) NSArray *img_url;


@end
