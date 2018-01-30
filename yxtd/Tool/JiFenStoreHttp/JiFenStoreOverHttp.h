//
//  JiFenStoreOverHttp.h
//  yxtd
//
//  Created by qin on 2018/1/30.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineUserMessageParam.h"

@class MineUserMessageParam;

@interface JiFenStoreOverHttp : NSObject

+ (void)httpJiFenStoreOver:(MineUserMessageParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
