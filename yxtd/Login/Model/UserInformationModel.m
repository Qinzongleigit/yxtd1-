//
//  UserInformationModel.m
//  yxtd
//
//  Created by qin on 2018/1/29.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "UserInformationModel.h"

@implementation UserInformationModel


+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}

+(JSONKeyMapper*)keyMapper 
{
 NSDictionary*dict=@{@"member_id":@"data.member_id",@"api_token":@"data.api_token"};

    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:dict];

}

@end
