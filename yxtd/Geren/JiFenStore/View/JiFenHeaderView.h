//
//  JiFenHeaderView.h
//  yxtd
//
//  Created by qin on 2017/12/1.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

//头部左边按钮
typedef void(^gotoBack)(void);

//头部右边按钮
typedef void(^jifenRight)(void);

@interface JiFenHeaderView : UIView

@property (nonatomic,copy) gotoBack gotoBack;

@property (nonatomic,copy) jifenRight jifenRight;

@property(nonatomic,strong) void(^headerBtClick)(NSInteger tag);



@end
