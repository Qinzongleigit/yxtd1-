//
//  CancleMyFocusHttp.h
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyFocusParam.h"

@class MyFocusParam ;

@interface CancleMyFocusHttp : NSObject

+ (void)httpCancleMyFocus:(MyFocusParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
