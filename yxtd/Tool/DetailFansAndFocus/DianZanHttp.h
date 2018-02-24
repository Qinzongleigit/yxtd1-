//
//  DianZanHttp.h
//  yxtd
//
//  Created by qin on 2018/2/24.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DianZanParam.h"

@class DianZanParam;

@interface DianZanHttp : NSObject

+ (void)httpDianZan:(DianZanParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
