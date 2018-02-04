//
//  SearchUserHttp.h
//  yxtd
//
//  Created by qin on 2018/2/4.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineUserMessageParam.h"

@interface SearchUserHttp : NSObject

+ (void)httpSearchUser:(MineUserMessageParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
