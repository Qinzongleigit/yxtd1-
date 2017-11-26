//
//  RegisterHttp.h
//  yxtd
//
//  Created by qin on 2017/11/14.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterParam.h"

@class RegisterParam;

@interface RegisterHttp : NSObject

+ (void)httpForRegister:(RegisterParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
