//
//  DetailArrayModel.m
//  yxtd
//
//  Created by 覃宗雷 on 2018/2/12.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailArrayModel.h"

@implementation DetailArrayModel

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)familyGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}



//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//
//
//
//}

@end
