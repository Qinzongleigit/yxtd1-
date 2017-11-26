//
//  CDHttpTool.h
//  yydb
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "interface.h"

@interface CDHttpTool : NSObject

+ (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;


+ (void)POST:(NSString *)urlStr parameters:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;

@end
