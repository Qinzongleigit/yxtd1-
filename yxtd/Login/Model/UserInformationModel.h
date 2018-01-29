//
//  UserInformationModel.h
//  yxtd
//
//  Created by qin on 2018/1/29.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserInformationModel : JSONModel

@property (nonatomic,strong) NSString*api_token;

@property (nonatomic,strong) NSString*member_id;


@end
