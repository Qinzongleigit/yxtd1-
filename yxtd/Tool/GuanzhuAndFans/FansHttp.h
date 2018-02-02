//
//  FansHttp.h
//  yxtd
//
//  Created by qin on 2018/2/2.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineUserMessageParam.h"

@class MineUserMessageParam ;

@interface FansHttp : NSObject

+ (void)httpFans:(MineUserMessageParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
