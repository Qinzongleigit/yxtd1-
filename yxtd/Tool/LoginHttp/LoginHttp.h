//
//  LoginHttp.h
//  yxtd
//
//  Created by qin on 2017/11/15.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginParam.h"

@class LoginParam;

@interface LoginHttp : NSObject


+ (void)httpLogin:(LoginParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;
@end
