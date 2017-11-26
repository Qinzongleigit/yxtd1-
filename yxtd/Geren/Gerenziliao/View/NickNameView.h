//
//  NickNameView.h
//  yxtd
//
//  Created by qin on 2017/11/22.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NickNameView : UIView

@property(nonatomic,strong) void(^nickNameBlock)(NSString*nickName);


@end
