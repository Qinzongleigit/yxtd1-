//
//  CLTRoundView.h
//  yxtd
//
//  Created by qin on 2017/9/29.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTRoundView : UIView

@property (nonatomic,assign) CGFloat percent;

@property(nonatomic,strong) void(^purposeBtClick)(void);

@property (nonatomic,strong)UIButton *purposeBt;

@end
