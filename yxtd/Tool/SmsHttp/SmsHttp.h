//
//  SmsHttp.h
//  yxtd
//
//  Created by qin on 2017/11/14.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmsParam.h"

@class SmsParam;

@interface SmsHttp : NSObject

+ (void)httpSms:(SmsParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
