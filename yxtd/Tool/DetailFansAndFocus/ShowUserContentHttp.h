//
//  ShowUserContentHttp.h
//  yxtd
//
//  Created by qin on 2018/2/9.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFocusParam.h"

@interface ShowUserContentHttp : NSObject

+ (void)httpShowUserContent:(MyFocusParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
