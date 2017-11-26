//
//  HYSwitch.h
//  yxtd
//
//  Created by qin on 2017/10/26.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchChangedAction)(BOOL isOn);

@interface HYSwitch : UIView

/**
 开关状态发生变化后的回调block.
 */
@property (nonatomic, strong) SwitchChangedAction action;

/**
 开关开启后的背景色, 默认为DEFAULT_ON_COLOR.
 */
@property (nonatomic, strong) UIColor *onColor;

/**
 开关关闭后的背景色, 默认为[UIColor lightGrayColor].
 */
@property (nonatomic, strong) UIColor *offColor;

/**
 圆形按钮的颜色, 默认为[UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *buttonColor;



@end
