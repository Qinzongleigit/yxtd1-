//
//  JiFenStoreHttp.h
//  yxtd
//
//  Created by qin on 2018/1/30.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineUserMessageParam.h"

@class MineUserMessageParam ;

@interface JiFenStoreHttp : NSObject

+ (void)httpJiFenStore:(MineUserMessageParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;


@end
